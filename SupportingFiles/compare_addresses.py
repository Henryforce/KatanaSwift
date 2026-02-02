import re
import os

def addr_to_int(addr_str):
    if len(addr_str) != 8:
        return None
    try:
        b1 = int(addr_str[0:2], 16)
        b2 = int(addr_str[2:4], 16)
        b3 = int(addr_str[4:6], 16)
        b4 = int(addr_str[6:8], 16)
        return (b1 << 21) | (b2 << 14) | (b3 << 7) | b4
    except ValueError:
        return None

def parse_midi_doc(filepath):
    midi_addresses = []
    with open(filepath, 'r') as f:
        for line in f:
            if '|' in line:
                parts = [p.strip() for p in line.split('|')]
                if len(parts) >= 3:
                    name = parts[1]
                    addr_str = parts[2]
                    if addr_str.lower() != 'address (desc)' and re.match(r'^[0-9a-fA-F]{8}$', addr_str):
                        val = addr_to_int(addr_str)
                        if val is not None:
                            midi_addresses.append({'name': name, 'addr': addr_str, 'val': val})
    return midi_addresses

def get_swift_banks(root_dirs):
    banks = {} # name -> {addresses: [], size: 0}
    
    for root_dir in root_dirs:
        for root, _, files in os.walk(root_dir):
            for file in files:
                if file.endswith('.swift'):
                    filepath = os.path.join(root, file)
                    with open(filepath, 'r') as f:
                        content = f.read()
                        
                        # Find all struct/extension names
                        # We'll use a simple heuristic: find blocks and see if they contain address/size
                        # But actually it's easier to find all address/size and associate with the nearest preceding struct/extension.
                        
                        # Find address/size associated with types
                        # static let katanaGoAddress: UInt32 = 0x20_01_00_00
                        # static let size: UInt32 = 10
                        
                        # Instead, let's find all occurrences of address and size in the file and link them to the class/struct/extension
                        # A better way is to split the content by struct/extension
                        parts = re.split(r'(struct|extension|final\s+class)\s+(\w+)', content)
                        # parts[0] is header
                        # parts[1] is keyword, parts[2] is name, parts[3] is body
                        for i in range(1, len(parts), 3):
                            name = parts[i+1]
                            body = parts[i+2] if i+2 < len(parts) else ""
                            
                            if name not in banks:
                                banks[name] = {'addresses': [], 'size': 0}
                            
                            # Find addresses in this body
                            addr_matches = re.finditer(r'katanaGoAddress:\s*UInt32\s*=\s*0x([0-9a-fA-F_]+)', body)
                            for m in addr_matches:
                                addr_hex = m.group(1).replace('_', '').zfill(8)
                                val = addr_to_int(addr_hex)
                                if val is not None:
                                    banks[name]['addresses'].append(val)
                            
                            # Find size
                            size_match = re.search(r'static let size:\s*UInt32\s*=\s*(\d+)', body)
                            if size_match:
                                banks[name]['size'] = int(size_match.group(1))
                            else:
                                # Count parameters
                                param_offsets = re.findall(r'@(?:Integer)?Parameter\(at:\s*0x([0-9a-fA-F_]+)', body)
                                if param_offsets:
                                    max_off = 0
                                    for off in param_offsets:
                                        off_hex = off.replace('_', '')
                                        if len(off_hex) > 2:
                                            off_val = addr_to_int(off_hex.zfill(8))
                                        else:
                                            off_val = int(off_hex, 16)
                                        if off_val > max_off:
                                            max_off = off_val
                                    # Very rough size estimation if size let is missing
                                    if banks[name]['size'] <= max_off:
                                        banks[name]['size'] = max_off + 1
                                        # But wait, Roland UInt16 takes 4 bytes.
                                        # If we see UInt16 in the same line, we should add 4.
                                        # Let's just be generous or better, look for 'size' again.

    # Special handling for DataBank.swift
    databank_path = '/Users/henryforce/Developer/Github/KatanaGoSwift/Sources/KatanaGoMIDIKit/DataBank.swift'
    hardcoded_banks = []
    if os.path.exists(databank_path):
        with open(databank_path, 'r') as f:
            content = f.read()
            bank_sizes = re.findall(r'var\s+(\w+)\s*=\s*\[UInt8\]\(repeating:\s*0x00,\s*count:\s*(\d+)\)', content)
            sizes_dict = {name: int(count) for name, count in bank_sizes}
            updates = re.findall(r'applyUpdate\(\s*&(\w+),\s*bankBase:\s*\[(0x[0-9a-fA-F]+|\d+),\s*(0x[0-9a-fA-F]+|\d+),\s*(0x[0-9a-fA-F]+|\d+),\s*(0x[0-9a-fA-F]+|\d+)\]', content)
            for bank_name, b1, b2, b3, b4 in updates:
                def to_int(s):
                    if s.startswith('0x'): return int(s, 16)
                    return int(s)
                addr_val = (to_int(b1) << 21) | (to_int(b2) << 14) | (to_int(b3) << 7) | to_int(b4)
                size = sizes_dict.get(bank_name, 0)
                if size > 0:
                    hardcoded_banks.append({'name': f"DataBank.{bank_name}", 'base': addr_val, 'size': size})

    implemented = []
    for name, info in banks.items():
        if info['size'] > 0:
            for addr in info['addresses']:
                implemented.append({'name': name, 'base': addr, 'size': info['size']})
                # If it's a MOD address, we also cover the FX address if it's an FxBank
                # Any address starting with 20 01 0x xx is MOD.
                # Any address starting with 20 01 1x xx is FX.
                # Difference is 0x10 in the 3rd byte = 16 << 7 = 2048.
                mod_min = addr_to_int("20010000")
                mod_max = addr_to_int("2001017F")
                if mod_min <= addr <= mod_max:
                    fx_addr = addr + 2048
                    implemented.append({'name': f"{name} (FX)", 'base': fx_addr, 'size': info['size']})
                # KatanaGoMIDIKit.swift: let address: UInt32 = T.katanaGoAddress | (channel == .fx ? 0x00_00_10_00 : 0x00)
                # 0x20010000 -> 0x4004000
                # 0x20011000 -> 0x4006000 (wait, 0x10 << 7 = 0x800. No. 0x1 << 14 is 0x4000).
                # 0x00010000 Roland is b1=0x00, b2=0x01, b3=0x00, b4=0x00.
                # In Roland math: 0x01 << 14 = 0x4000.
                # So FX block starts at MOD_base + 0x4000.
                # MOD: [32, 1, 0, 0] -> 20010000
                # FX:  [32, 1, 16, 0] -> 20011000.
                # Difference in int val: (16 << 7) = 2048 = 0x800.
                
                # Wait, let's look at KatanaGoMIDIKit.swift again.
                # address = T.katanaGoAddress | (channel == .fx ? 0x00_00_10_00 : 0x00)
                # T.katanaGoAddress is 0x200100xx.
                # 0x00001000 = [0, 0, 0x10, 0]
                # In Roland math, this is 16 << 7 = 2048.
                

    implemented.extend(hardcoded_banks)
    return implemented

