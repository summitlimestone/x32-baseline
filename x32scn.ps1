$Path = './BASELINE.scn'

$InputData = Get-Content -Path $Path

$result = [PSCustomObject]@{
    config = [PSCustomObject]@{}
}
$ok = @()
ForEach($l in $InputData) {
    if($l[0] -eq '#') { continue }
    $linedata = $l -split ' '
    $linepath = $linedata[0]
    $linedir = $linepath -split '/'
    if($linedir[1] -eq 'config') {
        $ok += $linedir[2]
    }
}

$ok | Sort-Object -Unique