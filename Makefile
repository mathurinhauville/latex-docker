# CREDIT : https://github.com/blang/latex-docker

IMAGE=blang/latex:ctanfull
CONTAINER=latex
MAIN_FILE=main.tex

.PHONY: build start stop restart shell compile_arg comp clean
.DEFAULT_GOAL := comp

########### Docker ###########

build:
	@docker build -t $(IMAGE) -f Dockerfile.custom .

start:
	@docker run -d --name $(CONTAINER) --user=$(id -u):$(id -g) --net=none -t -v $(PWD):/data $(IMAGE) /bin/sh -c "sleep infinity"

stop : 
	@docker stop $(CONTAINER)
	@docker rm $(CONTAINER)

restart: stop start

shell:
	@docker exec -it $(CONTAINER) /bin/sh

########### Latex ###########

comp:
	@if [ -z "$(f)" ]; then \
		$f=$(MAIN_FILE); \
	fi; \
	docker exec -it $(CONTAINER) /bin/sh -c "latexmk -cd -f -interaction=batchmode -pdf $(f)"

clean:
	@docker exec -it $(CONTAINER) /bin/sh -c "latexmk -cd -C"