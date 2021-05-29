$ErrorActionPreference = 'Stop';
$softwareName = 'DGMPGDec'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://rationalqm.us/dgmpgdec/dgmpgdec2005.zip'
$checksum     = 'CB8F58F1CC88501512868BCDED6F4D4070EEEB7F5145EFA9045F0BB2BCD3904E'

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

$libDir = (Get-ChildItem $env:ALLUSERSPROFILE\chocolatey\lib\dgmpgdec* | select $_.last)
$dgIndexPath = "$($libDir)\tools\DGIndex.exe"

Install-ChocolateyFileAssociation ".d2v" $dgIndexPath

$startDir = "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\DGIndex.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $startDir -TargetPath $dgIndexPath
