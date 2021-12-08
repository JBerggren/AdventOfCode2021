$lines = get-Content input.txt
$pos = 0
$oxygenNumbers = $lines
while ($oxygenNumbers.count -ne 1){
    $oxygenNumbers = $oxygenNumbers | group-object {$_[$pos]} | sort -property Count,Name -descending | select-object -first 1 -expandproperty group
    $pos +=1
}

$pos=0
$scrubberNumbers = $lines
while ($scrubberNumbers.count -ne 1){
    $scrubberNumbers = $scrubberNumbers | group-object {$_[$pos]} | sort -property Count,Name | select-object -first 1 -expandproperty group
    $pos +=1
}

write-host $scrubberNumbers


$oxygen = [convert]::ToInt32($oxygenNumbers,2)
$scrubber = [convert]::ToInt32($scrubberNumbers,2)
write-host "Oxygen $($oxygen), Scrubber $($scrubber), Value $($oxygen*$scrubber)"
