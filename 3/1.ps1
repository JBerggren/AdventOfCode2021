$lines = get-Content input.txt
$digits = [int[]]::new($lines[0].Length)
0..($digits.length-1) | %{ $digits[$_] =0} #Zero array

foreach($line in $lines){
    for($i=0;$i -lt $line.length;$i++){
        if($line[$i] -eq "1"){
            $digits[$i] += 1
        }
    }
}
$gamaString =""
$digits | %{[Math]::Round($_/$lines.length,0)} | %{$gamaString += $_}
$gama = [convert]::ToInt32($gamaString,2)
$epsilon = $gama -bxor [convert]::ToInt32("".PadLeft($gamaString.length,"1"),2)

write-host "Gama $($gama), Epsilon $($epsilon), Multiplied $($gama*$epsilon)"

