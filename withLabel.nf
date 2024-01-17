workflow {
    TASK() | view
}

process TASK {
    label 'process_top'
    label 'process_bottom'

    input: 
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
