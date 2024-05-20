#!/bin/bash

# Define the file to write data
output_file="usage_data.txt"

# Define the namespaces to monitor
namespaces=("tenant1" "tenant2" "tenant3")

# Main loop
while true; do
    # Get current timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    # Write timestamp to the output file
    echo "Timestamp: $timestamp" >> "$output_file"
    echo "" >> "$output_file"

    # Write header to the output file
    echo "Pod CPU and memory usage at $timestamp:" > "$output_file"
    
    # Loop through namespaces
    for namespace in "${namespaces[@]}"; do
        echo "Namespace: $namespace" >> "$output_file"
        
        # Get pod CPU and memory usage for the namespace and append to the output file
        kubectl top pods --namespace="$namespace" >> "$output_file"
        
        # Write a separator to the output file
        echo "" >> "$output_file"
    done
    
    # Write a separator between pod and node data
    echo "" >> "$output_file"
    echo "Node CPU and memory usage at $timestamp:" >> "$output_file"
    
    # Get node CPU and memory usage and append to the output file
    kubectl top nodes >> "$output_file"
    
    # Sleep for 1 minute
    sleep 60
done

