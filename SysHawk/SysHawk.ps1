# SysHawk.ps1

# Import main SysHawk module
Import-Module "$PSScriptRoot\SysHawk.psm1" -Force
Write-Host "`n[+] SysHawk module loaded successfully" -ForegroundColor Green

Write-Host "`n=== SysHawk Threat Analysis Tool ===" -ForegroundColor Cyan

Write-Host "Choose a scan to run:"
Write-Host "[1] Scan Processes"
Write-Host "[2] Scan Services"
Write-Host "[3] Scan Autoruns"
Write-Host "[4] Scan TCP Connections"
Write-Host "[5] Run Full System Scan"
Write-Host "[0] Exit"

$choice = Read-Host "Enter option number"

switch ($choice) {
    1 { Get-SuspiciousProcesses }
    2 { Get-SuspiciousServices }
    3 { Get-SuspiciousAutoruns }
    4 { Get-SuspiciousConnections }
    5 {
        Get-SuspiciousProcesses
        Get-SuspiciousServices
        Get-SuspiciousAutoruns
        Get-SuspiciousConnections
    }
    0 { Write-Host "Exiting..." }
    default { Write-Host "Invalid option!" }
}
