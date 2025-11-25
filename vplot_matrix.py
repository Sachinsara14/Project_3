import sys

def main():
    # 1. Initialize dictionary: Key=(Midpoint, Length), Value=Count
    matrix = {}

    # 2. Read from Standard Input (pipe)
    for line in sys.stdin:
        line = line.strip()
        # Skip header or empty lines
        if not line or line.startswith("#") or line.startswith("track"):
            continue

        try:
            parts = line.split()
            # BED Columns: 1=Start, 2=End
            start = int(parts[1])
            end = int(parts[2])

            # 3. Calculate Fragment Length (Y-axis)
            length = end - start

            # 4. Calculate Genomic Midpoint (X-axis)
            midpoint = (start + end) // 2

            # Filter: Only keep fragments <= 1000bp (Standard for V-plots)
            if 0 < length <= 1000:
                key = (midpoint, length)
                matrix[key] = matrix.get(key, 0) + 1

        except (ValueError, IndexError):
            continue

    # 5. Output Matrix in Long Form
    print("offset\tfragment_length\tcount")

    # Sort by Offset so the file is organized
    for (mid, length), count in sorted(matrix.items()):
        print(f"{mid}\t{length}\t{count}")

if __name__ == "__main__":
    main()