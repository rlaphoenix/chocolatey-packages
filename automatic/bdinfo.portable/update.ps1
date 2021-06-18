import-module au

$releases = 'https://api.github.com/repos/UniqProject/BDInfo/releases'

function global:au_GetLatest {
    [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
    $releases = Invoke-RestMethod -Uri $releases
    $latest = $releases | 
                Where-Object {$_.prerelease -ne "True"} | 
                Where-Object {$_.draft -ne "True"} | 
                Select-Object -First 1

    $version = ($latest | Select -ExpandProperty tag_name) -replace "v",""
    $url = $latest | 
               Select-Object -ExpandProperty assets | 
               Where-Object {$_.content_type -eq "application/x-zip-compressed"} | 
               Select-Object -ExpandProperty browser_download_url

    return @{ Version = $version; URL32 = $url }
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

update -ChecksumFor all -NoCheckUrl
