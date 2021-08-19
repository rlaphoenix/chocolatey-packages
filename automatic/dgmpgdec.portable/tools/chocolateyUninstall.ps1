$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
Uninstall-ChocolateyPath -PathToInstall $toolsDir -PathType "Machine" | Out-Null
