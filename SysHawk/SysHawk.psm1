# SysHawk.psm1

# Import all functional modules
Import-Module "$PSScriptRoot\Modules\ProcessScanner.psm1" -Force
Import-Module "$PSScriptRoot\Modules\ServiceScanner.psm1" -Force
Import-Module "$PSScriptRoot\Modules\AutorunScanner.psm1" -Force
Import-Module "$PSScriptRoot\Modules\TCPScanner.psm1" -Force

# Export all public functions (optional, but clean)
Export-ModuleMember -Function `
    Get-SuspiciousProcesses,
    Get-SuspiciousServices,
    Get-SuspiciousAutoruns,
    Get-SuspiciousConnections
