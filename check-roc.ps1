<#

	.SYNOPSIS


	.DESCRIPTION


	.EXAMPLE


	.NOTES
  Not completely working at the moment.

	.LINK


#>

#$request.GetType()
#$request|Get-Member
#$request.Headers
## | Where-Object {$_.InnerHTML -like "*Oskar*"}


$uri = 'http://roc.olresultat.se/ver6.5/client.asp?function=callhome&command=list'
$request = Invoke-WebRequest $uri
$data = ( $request.ParsedHtml.getElementsByTagName("table") | Select-Object -First 1 ).rows
$table = @()
forEach($row in $data){
    if($row.tagName -eq "tr"){
        $thisRow = @()
        $cells = $row.children
        forEach($cell in $cells){
            if($cell.tagName -imatch "t[dh]"){
                $thisRow += $cell.innerText
            }
        }
        $table += $thisRow -join ","
    }
}

$table| Select-String  -Pattern "got" 
$table| Select-String  -Pattern "^vok" 
