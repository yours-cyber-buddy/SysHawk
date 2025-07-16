#ServiceScanner.psm1

function Get-SuspiciousServices {
    Write-Host "`n[*] Scanning Services..." -ForegroundColor Cyan
    $services = Get-WmiObject -Class Win32_Service

$results = foreach ($service in $services) {
    $rawPath = $service.PathName
    if ([string]::IsNullOrWhiteSpace($rawPath)) { continue }

    $filePath = if ($rawPath -match '^"([^"]+)"') {
        $matches[1]
    } elseif ($rawPath -match '^(\S+\.exe)') {
        $matches[1]
    } else {
        continue
    }

    try {
        $exists = Test-Path $filePath -ErrorAction Stop
    } catch {
        $exists = $false
    }

    if (-not $exists) {
        return [PSCustomObject]@{
            ServiceName = $service.Name
            DisplayName = $service.DisplayName
            State       = $service.State
            FilePath    = $filePath
            Signer      = "N/A"
            Reason      = "File Not Found"
        }
    }

    try {
        $signature = (Get-AuthenticodeSignature -FilePath $filePath).SignerCertificate.Subject
    } catch {
        $signature = "Unsigned"
    }

    if ($signature -eq $null -or $signature -eq "") {
        $signature = "Unsigned"
    }

    if ($signature -eq "Unsigned" -or $signature -notmatch "Microsoft Corporation") {
        $reason = if ($signature -eq "Unsigned") { "Unsigned" } else { "Signed by $signature" }

        return [PSCustomObject]@{
            ServiceName = $service.Name
            DisplayName = $service.DisplayName
            State       = $service.State
            FilePath    = $filePath
            Signer      = $signature
            Reason      = $reason
        }
    }
}


    if ($results) {
        $results | Format-Table -AutoSize
    } else {
        Write-Host "No suspicious services found." -ForegroundColor Green
    }
}

Export-ModuleMember -Function Get-SuspiciousServices
