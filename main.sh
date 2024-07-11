#!/usr/bin/bash -i

source process_monitor.conf
source proc.sh

main()
{
    local ch
    while true;
    do
        clear
        
        echo ""
        echo "**********< Process Monitoring System >**********" 
        echo ""

        echo "1. List Running Processes"
        echo "2. Process Information"
        echo "3. Kill a Process"
        echo "4. Process Statistics"
        echo "5. Real-time Monitoring"
        echo "6. Search and Filter Processes"
        echo "7. Exit"

        echo ""
        read -p "Enter Your Choice : " ch

        case $ch in 
            1) list_processes ;;
            2) process_info ;;
            3) process_kill ;;
            4) process_statistics ;;
            5) process_real_time_monitoring ;;
            6) process_search_filter ;;
            7) exit ;;
        esac
    done
}

main