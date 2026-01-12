#!/usr/bin/env python3
import sys

def convert_hex_to_swift(hex_str):
    """
    Converts a hex string (separated by ':' or spaces) into a pretty-formatted Swift UInt8 array.
    """
    # Replace colons with spaces and split into individual hex components
    clean_str = hex_str.replace(':', ' ').strip()
    hex_values = clean_str.split()
    
    # Format each hex value to be 0x prefixed and lowercase
    swift_values = []
    for h in hex_values:
        # Strip any existing 0x prefix if user provides it
        clean_hex = h.lower().replace('0x', '')
        # Ensure it's a valid hex byte (could add more validation here)
        if clean_hex:
            swift_values.append(f"0x{clean_hex}")
    
    if not swift_values:
        return "[]"
        
    # Build rows with at most 8 values per row
    rows = []
    for i in range(0, len(swift_values), 8):
        row_values = swift_values[i:i+8]
        rows.append("    " + ", ".join(row_values))
    
    # Join rows with commas and newlines
    return "[\n" + ",\n".join(rows) + "\n]"

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 hex_to_swift.py \"b9:ba:f0:...\"")
        print("Example: python3 hex_to_swift.py b9:ba:f0:41:10:01:05:0d:12:7f:00:01:00:00:00:00:ba:f7")
        sys.exit(1)
    
    # Join all arguments to handle unquoted input with spaces
    input_str = " ".join(sys.argv[1:])
    
    result = convert_hex_to_swift(input_str)
    print(result)
