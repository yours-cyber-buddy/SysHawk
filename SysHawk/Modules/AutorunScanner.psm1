# AutorunScanner.psm1 (Minimal but clear output)

function Get-SuspiciousAutoruns {
    Write-Host "`n[+] Scanning Autoruns..." -ForegroundColor Yellow

    $autorunKeys = @{
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" = "HKLM"
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" = "HKCU"
    }

    foreach ($key in $autorunKeys.Keys) {
        $source = $autorunKeys[$key]
        if (Test-Path $key) {
            Get-ItemProperty $key | ForEach-Object {
                foreach ($property in $_.PSObject.Properties) {
                    # Skip default property fields like PSPath, PSDrive, etc.
                    if ($property.Name -like 'PS*') { continue }

                    $raw = $property.Value
                    if (-not $raw) { continue }

                    # Try to extract the actual path (first token in quotes or before first space)
                    if ($raw -match '"([^"]+)"') {
                        $path = $matches[1]
                    } else {
                        $path = $raw.Split(" ")[0]
                    }

                    if (-not (Test-Path $path)) {
                        Write-Host "[!] Autorun entry with missing file: $($property.Name)" -ForegroundColor Red
                        Write-Host "    Path: $raw"
                    }
                }
            }
        }
    }
}

Export-ModuleMember -Function Get-SuspiciousAutoruns
