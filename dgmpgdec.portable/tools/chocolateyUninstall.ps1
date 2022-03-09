$ErrorActionPreference = "Stop";

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$packageName = 'dgmpgdec.portable'
$zipName = 'dgmpgdec2005.zip'

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
