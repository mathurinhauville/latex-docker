# Compile TeX in Docker

Compile .tex files in a Docker container with custom dependencies.

## Usage

```bash
make f=main.tex
```

Or configure the MAIN_FILE variable in the Makefile and run:

```bash
make
```

## Prerequisites

- Docker installed
- Make command installed
- The user should be in the docker group. If not, run:
```bash
sudo usermod -aG docker $USER
```

## Installation

```bash
cd /path/to/my-latex-project

git clone https://github.com/mathurinhauville/latex-docker.git

make build 

make start
```

## Custom dependencies
You can edit the Dockerfile.custom to add other tlmgr packages.

The Dockerfile use image from [blang/latex](https://hub.docker.com/r/blang/latex) and add custom dependencies. Initially, the tag is set to `ctanfull`and provide a large amount of packages but heavy (3.07GB). If you want to reduce the image size and customize as you want, you can change the tag to `ctanbasic` (210.18 MB).

## Make commands

- `make build`: Build the Docker image
- `make start`: Start the Docker container
- `make stop`: Stop the Docker container
- `make comp <f=texfile>`: Compile the .tex file. By default, the .tex file is `main.tex`
- `make clean`: Remove the generated files