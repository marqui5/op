#!/usr/bin/env python
import os
auto = os.popen('apt-get install')
#print(auto.read())
lines = auto.readlines()
#print(lines[5:-2])
install = []
for line in lines[5:-2]:
    linedata = line.split(' ')
    for i in linedata:
        if(i != ''):
            install.append(i.replace('\n', ''))
print(install)
q = input(str(len(install)) + ' package will be set to manually installed.\nDo you want to continue? [Y/n]')
if(q == 'Y'):
    for autoinstall in install:
        out = os.popen('apt-get install ' + autoinstall)
        print(out.read())
