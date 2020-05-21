##
## EPITECH PROJECT, 2019
## Makefile
## File description:
## Makefile
##

SHELL	=	bash

SRC		=	src/main.c			\

OBJ		=	$(SRC:.c=.o)

NAME	=	a.out

CFLAGS	= -I./include -Wextra -W -Wall -pedantic -fdiagnostics-color

LIBS	= -L lib/my/ -lmy -L lib/color/ -lcolor

NORMAL	= \033[0;39m

all:	$(NAME)

$(NAME): build_lib build

goodbye: ## Goodbye
	@echo -ne "\033[1;5;34m"
	@echo -e " ___   ___  ___  ___  ___       ___"
	@echo -e "/   | |   ||   ||   \|   / \ / |    "
	@echo -e "|   __|   ||   ||   ||---\  |  |--  "
	@echo -e "|___/ |___||___||___/|___/  |  |___$(NORMAL)"

build_lib: ## Compile the libs
	@$(MAKE) -C lib/my --silent
	@$(MAKE) -C lib/color --silent

lib_clean: ## Clean the libs
	@$(MAKE) clean -C lib/my --silent
	@$(MAKE) clean -C lib/color --silent

lib_fclean: ## Force clean the libs
	@$(MAKE) fclean -C lib/my --silent
	@$(MAKE) fclean -C lib/color --silent

%.o: %.c ## Compile the objects
	@$(CC) $(CFLAGS) -c $< -o $@
	@printf "[\e[1;34mCompiled\e[0m] % 41s\n" $@ | tr ' ' '.'

build: $(OBJ) ## Build the main binary
	@$(CC) -o $(NAME) $(CFLAGS) $(OBJ) $(LIBS)

clean: lib_clean ## Clean the project
	@rm -f $(OBJ)

fclean: lib_fclean clean goodbye ## Force clean the project
	@rm -f $(NAME)

re: fclean all ## Force clean then compile

valgrind:	CFLAGS += -g3
valgrind:	fclean	all ## Launch valgrind
	@valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET)

help: ## Help for the Makefile
	@cat $(MAKEFILE_LIST) | sed -En 's/^([a-zA-Z_-]+)\s*:.*##\s?(.*)/\1 "\2"/p' | xargs printf "\033[32m%-30s\033[0m %s\n"

.PHONY:	all goodbye build build_lib lib_clean lib_fclean clean fclean re tests_run re_tests valgrind help