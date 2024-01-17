workflow {
    print_config() | view
}

process print_config {
    label 'label_top'
    label 'label_bottom'

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
