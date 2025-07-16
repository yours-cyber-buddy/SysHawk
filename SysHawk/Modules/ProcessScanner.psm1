# ProcessScanner.psm1 (Simplified)

function Get-SuspiciousProcesses {
    $allProcesses = Get-CimInstance Win32_Process

    $simpleOutput = foreach ($proc in $allProcesses) {
        [PSCustomObject]@{
            'Process Name' = $proc.Name
            'PID'          = $proc.ProcessId
            'File Path'    = $proc.ExecutablePath
        }
    }

    if ($simpleOutput.Count -eq 0) {
        Write-Host "`nNo processes found." -ForegroundColor Green
    } else {
        Write-Host "`nProcesses List:" -ForegroundColor Cyan
        $simpleOutput | Format-Table -AutoSize
    }
}

Export-ModuleMember -Function Get-SuspiciousProcesses