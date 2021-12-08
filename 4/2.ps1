$lines = get-Content input.txt
$nrs = $lines[0].split(",")
$lines = $lines[2..$lines.count]
$maxTurns = 5
$maxTurnsBoard = $null
$currentBoard = ""


for($row = 0;$row -lt $lines.count;$row+=1){
    $currentBoard += " " + $lines[$row]
    if(($row+1)%6 -eq 5){
        $currentBoard = @{ board=$currentBoard.split(" ",40,1);index=[int[]]::new(25)}
        $currentBoard.index = $nrs | %{$currentBoard.board.indexof($_)}

        for($turns=$maxTurns;$turns -lt $nrs.count;$turns++){
            $vertical = $currentBoard.index[0..($turns-1)] | where {$_ -gt -1} |  %{($_)%5} | group | sort -property count -descending| select -first 1 -expandproperty count
            $horizontal = $currentBoard.index[0..($turns-1)] | where {$_ -gt -1} | %{[Math]::floor(($_)/5)} | group | sort -property count -descending | select -first 1 -expandproperty count
            if($horizontal -eq 5 -or $vertical -eq 5){
                break
            }
        }
        if($turns -gt $maxTurns){
            $maxTurns = $turns
            $maxTurnsBoard = $currentBoard
        }
        $row+=1
        $currentBoard = ""
    }
}
$sum = 0
$turnIndexes = $maxTurnsBoard.index[0..($maxTurns-1)]
$maxTurnsBoard.board | where { $turnIndexes -notcontains $maxTurnsBoard.board.indexof($_)} | %{$sum+=$_}
write-host $($sum*$maxTurnsBoard.board[$maxTurnsBoard.index[$maxTurns-1]])
