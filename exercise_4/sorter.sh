#!/bin/bash

grep -Eo "[[:space:]][0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}[[:space:]]" log_sample.log | sort | uniq -c | sort -r
