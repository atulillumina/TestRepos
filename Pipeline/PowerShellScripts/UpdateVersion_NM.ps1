param(
    [string]$RelativePath = "./src"
)

echo "outside"

git diff --quiet HEAD $REF -- $DIR || echo changed

$jsonfiles = Get-ChildItem -Path $RelativePath -Filter manifest.json -Recurse
foreach($file in $jsonfiles)
{
    echo "inside"
    
    # Read the file contents as a JSON object
    $json = Get-Content $file -Raw | ConvertFrom-Json
    
    # Extract the current version number and split it into its components
    $versionParts = $json.version -split '\.'

    # Increment the last component of the version number
    $versionParts[-1] = [int]$versionParts[-1] + 1

    # Combine the version components into a string
    $newVersion = $versionParts -join '.'
    
    echo $newVersion

    # Update the version number in the JSON object
    $json.version = $newVersion
    
    echo "New " + $json.version

    # Save the updated JSON object back to the file
    $json | ConvertTo-Json -Depth 100 | Set-Content $file
    
    ConvertTo-Json -InputObject $json -Depth 100 | Set-Content $file
    echo $json
}
