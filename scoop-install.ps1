# get core functions
$core_url = 'https://raw.githubusercontent.com/lukesampson/scoop/master/lib/core.ps1'
Write-Output 'Initializing...'
Invoke-Expression (new-object net.webclient).downloadstring($core_url)

# prep
if (installed 'scoop') {
    write-host "Scoop is already installed. Run 'scoop update' to get the latest version." -f red
    # don't abort if invoked with iex that would close the PS session
    if ($myinvocation.mycommand.commandtype -eq 'Script') { return } else { exit 1 }
}
$dir = ensure (versiondir 'scoop' 'current')

# download scoop zip
$zipurl = 'https://github.com/lukesampson/scoop/archive/master.zip'
$zipfile = "$dir\scoop.zip"
Write-Output 'Downloading scoop...'
dl $zipurl $zipfile

Write-Output 'Extracting...'
Add-Type -Assembly "System.IO.Compression.FileSystem"
[IO.Compression.ZipFile]::ExtractToDirectory($zipfile, "$dir\_tmp")
Copy-Item "$dir\_tmp\*master\*" $dir -Recurse -Force
Remove-Item "$dir\_tmp", $zipfile -Recurse -Force

Write-Output 'Creating shim...'
shim "$dir\bin\scoop.ps1" $false

# download main bucket
$dir = "$scoopdir\buckets\main"
$zipurl = 'https://github.com/ScoopInstaller/Main/archive/master.zip'
$zipfile = "$dir\main-bucket.zip"
Write-Output 'Downloading main bucket...'
New-Item $dir -Type Directory -Force | Out-Null
dl $zipurl $zipfile

Write-Output 'Extracting...'
[IO.Compression.ZipFile]::ExtractToDirectory($zipfile, "$dir\_tmp")
Copy-Item "$dir\_tmp\*-master\*" $dir -Recurse -Force
Remove-Item "$dir\_tmp", $zipfile -Recurse -Force

ensure_robocopy_in_path
ensure_scoop_in_path

scoop config lastupdate ([System.DateTime]::Now.ToString('o'))
success 'Scoop was installed successfully!'

Write-Output "Type 'scoop help' for instructions."

$erroractionpreference = $old_erroractionpreference # Reset $erroractionpreference to original value