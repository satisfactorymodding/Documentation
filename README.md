# Satisfactory Modding Documentation

Documentation for Satisfactory Mod Loader (SML) and Satisfactory modding.
Master branch is live on <https://docs.ficsit.app/>.
Please contact us on the
[Satisfactory Modding Discord Server](https://discord.gg/xkVJ73E)
with questions and suggestions, or contribute via PRs (see below).

We attempt to use [Semantic Line Break format](https://sembr.org/) in the source files,
but this is only loosely followed.

An overview of Asciidoc syntax can be found [here](https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/).

Pull requests should target the `Dev` branch.

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

### Devcontainer

If you already have Visual Studio Code and Docker installed,
we offer a [devcontainer](https://code.visualstudio.com/docs/devcontainers/containers)
for the repository that will be auto-detected when you open the folder in VSCode.

This also means that Github Codespaces is a pretty convenient way to test out other people's PRs.

Make sure you have [the Remote Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
and [Docker Desktop](https://www.docker.com/products/docker-desktop) installed.

Remember to [turn off Docker starting with system startup](https://superuser.com/a/1386584)
and to [close Docker after you're done using it](https://www.reddit.com/r/docker/comments/ol11ve/how_to_completely_stop_docker_desktop/).
It reserves a lot of system memory even when not actively in use.

If it doesn't automatically prompt you, press Ctrl+Shift+P to open the Command Pallatte,
then type "Reopen in Container" and select the option that appears.

The container will automatically serve the built content upon opening for preview in your browser or within VSCode,
as well as a file watcher to automatically rebuild the preview upon detecting changes.
You will still have to manually refresh your browser, though...

If you are switching between container and local dev you may have to delete the `node_modules` and/or `.pnpm_store` folder.

### Manual

If you don't want to use the preconfigured devcontainer, or Codespaces, follow the directions below.

Although you can edit the `.adoc` files with just about any editor out there,
we suggest either Visual Studio Code (with the
[Asciidoc](https://marketplace.visualstudio.com/items?itemName=asciidoctor.asciidoctor-vscode)
and [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker) plugins)
or IntelliJ.

In order to see what the pages will look like on the live site before being deployed,
follow the below directions.

#### Installing

1. Install [Node.js](https://nodejs.org/en/download/) (the CI uses 16 but newer should be fine) and [pnpm Package Manager](https://pnpm.io/) through your preferred method.

2. Clone the repository

3. Use pnpm to install dependencies

```bash
pnpm install
```

#### Building

To set up a development watch server that will automatically rebuild the docs when you make changes:

```bash
pnpm run watch:dev
```

To build the docs for **SML and all other hosted mods** (slow):

```bash
pnpm run build
```

To build the docs for **just SML** (much faster):

```bash
pnpm run build:dev
```

The output HTML files for both commands can be found in `\build\site`.

#### Previewing

To preview the content, you can open the output HTML files in your browser, ex. `build/site/satisfactory-modding/latest/index.html`

You can also run `pnpm run serve` which will start a local webserver.

## Adding Docs for Another Mod

If you'd like, you can write docs for other mods and have them be included on the live site.

Mods that have done this include FicsIt-Networks, Refined Power, Ficsit Remote Monitoring, TweakIt, and more.

Contact us for more details if you'd like to set this up. The general steps are below:

- Create a repository with your documentation files
- [Enable github actions](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository) on your repository
- Edit the `antora-playbook-ci.yml` and `antora-playbook.yml` files to add your repo as a Source. Follow the format of the other mods already listed there
- Make sure you can build this docs repo locally with your site added as a source. Run the `build` task defined in `package.json` to do this. Consider temporarily commenting out other mods' repos to speed this up.
- If you want the deployed copy to automatically update when you push changes to your repo, you should set up an Actions file similar to [this one](.github/workflows/SubModPush.yml.example) and contact us on the Discord to get a token to [add to your secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) so the Actions file can function.
- PR the `Dev` branch with your changes to the playbook files.

## Adding new version branches

We typically create new version branches once a new major or minor version of SML has released.
The goal is to provide a point of reference in the docs for working with older versions.

In order to add a new frozen version branch of the docs...

1. Create a tag on a commit on the `master` branch following the name format `vX.X.X`, for example, `v3.1.1`
2. Add the tag name to front of the branches list in `antora-playbook.yml` and `antora-playbook-ci.yml`, after the HEAD item
3. You're good to go - CI will take care of deploying it for you.
