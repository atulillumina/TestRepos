$file = ".TestRepos\src\POS.NorhtAmerica\manifest.json"

# Read the file contents as a JSON object
$json = Get-Content $file -Raw | ConvertFrom-Json

# Extract the current version number and split it into its components
$versionParts = $json.version -split '\.'

# Increment the last component of the version number
$versionParts[-1] = [int]$versionParts[-1] + 1

# Combine the version components into a string
$newVersion = $versionParts -join '.'

# Update the version number in the JSON object
$json.version = $newVersion

# Save the updated JSON object back to the file
$json | ConvertTo-Json -Depth 100 | Set-Content $file
