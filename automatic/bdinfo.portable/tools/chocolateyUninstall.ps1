$installPath = "$env:ChocolateyInstall\lib\bdinfo.portable\tools\"
Uninstall-ChocolateyPath $installPath 'Machine' | Out-Null
