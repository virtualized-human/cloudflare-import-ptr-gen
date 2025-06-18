#!/bin/bash
file=$1
output=$2
touch $output
truncate -s 0 $output
echo ";; PTR Records" >> $output
while IFS= read -r line; do
    # Split the line on the keyword 'content'
    ip="${line%%,*}"   # Everything before the first comma
    name="${line#*,}"      # Everything after the first comma

    echo "$(python3 -c "import ipaddress, sys; print(ipaddress.ip_address(sys.argv[1]).reverse_pointer)" $ip). 1 IN PTR $name. ; $ip" >> $output
done < "$file"
