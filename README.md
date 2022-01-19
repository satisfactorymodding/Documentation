# Satisfactory Modding Documentation

Documentation for Satisfactory Mod Loader (SML) and Satisfactory modding.
Master branch is live on https://docs.ficsit.app/.
Please contact us on the
[Satisfactory Modding Discord Server](https://discord.gg/xkVJ73E) (preferred)
or the [Ficsit.app forums](https://forums.ficsit.app/) (not checked very often)
with questions and suggestions, or contribute via PRs (see below).

We attempt to use [Semantic Line Break format](https://sembr.org/) in the source files,
but this is only loosely followed.

Pull requests should target the `dev` branch.

Before you submit changes,
you should probably follow the Development Setup directions below
to verify that the pages are displaying as expected.

Documentation for other mods is also served through the same site.
If you have written documentation for your mod and would like it to be added, contact us.

## Contributing

We greatly appreciate any contributions you may have to the docs.
Even if you only have the rough outline of a page done,
feel free to contact us on the Discord and we'll help you turn it into a full page.

The easiest way to contribute is to make a fork of the repo,
then use a Pull Request targeting the `Dev` branch for us to review the changes.

Send us a message on the Discord if we don't review it within a day or two.

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

## Adding Docs for Another Mod

If you'd like, you can write docs for other mods and have them be included on the live site.

Mods that have done this include FicsIt-Networks, Refined Power, Ficsit Remote Monitoring, TweakIt, and more.

Contact us for more details if you'd like to set this up. The general steps are below:

- Create a repository with your documentation files
- [Enable github actions](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository) on your repository
- Edit the `antora-playbook-ci.yml` and `antora-playbook.yml` files to add your repo as a Source. Follow the format of the other mods already listed there
- Make sure you can build this docs repo locally with your site added as a source
- PR the `Dev` branch with your changes to the playbook files.

## Adding new version branches

We typically create new version branches once a new major or minor version of SML has released.
The goal is to provide a point of reference in the docs for working with older versions.

In order to add a new frozen version branch of the docs...

1. Create a tag on a commit on the `master` branch following the name format `vX.X.X`, for example, `v3.1.1`
2. Add the tag name to front of the branches list in `antora-playbook.yml` and `antora-playbook-ci.yml`, after the HEAD item
3. You're good to go - CI will take care of deploying it for you.
