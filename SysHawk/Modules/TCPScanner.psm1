#TCPScanner.psm1

function Get-SuspiciousConnections {
    Write-Host "`n[+] Scanning TCP Connections..." -ForegroundColor Yellow

    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq "Established" }

    $suspiciousConnections = @()

    foreach ($conn in $connections) {
        $proc = Get-Process -Id $conn.OwningProcess -ErrorAction SilentlyContinue
        $procName = if ($proc) { $proc.ProcessName } else { "Unknown" }

        $remote = $conn.RemoteAddress
        $local = $conn.LocalAddress
        $reasons = @()

        # Flag external IPs (not local or loopback)
        if ($remote -notmatch '^(127\.|10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1]))' -and $remote -ne "::1") {
            $reasons += "Non-local remote IP"
        }

        # Flag unknown process
        if ($procName -eq "Unknown") {
            $reasons += "Unknown process"
        }

        # Flag high local port usage
        if ($reasons.Count -gt 0 -and $conn.RemoteAddress -notlike "127.*" -and $conn.RemoteAddress -ne "::1") {
            $reasons += "High local port"
        }

        if ($reasons.Count -gt 0) {
            $suspiciousConnections += [PSCustomObject]@{
                'Process'         = $procName
                'PID'             = $conn.OwningProcess
                'Local Address'   = "$($conn.LocalAddress):$($conn.LocalPort)"
                'Remote Address'  = "$($conn.RemoteAddress):$($conn.RemotePort)"
                'Reason(s)'       = ($reasons -join ', ')
            }
        }
    }

    if ($suspiciousConnections.Count -eq 0) {
        Write-Host "`nNo suspicious TCP connections found." -ForegroundColor Green
    } else {
        Write-Host "`nSuspicious TCP Connections Detected:" -ForegroundColor Yellow
        $suspiciousConnections | Format-Table -AutoSize
    }
}

Export-ModuleMember -Function Get-SuspiciousConnections
