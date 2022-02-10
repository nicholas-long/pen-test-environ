#!/usr/bin/python3

while not input().startswith("```"): pass
while True:
    line = input()
    if line.startswith("```"):
        break
    else:
        print(line)
