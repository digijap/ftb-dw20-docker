Simple docker where you can add ops, whitelist users and set the message of the day in env variables.

In the launch.sh script are variables defined which modpack and server you want to run. You can find these [here](https://feed-the-beast.com/modpacks/server-files)

`docker build -t [TAG]/[NAME] .`

Docker compose example:
```
version: "3"

services:
  mc:
    image: digijap/ftb
    ports:
      - 25565:25565
    environment:
      EULA: "TRUE"
      OPS: "digijap"
      ALLOWLIST: "digijap,more,users"
      MOTD: "Example message of the day"
    tty true
    stdin_open: true
    restart: unless-stopped
    volumes:
      - /path/on/host:/data
```

Heavily inspired by [goobaroo](https://github.com/Goobaroo)
