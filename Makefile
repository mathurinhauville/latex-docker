IMAGE=blang/latex:ctanfull
CONTAINER=latex

MAIN_FILE=main.tex

.PHONY: build start stop restart shell clean preview
.DEFAULT_GOAL := comp

########### Docker ###########

build:
	@docker build -t $(IMAGE) -f Dockerfile.custom .

start:
	@docker run -d --name $(CONTAINER) --user=$(id -u):$(id -g) --net=none -t -v .:/data $(IMAGE) /bin/sh -c "sleep infinity"

stop : 
	@docker stop $(CONTAINER)
	@docker rm $(CONTAINER)

restart: stop start

shell:
	@docker exec -it $(CONTAINER) /bin/sh

########### LateX ###########

comp:
	@if [ -z "$(f)" ]; then \
		f=$(MAIN_FILE); \
	fi; \
	docker exec -it $(CONTAINER) /bin/sh -c "latexmk -cd -f -jobname=output -outdir=./out -auxdir=./out -interaction=batchmode -pdf $(f)"
	@make preview

clean:
	@rm -rf out

preview:
	@open -a "Preview" ./out/output.pdf