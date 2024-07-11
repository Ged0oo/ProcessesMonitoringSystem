#!/usr/bin/bash -i

source process_monitor.conf

list_processes()
{
    clear
    
    echo ""
    echo "**********< List Running Processes >**********" 
    echo ""

    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11
    
    echo ""
    echo "< Return > : Press Enter"    
    read value
}

process_info() 
{
    clear
    
    echo ""
    echo "**********< List Process Information >**********" 
    echo ""

    read -p "* Enter PID : " pid
    echo "* Fetching information for process $pid ..."
    ps -p $pid -o pid,ppid,user,%cpu,%mem,etime,args

    echo ""
    echo "< Return > : Press Enter"    
    read value
}

process_kill() 
{
    clear
    
    echo ""
    echo "**********< List Process Information >**********" 
    echo ""

    read -p "* Enter PID : " pid
    echo "* Fetching information for process $pid ..."
    kill -9 $pid
    echo "* Process $pid terminated."

    echo ""
    echo "< Return > : Press Enter"    
    read value
}

process_statistics() 
{
    clear
    
    echo ""
    echo "**********< List Process Information >**********" 
    echo ""

    echo
    total_processes=$(ps aux | wc -l)
    echo "* Total number of processes: $total_processes"
    echo

    echo "* Top memory-consuming processes:"
    ps aux --sort=-%mem | head -n 6 | awk 'NR>1 {print "PID:", $2, "\t%MEM:", $4, "\t%CPU:", $3, "\tCOMMAND:", $11}'
    echo

    echo "* Top CPU-consuming processes:"
    ps aux --sort=-%cpu | head -n 6 | awk 'NR>1 {print "PID:", $2, "\t%CPU:", $3, "\t%MEM:", $4, "\tCOMMAND:", $11}'

    echo ""
    echo "< Return > : Press Enter"    
    read value
}

process_real_time_monitoring()
{
    clear
    
    echo ""
    echo "**********< List Process Information >**********" 
    echo ""

    while true;
    do
        clear
        date
        ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11
        sleep ${UPDATE_INTERVAL}
    done

    echo ""
    echo "< Return > : Press Enter"    
    read value
}

process_search_filter() 
{
    clear
    
    echo ""
    echo "**********< List Process Information >**********" 
    echo ""

    read -p "* Enter search criteria (name, pid, user, command): " key
    read -p "* Enter value to filter: " value

    echo "* Listing running processes ..."

    if [[ -n "$key" && -n "$value" ]]; 
    then
        case "$key" in
            name) ps -eo pid,comm,%cpu,%mem,user --sort=-%cpu | grep -i "$value" ;;
            pid) ps -eo pid,comm,%cpu,%mem,user --sort=-%cpu | grep -i "$value" ;;
            user) ps -eo pid,comm,%cpu,%mem,user --sort=-%cpu | grep -i "$value" ;;
            command) ps -eo pid,comm,%cpu,%mem,user --sort=-%cpu | grep -i "$value" ;;
            *) echo "* Invalid search criteria. Available options: name, pid, user, command." ;;
        esac
    else
        ps -eo pid,comm,%cpu,%mem,user --sort=-%cpu | head -n 11
    fi

    echo ""
    echo "< Return > : Press Enter"    
    read value
}