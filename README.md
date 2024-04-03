# Snaparser webUI

Snaparser webUI is a web app that interacts with a snaparser server.

# Design choices

- Although this project is using sveltekit, server side rendering (ssr) is disabled.
- The whole website is therefore served as a Single Page App (SPA)

# Developing

To start working on this project, please follow the following steps:

```sh
# clone the git repo
$ git clone https://github.com/vanillaiice/snaparser_webui

# cd into the directory
$ cd snaparser_webui

# install dependencies
$ npm install --save-dev

# run development server
$ npm run dev
```

> Note: You also need to create a .env file with the URL of the snaparser server.
>
> You can have .env.local and .env.production files for different staging environments.

```sh
# .env.local
VITE_API_URL=http://localhost:8080/upload

# .env.production
VITE_API_URL=https://api.snaparser.xyz
```

Alternatively, you can declare the URL of the server as an environment variable during build:

```sh
$ VITE_API_URL=https://api.snaparser.xyz/upload npm run build
```

# Building

To build for production:

```sh
$ npm run build
```

> Note: Production builds will use the .env.production file to get the snaparser server URL.

You can then serve the content of the `build` directory as a static website using express, Caddy, or any other tools. 

# Docker

This web app can also be run as a docker container.
It serves the web app using a Caddy file server.

## Pulling image

The code below will serve the web app at http://localhost:7777. Also, the snaparser server URL is set to the default value of http://localhost:8888.

```sh
$ docker pull vanillaiice/snaparser_webui_server:latest
$ docker run --rm -p 7777:7777 vanillaiice/snaparser_webui_server 
```

To use a custom Caddyfile:

```sh
$ docker run --rm -p 7777:7777 -v ${PWD}/Caddyfile:/etc/caddy/Caddyfile vanillaiice/snaparser_webui_server
```

> Note: the root value in the Caddyfile must always be set to `/srv`, as this is where the content of the web page is located. (e.g.: `root * /srv`)

## Building image

To build the image yourself, you need git and docker installed on your machine. You can then do the following:

```sh
$ git clone https://github.com/vanillaiice/snaparser_webui
$ cd snaparser_webui
$ docker build -t snaparser_webui .

# or set custom API URL
$ docker build --build-arg API_URL=http://localhost:9999 -t snaparser_webui .
# make sure to also run with custom Caddyfile
$ docker run --rm -p 9999:9999 -v caddy_data:/data -v ${PWD}/Caddyfile:/etc/caddy/Caddyfile snaparser_webui
```

# Author

vanillaiice

# License

BSD-3-Clause
