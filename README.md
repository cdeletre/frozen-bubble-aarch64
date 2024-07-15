# Requirements

- Docker

## Clone the repo

```
git clone https://github.com/cdeletre/frozen-bubble-aarch64.git
```

## Build the docker image

```
docker build --platform=linux/arm64 -t frozen-bubble-aarch64 .
```

## Build the port

```
docker run --rm -v ${PWD}:/frozen-bubble frozen-bubble-aarch64 /frozen-bubble/build.sh
```
