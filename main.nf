workflow {
    print_config() | view
}

process print_config {
    label 'group_top'
    label 'group_bottom'
    label 'cpu_setting'
    label 'memory_setting'
    label 'time_setting'

    output:
   	 stdout
    script:
    """
    echo "Process config:"
    echo "CPU: $task.cpus"
    echo "Memory: $task.memory"
    echo "Time: $task.time"
    """

}
