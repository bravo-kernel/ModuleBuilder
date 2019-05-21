# Use this file to override the default parameter values used by the `Build-Module`
# command when building the module (see `Get-Help Build-Module -Full` for details).

@{
    VersionedOutputDirectory = $true
    Path = "{{ModuleName}}.psd1" # this one is/seems to be required or the Azure pipeline will fail (not being able to find the manifest)
}