$lines = get-Content example.txt
$nrs = $lines[0].split(",")
$lines = $lines[2..$lines.count]
$maxTurns = 5
$maxTurnsBoard = $null
$currentBoard = ""


for($row = 0;$row -lt $lines.count;$row+=1){
    $currentBoard += " " + $lines[$row]
    if(($row+1)%6 -eq 5){
        $currentBoard = @{ board=$currentBoard.split(" ",40,1);index=[int[]]::new(25);turns=0}
        $currentBoard.index = $nrs | %{$currentBoard.board.indexof($_)}

        for($turns=$maxTurns;$true;$turns++){
            $vertical = $currentBoard.index[0..($turns-1)] | where {$_ -gt -1} |  %{($_+1)%6} | group | sort -property count -descending| select -first 1 -expandproperty count
            $horizontal = $currentBoard.index[0..($turns-1)] | where {$_ -gt -1} | %{[Math]::floor(($_)/5)} | group | sort -property count -descending | select -first 1 -expandproperty count
            write-host "Board ending at row $($row) got $($turns) turns. $($vertical) $($horizontal)"
            
            if($horizontal -eq 5 -or $vertical -eq 5){
                write-host $horizontal $vertical
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
write-host $maxTurnsBoard.board
$sum = 0
$turnIndexes = $maxTurnsBoard.index[0..($maxTurns-1)]
$maxTurnsBoard.board | where { $turnIndexes -notcontains $maxTurnsBoard.board.indexof($_)} | %{$sum+=$_}
write-host $($sum*$maxTurnsBoard.board[$maxTurnsBoard.index[$maxTurns-1]])
