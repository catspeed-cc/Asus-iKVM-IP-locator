param(
    [Parameter(Mandatory = $true)]
    [string]
    $IPRange,

    [Parameter(Mandatory = $false)]
    [int]
    $Timeout = 250
)

# Validate IPRange format (basic check)
if (-not ($IPRange -match '^\d{1,3}\.\d{1,3}\.\d{1,3}$')) {
    Write-Error "Invalid IPRange format. Use a network prefix like '192.168.10'."
    exit 1
}

Write-Host "Scanning network $IPRange.x for BMCs (port 443 + 623)..." -ForegroundColor Yellow

for ($i = 1; $i -le 254; $i++) {
    $IP = "$IPRange.$i"
    Write-Host "Checking $IP... " -NoNewline

    $port443Open = $false
    $port623Open = $false

    # Test port 443 (HTTPS/Redfish)
    $socket1 = New-Object System.Net.Sockets.TcpClient
    $connect1 = $socket1.BeginConnect($IP, 443, $null, $null)
    $wait1 = $connect1.AsyncWaitHandle.WaitOne($Timeout, $false)

    if ($wait1) {
        try {
            $socket1.EndConnect($connect1)
            $port443Open = $true
        } catch { }
    }
    $socket1.Close()

    # Test port 623 (IPMI)
    $socket2 = New-Object System.Net.Sockets.TcpClient
    $connect2 = $socket2.BeginConnect($IP, 623, $null, $null)
    $wait2 = $connect2.AsyncWaitHandle.WaitOne($Timeout, $false)

    if ($wait2) {
        try {
            $socket2.EndConnect($connect2)
            $port623Open = $true
        } catch { }
    }
    $socket2.Close()

    # Output result
    if ($port443Open -and $port623Open) {
        Write-Host "✅ BMC LIKELY at $IP (443 + 623 open)" -ForegroundColor Green
    }
    elseif ($port443Open) {
        Write-Host "⚠️  HTTPS open, but no IPMI (port 623 closed)" -ForegroundColor Cyan
    }
    elseif ($port623Open) {
        Write-Host "🔍 IPMI detected (port 623), but no HTTPS" -ForegroundColor Magenta
    }
    else {
        Write-Host "❌ No response" -ForegroundColor DarkGray
    }
}

Write-Host "Scan complete." -ForegroundColor Yellow   
