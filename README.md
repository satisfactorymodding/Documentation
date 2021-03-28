# Satisfactory Modding Documentation

Documentation for SML and Unreal modding. Master branch is live on https://docs.ficsit.app/. Please contact us on the [Satisfactory Modding Discord Server](https://discord.gg/xkVJ73E) (preferred) or the [Ficsit.app forums](https://forums.ficsit.app/) with questions and suggestions.

We attempt to roughly follow [Semantic Line Break format](https://sembr.org/), but this is only loosely followed.

Pull requests should target the `dev` branch.

Documentation for other mods is also served through the same site. If you have written documentation for your mod and would like it to be added, contact us.

## Development Setup

### Installing

1. Install [Node.js](https://nodejs.org/en/download/) and [Yarn Package Manager](https://classic.yarnpkg.com/en/docs/install) through your preferred method

2. Use Yarn to install dependencies

```bash
yarn install
```

### Building

```bash
yarn run build
```

The output files will be in `\build\site`

If this command fails for you, you may need to download an alternate [playbook file specifically for development](https://cdn.discordapp.com/attachments/629385164115673108/689142080043352073/antora-playbook-dev.yml) and put it in the root folder of the repo. To use it, run `yarn run build:dev` instead of the above.
