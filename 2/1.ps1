$x=0; $y=0
$lines = get-Content input.txt
foreach($line in $lines){
    $action = $line.split(" ")[0];
    $steps = [int]$line.split(" ")[1];
    switch($action){
        "forward" { $x+=$steps}
        "down" { $y+=$steps}
        "up" { $y-=$steps}
    }
}
write-host "x=$($x), y=$($y), result=$($x*$y)"