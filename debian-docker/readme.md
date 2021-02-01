
# Docker for Testing

![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/walchko/raspberrypi)

This is useful for testing code on Debian before trying on a 
Raspberry Pi. It is not perfect, but close enough.

## Using

- Build: `docker-compose build --compress --force-rm --no-cache --pull --parallel`
- Run: `docker-compose up`
    - You can add the `-d` switch to detach it from the terminal and run it in the background
- Stop: 
    - if attached to terminal, use `ctrl-C`
    - if detached: `docker-compose down`

## SSH into Container

- Assuming dalek is hosting, reach from any where: `ssh -p 2222 pi@dalek.local``
- Run on the hosting system: `ssh -p 2222 pi@0.0.0.0`
