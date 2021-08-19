$ErrorActionPreference = 'Stop';
$softwareName = 'BDInfo'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/UniqProject/BDInfo/releases/download/v0.7.5.6/BDInfo_v0.7.5.6.zip'
$checksum     = '84EA4B7FF3B972677ECFA173C299C1389DCC42CAC87021EC225D0155D085CCC7'

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

$libDir = (Get-ChildItem $env:ALLUSERSPROFILE\chocolatey\lib\bdinfo* | Select-Object $_.last)
$bdInfoPath = "$($libDir)\tools\BDInfo.exe"

$startDir = "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\BDInfo.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $startDir -TargetPath $bdInfoPath

Install-ChocolateyPath -PathToInstall $toolsDir -PathType 'Machine'
