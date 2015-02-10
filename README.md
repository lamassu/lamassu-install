# lamassu-install

This will install your Lamassu Bitcoin Machine remote server.

## To install

1. Start a new Digital Ocean droplet
2. ssh into the droplet and paste the following command:

    ```
    curl -#o install \
    https://raw.githubusercontent.com/lamassu/lamassu-install/two-way/install && \
    bash install
    ```

3. You should be set. Just follow the instructions on the screen to open your dashboard.

## To upgrade

To upgrade from lamassu-server@1.0.2 to the two-way server, ssh into your droplet
and paste the following command

```
curl -#o upgrade \
https://raw.githubusercontent.com/lamassu/lamassu-install/two-way/upgrade && \
bash upgrade
```
