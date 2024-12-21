file_a = "file_a.txt"
file_b = "file_b.txt"

with open(file_b, 'r') as fb:
    lines_b = [line.strip() for line in fb]

newlines = []

with open(file_a, 'r') as fa:
    for line in fa:
        lines_a = line.split()
        if lines_a[0] in  lines_b:
            lines_a[3] = "15"
        newlines.append(" ".join(lines_a))


with open(file_a, 'w') as fa:
    fa.write("\n".join(newlines) + "\n")
    print(fa)
