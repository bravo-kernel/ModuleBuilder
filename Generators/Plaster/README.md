# Plaster

## How does it work

1. Copies all templates found under the `Dotnet` generator to the `Output\ModuleBuilderWithPlaster` folder
2. Excludes `.template.config` files only applicable for dotnet
3. Adds the plasterManifest for that template to the output directory
4. Done, ready to run

## Build step

This requires a `build.ps1` step but that seems inevitable.

## Testrun

Inside the ModuleBuilder repository folder run:

```powershell
.\Generators\Plaster\build.ps1
```

This will create two new folders:

- `Output\ModuleBuilderWithPlaster\NewModuleBuilderModule`
- `Output\ModuleBuilderWithPlaster\NewModuleBuilderPublicFunction`

To start Plaster:

```powershell
Invoke-Plaster -TemplatePath '.\Output\ModuleBuilderWithPlaster\NewModuleBuilderModule'
```

Open the `LICENSE` file and verify that the `{{ModuleAuthor}}` token placeholder has been replaced by the Plaster provided Author.
