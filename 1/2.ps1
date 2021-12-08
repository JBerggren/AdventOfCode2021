$lines = get-Content input.txt | %{[int] $_}
$i=3
$sum=0

while($i -lt $lines.Count){ 
    if($lines[$i-3] -lt $lines[$i]) #Only need to compare the fields that differ
    {
        $sum +=1;
    }
    $i +=1
}
write-host "$($sum) lines increased"