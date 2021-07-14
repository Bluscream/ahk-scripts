Get-ChildItem "C:\Users\gerhardl\Documents\My Received Files" -Filter *.log | 
Foreach-Object {
    $content = Get-Content $_.FullName

    #filter and save content to the original file
    $content | Where-Object {$_ -match 'step[49]'} | Set-Content $_.FullName

    #filter and save content to a new file 
    $content | Where-Object {$_ -match 'step[49]'} | Set-Content ($_.BaseName + '_out.log')
}

/*
for ($i=0; $i -lt $files.Count; $i++) {
    $outfile = $files[$i].FullName + "out" 
    Get-Content $files[$i].FullName | Where-Object { !($_ -match 'step4' -or $_ -match 'step9') } | Set-Content $outfile
}
*/