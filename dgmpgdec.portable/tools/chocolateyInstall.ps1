$ErrorActionPreference = 'Stop';
$softwareName = 'DGMPGDec'
$toolsDir     = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://rationalqm.us/dgmpgdec/dgmpgdec2006.zip'
$checksum     = '100D38AA0ECC58F3340B8ED26022B83F5F83643FD74D70FC35CDAE30B0B98FA4'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = $softwareName

  checksum      = $checksum
  checksum64    = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$libDir = (Get-ChildItem $env:ALLUSERSPROFILE\chocolatey\lib\dgmpgdec* | Select-Object $_.last)
$dgIndexPath = "$($libDir)\tools\DGIndex.exe"

Install-ChocolateyFileAssociation ".d2v" $dgIndexPath

$startDir = "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\DGIndex.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $startDir -TargetPath $dgIndexPath

Install-ChocolateyPath -PathToInstall $toolsDir -PathType "Machine"
