## color output
COLOR_NORMAL=$(shell printf '\033[0m')
COLOR_RED=$(shell printf '\033[1;31m')
COLOR_GREEN=$(shell printf '\033[1;32m')
COLOR_YELLOW=$(shell printf '\033[1;33m')

DONE="${COLOR_GREEN}Done${COLOR_NORMAL}"

.PHONY: all clean release update update-dev update-main init migrate php nginx restart
.IGNORE: all

all:

init:
	@echo "${COLOR_GREEN}Init ...${COLOR_NORMAL}"
	@(cd logs;rm -rf go;ln -sf ../app/logs go)
	@chmod 0600 ./config/go/ssh/id_rsa
	@echo $(DONE)

clean:

git-init:
	@docker-compose exec go bash -c "cd current;git config pull.rebase false;git config pull.rebase true;git config pull.ff only";

release:
	@docker-compose exec go bash -c "./deploy.sh";

update:
	@docker-compose exec go bash -c "cd current;git pull;rm app;go build -o app;supervisorctl reload";

go:
	@docker-compose exec go env LANG=C.UTF-8 bash;

rabbit:
	@docker exec -it rabbit /bin/bash;

restart:
	@docker-compose restart;
