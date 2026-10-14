#!/bin/bash
count=$(checkupdates 2>/dev/null | wc -l)

if [ "$count" -gt 0 ]; then
    echo "{\"text\": \"󰏔 $count\", \"tooltip\": \"$count pending updates\", \"class\": \"pending\"}"
else
    echo '{"text": "", "class": "none"}'
fi
