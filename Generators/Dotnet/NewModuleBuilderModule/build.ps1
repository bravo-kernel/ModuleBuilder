# Uses PoshCode/ModuleBuilder to combine all .ps1 file in `/Source` folder into a `.psm1` module.
#
# See: https://github.com/PoshCode/ModuleBuilder

[CmdletBinding()]
param(
    # A specific folder to build into
    $OutputDirectory,

    # The version of the output module
    [Alias("ModuleVersion")]
    [string]$SemVer,

    [Switch]$ImportModule
)
Push-Location $PSScriptRoot -StackName BuildWindowsConsoleFont

# Do we need to re-add the PSModulePath in each PowerShell step?
if (Test-Path .\RequiredModules) {
    $LocalModules = Convert-Path .\RequiredModules
    if (-not (@($Env:PSModulePath.Split([IO.Path]::PathSeparator)) -contains $LocalModules)) {
        Write-Verbose "Adding $($LocalModules) to PSModulePath"
        $Env:PSModulePath = $LocalModules + [IO.Path]::PathSeparator + $Env:PSModulePath
    }
}

if (!$SemVer -and (Get-Command gitversion -ErrorAction Ignore)) {
    $PSBoundParameters['SemVer'] = gitversion -showvariable nugetversion
}
if (!$OutputDirectory) {
    $PSBoundParameters['OutputDirectory'] = Join-Path $PSScriptRoot .\Output
}

try {
    ## Build the actual module
    $moduleInfo = Build-Module -SourcePath ./Source `
                        -Target Build -Passthru `
                        @PSBoundParameters

    # feedback
    $moduleInfo | Out-Host -Verbose

    # import built module commands
    if ($ImportModule) {
        # this seems useful
    }
} finally {
    Pop-Location -StackName BuildWindowsConsoleFont
}