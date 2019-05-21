<#
    .Synopsis
        Builds Plaster templates using the Dotnet templates as base.
#>
[CmdletBinding()]
param()

begin {
    Write-Host "Generating Plaster templates"

    # start fresh, remove existing directory
    $outputDirectory = ".\Output\ModuleBuilderWithPlaster"
    if (Test-Path $outputDirectory) {
        Write-Host "Removing existing output directory $outputDirectory"
        Remove-Item $outputDirectory -Recurse -Force -Confirm:$false
    }

    # get all Dotnet templates (to use as the base for all other generators)
    $dotnetTemplates = Get-ChildItem -Path Generators\Dotnet -Directory
}

process {
    # generate subdirectories for each template
    foreach ($dotnetTemplate in $dotnetTemplates) {
        $destination = "$outputDirectory\$($dotnetTemplate.Name)"
        Write-Host "Generating $($dotnetTemplate.Name)" -ForegroundColor Yellow

        # clone dotnet template excluding the `.template.config` files
        Write-Host "Copying dotnet template into $($destination)\template"
        Copy-Item ".\Generators\Dotnet\$($dotnetTemplate.Name)" -Destination $destination\template -Recurse -Exclude 'template.config'

        # add Plaster manifest file
        $plasterManifest = ".\Generators\Plaster\plasterManifest.$($dotnetTemplate.Name).xml"
        Write-Host "Copying Plaster manifest $plasterManifest into $destination\plasterManifest.xml"
        Copy-Item $plasterManifest -Destination "$destination\plasterManifest.xml"

        # feedback on how to test
        Write-Host "Template generated successfully"
        Write-Host "Invoke-Plaster -TemplatePath '$destination'" -ForegroundColor Green
    }
}

