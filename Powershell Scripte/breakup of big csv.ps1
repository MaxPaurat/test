#breaking up large excel files

$reader = New-Object System.IO.StreamReader("C:\Users\Max\Documents\polybox\Masterthesis Mobile Data\Projekte\Masterthesis Mobile Data\test\Data - temporary place to copy to WCP for current computation\SET1V_01.csv")
$upperBound = 2500000
$fileCount = 1
$newFilename = "C:\Users\Max\Documents\polybox\Masterthesis Mobile Data\Projekte\Masterthesis Mobile Data\test\Data - temporary place to copy to WCP for current computation\SET1V_01{0}.csv" -f ($fileCount)
while(($line = $reader.ReadLine()) -ne $null){
    Add-Content -path $newFilename -value $line
    If((Get-ChildItem -path $newFilename).Length -ge $upperBound){
        ++$fileCount
        $newFilename = "C:\Users\Max\Documents\polybox\Masterthesis Mobile Data\Projekte\Masterthesis Mobile Data\test\Data - temporary place to copy to WCP for current computation\SET1V_01{0}.csv" -f ($fileCount)
    }
}
$reader.Close()