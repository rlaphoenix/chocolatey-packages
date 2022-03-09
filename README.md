# Chocolatey Packages

This is a repository of Chocolatey packages I maintain. All packages are manually created only.

This repository has no use of `au` or any kind of CI/CD. I don't like the CI/CD environment of Chocolatey.
The packages in here are generally intended for my use only, so don't expect any liability on these packages.

## Building

```powershell
git clone https://github.com/rlaphoenix/chocolatey-packages
cd chocolatey-packages
cd "dgmpgdec.portable"  # or whatever package you want
choco pack dgmpgdec.portable.nuspec
choco install -s . dgmpgdec.portable
```

## License

[Apache License, Version 2.0](LICENSE)
