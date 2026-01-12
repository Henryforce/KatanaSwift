import sys
import subprocess

hex_data = """
b9:ba:f0:41:10:01:05:0d:12:7f:00:01:00:00:00:00:ba:f7
84:f0:f0:41:10:01:05:0d:12:7f:00:01:00:00:01:7f:f0:f7
ba:96:f0:41:10:01:05:0d:12:7f:00:01:00:00:02:7e:96:f7
a1:f5:f0:41:10:01:05:0d:12:7f:00:01:00:00:03:7d:f5:f7
bf:a1:f0:41:10:01:05:0d:12:7f:00:01:00:00:04:7c:a1:f7
97:bb:f0:41:10:01:05:0d:12:7f:00:01:00:00:05:7b:bb:f7
b4:c7:f0:41:10:01:05:0d:12:7f:00:01:00:00:06:7a:c7:f7
8c:d3:f0:41:10:01:05:0d:12:7f:00:01:00:00:07:79:d3:f7
aa:88:f0:41:10:01:05:0d:12:7f:00:01:00:00:08:78:88:f7
82:da:f0:41:10:01:05:0d:12:7f:00:01:00:00:09:77:da:f7
9b:d2:f0:41:10:01:05:0d:12:7f:00:01:00:00:0a:76:d2:f7
81:b5:f0:41:10:01:05:0d:12:7f:00:01:00:00:0b:75:b5:f7
96:b2:f0:41:10:01:05:0d:12:7f:00:01:00:00:0c:74:b2:f7
af:92:f0:41:10:01:05:0d:12:7f:00:01:00:00:0d:73:92:f7
87:da:f0:41:10:01:05:0d:12:7f:00:01:00:00:0e:72:da:f7
b3:fa:f0:41:10:01:05:0d:12:7f:00:01:00:00:0f:71:fa:f7
97:9b:f0:41:10:01:05:0d:12:7f:00:01:00:00:10:70:9b:f7
9a:dd:f0:41:10:01:05:0d:12:7f:00:01:00:00:11:6f:dd:f7
b0:e9:f0:41:10:01:05:0d:12:7f:00:01:00:00:12:6e:e9:f7
8a:c0:f0:41:10:01:05:0d:12:7f:00:01:00:00:13:6d:c0:f7
a3:ef:f0:41:10:01:05:0d:12:7f:00:01:00:00:14:6c:ef:f7
bb:c9:f0:41:10:01:05:0d:12:7f:00:01:00:00:15:6b:c9:f7
99:80:f0:41:10:01:05:0d:12:7f:00:01:00:00:16:6a:80:f7
b2:93:f0:41:10:01:05:0d:12:7f:00:01:00:00:17:69:93:f7
a1:cf:f0:41:10:01:05:0d:12:7f:00:01:00:00:18:68:cf:f7
b7:f3:f0:41:10:01:05:0d:12:7f:00:01:00:00:19:67:f3:f7
91:f8:f0:41:10:01:05:0d:12:7f:00:01:00:00:1a:66:f8:f7
a9:8f:f0:41:10:01:05:0d:12:7f:00:01:00:00:1b:65:8f:f7
87:c7:f0:41:10:01:05:0d:12:7f:00:01:00:00:1c:64:c7:f7
9d:c8:f0:41:10:01:05:0d:12:7f:00:01:00:00:1d:63:c8:f7
"""

presets = [
    "preset1A", "preset1B", "preset1C",
    "preset2A", "preset2B", "preset2C",
    "preset3A", "preset3B", "preset3C",
    "preset4A", "preset4B", "preset4C",
    "preset5A", "preset5B", "preset5C",
    "preset6A", "preset6B", "preset6C",
    "preset7A", "preset7B", "preset7C",
    "preset8A", "preset8B", "preset8C",
    "preset9A", "preset9B", "preset9C",
    "preset10A", "preset10B", "preset10C"
]

lines = [line.strip() for line in hex_data.strip().split("\n") if line.strip()]

def convert_hex_to_swift(hex_str):
    clean_str = hex_str.replace(':', ' ').strip()
    hex_values = [f"0x{h.lower().replace('0x', '')}" for h in clean_str.split() if h]
    
    rows = []
    for i in range(0, len(hex_values), 8):
        row_values = hex_values[i:i+8]
        rows.append("        " + ", ".join(row_values))
    
    return "[\n" + ",\n".join(rows) + ",\n      ]"

for preset, hex_val in zip(presets, lines):
    result = convert_hex_to_swift(hex_val)
    print(f"    case .{preset}:")
    print(f"      return {result}")
