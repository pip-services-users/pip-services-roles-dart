#!/usr/bin/env pwsh

Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

$component = Get-Content -Path "component.json" | ConvertFrom-Json
$image="$($component.registry)/$($component.name):$($component.version)-$($component.build)-rc"
$latestImage="$($component.registry)/$($component.name):latest"

# Build docker image
docker build -f docker/Dockerfile -t $image -t $latestImage .

# Set environment variables
$env:IMAGE = $image

try {
    # Workaround to remove dangling images
    docker-compose -f ./docker/docker-compose.yml down

    docker-compose -f ./docker/docker-compose.yml up -d

    Start-Sleep -Seconds 10
    Invoke-WebRequest -Uri http://localhost:8080/heartbeat
    # Invoke-WebRequest -Uri http://localhost:8080/v1/roles/get_roles_by_filter

    Write-Host "The container was successfully built."
    
    # Save the result to avoid overwriting it with the "down" command below
    $exitCode = $LastExitCode 
} finally {
    docker-compose -f ./docker/docker-compose.yml down
}

# Return the exit code of the "docker-compose.yml up" command
exit $exitCode 
