# Snaparser webUI

Snaparser webUI is an web page that interacts with a snaparser server.

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
VITE_API_URL = http://localhost:8080/upload

# .env.production
VITE_API_URL = https://api.snaparser.xyz
```

# Building

To build for production:

```sh
npm run build
```

> Note: Production builds will use the .env.production file to get the snaparser server URL.

# Author

vanillaiice

# License

BSD-3-Clause
