$lines = get-content input.txt
$separators = " -> ", ","
$map = @{}
foreach($line in $lines){
    $parts = $line.split($separators,[System.StringSplitOptions]::RemoveEmptyEntries) | % {[int]$_}
    $xs = $parts[0],$parts[2] |sort
    $ys = $parts[1],$parts[3] | sort
    if($xs[0] -ne $xs[1] -and $ys[0] -ne $ys[1]){
        continue;
    }
    for($x = $xs[0];$x -le $xs[1];$x++){
        for($y=$ys[0];$y -le $ys[1];$y++){
            if($null -eq $map[$x]){ $map[$x] = @{}}
            $map[$x][$y] += 1
            #Write-Host "Adding one for x:$($x),y:$($y)"
        }
    }
}
$map.GetEnumerator() | %{$_.Value.GetEnumerator() | ? {$_.Value -gt 1} } | measure-object | select-object -expandproperty count
#$map
