#!/bin/bash
find ./bin -name "c*"
find usr/bin -name "*sh*" -type l
find /usr -type f | head -n 10
grep 'model name' /proc/cpuinfo
grep -v 'sudo' /etc/group | wc -l
grep 'sudo' /etc/group  -n
