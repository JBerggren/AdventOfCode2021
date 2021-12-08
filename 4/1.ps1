$lines = get-Content example.txt
$nrs = $lines[0].split(",")
$lines = $lines[2..$lines.count]
$boards = [PSObject[]]::new($lines.count/6)
$board = 0
$leastTurns = 25
$leastTurnsBoard = $null
#Remake
#We dont have to remember all boards, just the best board
for($row = 0;$row -lt $lines.count;$row+=1){
    $boards[$board] += " " + $lines[$row]
    if(($row+1)%6 -eq 5){
        $boards[$board] = @{ board=$boards[$board].split(" ",40,1);index=[int[]]::new(25);turns=50}
        $boards[$board].index = $nrs | %{$boards[$board].board.indexof($_)}

        for($turns=4;$turns -lt $nrs.count;$turns++){
            $vertical = $boards[$board].index[0..$turns] | where {$_ -gt -1} |  %{($_+1)%6} | group | sort -property count -descending| select -first 1 -expandproperty count
            $horizontal = $boards[$board].index[0..$turns] | where {$_ -gt -1} | %{[Math]::floor(($_)/5)} | group | sort -property count -descending | select -first 1 -expandproperty count
            if($horizontal -eq 5 -or $vertical -eq 5){
                $boards[$board].turns = $turns+1
                break
            }
        }
        if($boards[$board].turns -lt $leastTurns){
            $leastTurns = $boards[$board].turns
            $leastTurnsBoard = $boards[$board]
        }
        $row+=1
        $board+=1
    }
}
write-host $leastTurns
$sum = 0
$turnIndexes = $leastTurnsBoard.index[0..($leastTurns-1)]
$leastTurnsBoard.board | where { $turnIndexes -notcontains $leastTurnsBoard.board.indexof($_)} | %{$sum+=$_}
write-host $($sum*$leastTurnsBoard.board[$leastTurnsBoard.index[$leastTurns-1]])
