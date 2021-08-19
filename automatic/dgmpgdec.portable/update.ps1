import-module au

$releases = 'http://rationalqm.us/dgmpgdec/'

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $regex   = 'dgmpgdec(\d{4}).zip$'
    $url     = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
    $version = $url | Select-String -pattern $regex | ForEach-Object {$_.matches.groups[1].value}
    $version = $version.ToCharArray() -join "."
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
