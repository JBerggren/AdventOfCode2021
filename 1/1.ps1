$lines = get-Content input.txt | %{[int]$_.Trim()}
$i=1
$sum=0

while($i -lt $lines.Count){
    if($lines[$i-1] -lt $lines[$i]){
        $sum+=1
    }
    $i+=1
}
write-host "$($sum) lines increased"