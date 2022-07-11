# Build a dict with IPs as keys then sort descending by values

import re
import operator

with open('log_sample.log') as log:
    content = log.readlines()

pattern = re.compile("\s[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\s")

ipmap = {}

for line in content:
    ip = re.search(pattern, line)[0].replace(" ", "")
    if ip in ipmap:
        ipmap[ip] += 1
    else:
        ipmap[ip] = 1

for key, value in dict(sorted(ipmap.items(), key=operator.itemgetter(1), reverse=True)).items():
    print(value, key)
