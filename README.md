# Satisfactory Modding Documentation

Documentation for Satisfactory Mod Loader (SML) and Satisfactory modding.
Master branch is live on https://docs.ficsit.app/.
Please contact us on the
[Satisfactory Modding Discord Server](https://discord.gg/xkVJ73E) (preferred) or the [Ficsit.app forums](https://forums.ficsit.app/) (not checked very often)
with questions and suggestions.

We attempt to use [Semantic Line Break format](https://sembr.org/)in the source files, but this is only loosely followed.

Pull requests should target the `dev` branch.

Before you submit changes,
you should probably follow the Development Setup directions below
to verify that the pages are displaying as expected.

Documentation for other mods is also served through the same site.
If you have written documentation for your mod and would like it to be added, contact us.

## Development Setup

Although you can edit the `.adoc` files with just about any editor out there,
we suggest either Visual Studio Code (with the
[Asciidoc](https://marketplace.visualstudio.com/items?itemName=asciidoctor.asciidoctor-vscode)
and [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker) plugins)
or IntelliJ.

In order to see what the pages will look like on the live site before being deployed,
follow the below directions.

### Installing

1. Install [Node.js](https://nodejs.org/en/download/) and [Yarn Package Manager](https://classic.yarnpkg.com/en/docs/install) through your preferred method

2. Use Yarn to install dependencies

```bash
yarn install
```

### Building

To build the docs for SML and all other hosted mods (slow):

```bash
yarn run build
```

To build the docs for just SML, download an alternate
[Antora playbook file](https://cdn.discordapp.com/attachments/629385164115673108/689142080043352073/antora-playbook-dev.yml)
and put it in the root folder of the repo.

Then, run the following:

```bash
yarn run build:dev
```

The output HTML files for both commands can be found in `\build\site`.
