ps aux | grep 'harpServer\|harp server' | awk '{print $2}' | xargs kill
exit 0
