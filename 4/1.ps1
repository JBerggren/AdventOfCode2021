$lines = get-Content input.txt
$nrs = $lines[0].split(",")
$lines = $lines[2..$lines.count]
$leastTurns = $nrs.count
$leastTurnsBoard = $null
$currentBoard = ""


for($row = 0;$row -lt $lines.count;$row+=1){
    $currentBoard += " " + $lines[$row]
    if(($row+1)%6 -eq 5){
        $currentBoard = @{ board=$currentBoard.split(" ",40,1);index=[int[]]::new(25)}
        $currentBoard.index = $nrs | %{$currentBoard.board.indexof($_)}

        for($turns=$leastTurns;$true;$turns--){
            $vertical = $currentBoard.index[0..($turns-1)] | where {$_ -gt -1} |  %{($_)%5} | group | sort -property count -descending| select -first 1 -expandproperty count
            $horizontal = $currentBoard.index[0..($turns-1)] | where {$_ -gt -1} | %{[Math]::floor(($_)/5)} | group | sort -property count -descending | select -first 1 -expandproperty count
            if($horizontal -ne 5 -and $vertical -ne 5){
                break
            }
        }
        $turns +=1
        if(($turns-1) -lt $leastTurns){
            $leastTurns = $turns
            $leastTurnsBoard = $currentBoard
        }
        $row+=1
        $currentBoard = ""
    }
}
$sum = 0
$turnIndexes = $leastTurnsBoard.index[0..($leastTurns-1)]
$leastTurnsBoard.board | where { $turnIndexes -notcontains $leastTurnsBoard.board.indexof($_)} | %{$sum+=$_}
write-host $($sum*$leastTurnsBoard.board[$leastTurnsBoard.index[$leastTurns-1]])
