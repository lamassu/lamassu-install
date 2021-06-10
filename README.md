# lamassu-install

This will install your [**Lamassu Admin**](https://lamassu.is/admin) and server on a DigitalOcean droplet running Ubuntu 20.04 LTS.

## First-time installation

Follow the latest installation instructions on [**our knowledgebase**](https://support.lamassu.is/hc/en-us/sections/360001713031-Admin-Setup-Step-by-Step-).

## Upgrading

Before upgrading, [**verify your server version**](https://support.lamassu.is/hc/en-us/articles/360000919752-Determining-your-server-version).

### From Defiant Dingirma v7.4

If you're coming from our previous major release, use the server and admin [**upgrade instructions here**](https://support.lamassu.is/hc/en-us/articles/360059106951-Updating-to-Electric-Enlil-v7-5-).

### From Electric Enlil v7.5.x

If you're already on v7.5, run the following in your droplet's terminal to upgrade to the [**latest release**](https://github.com/lamassu/lamassu-server/releases):

```
curl -sS https://raw.githubusercontent.com/lamassu/lamassu-install/electric-enlil/upgrade-ls | bash
```
