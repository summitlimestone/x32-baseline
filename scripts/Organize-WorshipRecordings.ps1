$RootPath = 'D:\audio\worship'
$Extension = 'mp3'

Get-ChildItem $RootPath | ForEach-Object {
    $item = $_
    $base = $item.Name.Split('-')[0]

    try {
        $time = [int]$item.Name.Split('-')[1].Split('.')[0]
    } catch {
        Write-Warning "Skipping $($item.Name)"
        return
    }

    $suffix = ''
    switch($time) {
        { ($_ -gt 10000) -and ($_ -lt 093000) } { $suffix = '09-s1' }
        { ($_ -ge 093000) -and ($_ -lt 104500) } { $suffix = '09-s2' }
        { ($_ -ge 104500) -and ($_ -lt 113000) } { $suffix = '11-s1' }
        { ($_ -gt 113000) -and ($_ -lt 235959) } { $suffix = '11-s2' }
        Default {
            Write-Warning "Skipping $($item.Name)"
                return
        }
    }
    Write-Host "$($item.FullName) --> $(Join-Path $RootPath "$base-$suffix.$Extension")"

    try {
        Move-Item $($item.FullName) $(Join-Path $RootPath "$base-$suffix.$Extension")
    } catch {
        Write-Warning "Skipping $($item.Name)"
        return
    }
}
