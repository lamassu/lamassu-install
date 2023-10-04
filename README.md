# lamassu-install

This will install your [**Lamassu Admin**](https://lamassu.is/admin) and server on a DigitalOcean droplet running Ubuntu Server 20.04 LTS.

## First-time installation

Follow the latest installation instructions on [**our knowledgebase**](https://support.lamassu.is/hc/en-us/sections/360001713031-Admin-Setup-Step-by-Step-).

On a fresh droplet using the specs outlined in the instructions above, run:

```
curl -O https://raw.githubusercontent.com/lamassu/lamassu-install/release-8.6/install && bash install
```

## Upgrading

Before upgrading, [**verify your server version**](https://support.lamassu.is/hc/en-us/articles/360000919752-Determining-your-server-version).

Then, follow our [**KB instructions for upgrading**](https://support.lamassu.is/hc/en-us/sections/360000697551-Admin-machine-updates) relevant to your current version.

On servers running v8.0 or higher, you may run the following to upgrade:

```
curl -sS https://raw.githubusercontent.com/lamassu/lamassu-install/release-8.6/upgrade-ls | bash
```
