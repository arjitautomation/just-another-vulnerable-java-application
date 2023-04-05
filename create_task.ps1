
$pactoken=$args[0]
$organizationName = "arjitdevops"
$projectName = "Devops"
$adoHeader = @{Authorization=("Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "",$pacToken))))}
$adoTaskUri = "https://dev.azure.com/$organizationName/$projectName/_apis/wit/workitems/`$Task?api-version=5.1"

$comments=" "
$requester = "Arjit Srivastava"
$cat = "Security"
$subcat = "DevSecOps"
$shortDescription = "Found issues during SCA"
$description = "Some issue reported on performing SCA (Snyk test), Please check the libararies"
$impact = 2
$title = $shortDescription




$comments += "Opened By : $requester <br />"
$comments += "Category : $cat <br />"
$comments += "Sub-Category : $subcat <br />"
$comments += "Description : <br />"
$comments += $description
$comments = $comments.replace('"',"'")

#Generate JSON body to make the REST API call

$body="[
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Title`",
    `"value`": `"$title`"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Description`",
    `"value`": `"$comments`"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/Microsoft.VSTS.Common.Priority`",
    `"value`": `"$impact`"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Tags`",
    `"value`": `"$cat;$subcat`"
  }	  
]"
#REST API call
Invoke-RestMethod -Uri $adoTaskUri -ContentType "application/json-patch+json" -Body $body -headers $adoHeader -Method POST
