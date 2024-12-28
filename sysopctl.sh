#!/bin/bash

VERSION="v0.1.0"

# Help menu
function show_help {
  cat <<EOF
Usage: sysopctl [COMMAND] [OPTIONS]

System resource and task management tool.

Commands:
  --help                  Show this help message
  --version               Display version information

  service list            List all active services
  service start <name>    Start a service
  service stop <name>     Stop a service

  system load             Display system load averages
  disk usage              Show disk usage by partition

  process monitor         Monitor real-time system processes
  logs analyze            Analyze critical system logs
  backup <path>           Backup files to a predefined location

Examples:
  sysopctl --help
  sysopctl service list
  sysopctl system load
EOF
}

# Command handlers
case "$1" in
  --help)
    show_help
    ;;
  --version)
    echo "sysopctl $VERSION"
    ;;
  service)
    case "$2" in
      list)
        systemctl list-units --type=service
        ;;
      start)
        systemctl start "$3" && echo "Service $3 started successfully."
        ;;
      stop)
        systemctl stop "$3" && echo "Service $3 stopped successfully."
        ;;
      *)
        echo "Invalid service command. Use sysopctl --help for usage."
        ;;
    esac
    ;;
  system)
    case "$2" in
      load)
        uptime
        ;;
      *)
        echo "Invalid system command. Use sysopctl --help for usage."
        ;;
    esac
    ;;
  disk)
    case "$2" in
      usage)
        df -h
        ;;
      *)
        echo "Invalid disk command. Use sysopctl --help for usage."
        ;;
    esac
    ;;
  process)
    case "$2" in
      monitor)
        top
        ;;
      *)
        echo "Invalid process command. Use sysopctl --help for usage."
        ;;
    esac
    ;;
  logs)
    case "$2" in
      analyze)
        journalctl -p 3 -n 20
        ;;
      *)
        echo "Invalid logs command. Use sysopctl --help for usage."
        ;;
    esac
    ;;
  backup)
    rsync -avh "$2" backups/ && echo "Backup completed successfully."
    ;;
  *)
    echo "Invalid command. Use sysopctl --help for usage."
    ;;
esac
