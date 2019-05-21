# Generators

Directory used to generate the publishable Powershell Modules per generator:

- used for creating new Modules using the ModuleBuilder guidelines
- uses the `Dotnet` folder as the base template
- COULD contain more templates (`NewModuleBuilderPublicFunction` added as a dummy placeholder)
- MAY contains a generator specific `build.ps1` file

## Why Dotnet as base?

Only a suggestion but seems like the ideal candidate because:

- dotnet folder can be used as-is for generating the ModuleBuilderWithDotnet module
- other generators can use dotnet templates (as long as we don't copy the `.template.config` files)
- other generators share the same replace-token-placeholder logic as used by dotnet
- single source for updating the template

## Plaster

- must use the <templateFile> directive instead of <file> directive or token placeholders will not be replaced

> See the Plaster folder for additional info.
