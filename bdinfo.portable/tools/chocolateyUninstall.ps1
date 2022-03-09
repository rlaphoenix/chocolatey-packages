$ErrorActionPreference = "Stop";

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$packageName = 'bdinfo.portable'
$zipName = 'BDInfo_v0.7.5.6.zip'

Uninstall-ChocolateyZipPackage $packageName $zipName

#Removes duplicates of the target removal path, Cleans up double ";", Handles ending "\"
#Credit: https://gitlab.com/DarwinJS/ChocoPackages/-/blob/master/ec2clitools/tools/chocolateyuninstall.ps1

$PathToRemove = $toolsDir
foreach ($path in [Environment]::GetEnvironmentVariable("PATH", "Machine").split(';')) {
  If ($Path) {
    If (($path -ine "$PathToRemove") -AND ($path -ine "$PathToRemove\")) {
      [string[]]$Newpath += "$path"
    }
  }
}
$AssembledNewPath = ($newpath -join(';')).trimend(';')

[Environment]::SetEnvironmentVariable("PATH", $AssembledNewPath, "Machine")
