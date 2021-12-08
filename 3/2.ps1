$lines = get-Content example.txt
$pos = 0
$oxygenLines = $lines
while ($oxygenLines.count -ne 1){
    write-host $oxygenLines
    $oxygenLines = $oxygenLines | group-object {$_[$pos]} | sort -property Count,Name -descending | select-object -first 1 -expandproperty group
    $pos +=1
}
write-host $oxygenLines


# $oxygen = [convert]::ToInt32($oxygenLines,2)
# $scrubber = [convert]::ToInt32($scrubberLines,2)
# write-host "Oxygen $($oxygen), Scrubber $($scrubber), Value $($oxygen*$scrubber)"

#3206016 was to low