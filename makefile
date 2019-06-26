help: #prints list of commands
	@cat ./makefile | grep : | grep -v "grep"

build: #build vscgo
	@docker build -t vscgo .

rebuild: #rebuild vsgo
	@docker build --no-cache -t vscgo .

start: #start vscgo
	@./vscgo.sh

connect: #start vscgo
	@docker exec -it --user root vscgo bash

commit:
	@docker commit vscgo vscgo

install: #install image from tar
	@docker load -i ./vscgo.tar

save: #save image to tar
	@docker save -o vscgo.tar vscgo

backup: #backup
	@sudo tar -czvf ../"$${PWD##*/}_$$(date +%d_%m_%Y_%s).tar.gz" ./