def main():
    midi_doc = '/Users/henryforce/Developer/Github/KatanaGoSwift/SupportingFiles/KATANA_MIDI_ADDRESSES.md'
    src_dirs = [
        '/Users/henryforce/Developer/Github/KatanaGoSwift/Sources/KatanaFx',
        '/Users/henryforce/Developer/Github/KatanaGoSwift/Sources/KatanaGoData',
        '/Users/henryforce/Developer/Github/KatanaGoSwift/Sources/KatanaGoMIDIKit'
    ]
    
    midi_addresses = parse_midi_doc(midi_doc)
    implemented_banks = get_swift_banks(src_dirs)
    
    missing = []
    for item in midi_addresses:
        covered = False
        for bank in implemented_banks:
            if bank['base'] <= item['val'] < bank['base'] + bank['size']:
                covered = True
                break
        if not covered:
            missing.append(item)
            
    with open('missing_addresses.md', 'w') as f:
        f.write('# Missing MIDI Addresses\n\n')
        f.write('The following addresses are defined in `KATANA_MIDI_ADDRESSES.md` but not found in the source code implementation.\n\n')
        f.write('| Name | Address | Hex Value |\n')
        f.write('| :--- | :--- | :--- |\n')
        for item in missing:
            f.write(f"| {item['name']} | {item['addr']} | 0x{item['val']:X} |\n")
            
    print(f"Found {len(missing)} missing addresses.")

if __name__ == "__main__":
    main()
