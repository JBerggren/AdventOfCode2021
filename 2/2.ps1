$x=0; $y=0;$aim=0
$lines = get-Content input.txt
foreach($line in $lines){
    $action = $line.split(" ")[0];
    $steps = [int]$line.split(" ")[1];
    switch($action){
        "forward" { $x+=$steps;$y+=$aim*$steps}
        "down" { $aim+=$steps}
        "up" { $aim-=$steps}
    }
}
write-host "x=$($x), y=$($y), result=$($x*$y)"