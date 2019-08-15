#!/bin/bash

if [ $# != 2 ]; then
	echo "Please provide SLAB name and count to monitor"
	echo "Example)"
	echo "$0 size-32 100"
	exit 1
fi

echo "Starting collecting SLAB usage for $1 for $2 times"
echo "--------------------------------------------------"
slabtop --once > before_check.txt
echo "1) Saved slabtop output before starting script"
echo
echo "2) Starting systemtap script"
echo
stap -g --suppress-time-limits -v --all-modules -o stap_result.txt kmem_alloc_free.stp $1 $2
echo "3) Completed systemtap script"
echo
slabtop --once > after_check.txt
echo "4) Saved slabtop output after the script"

echo
echo "Please share the below files with our engineers"
echo "   before_check.txt"
echo "   after_check.txt"
echo "   stap_result.txt"
echo
