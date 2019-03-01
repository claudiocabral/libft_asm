NAME := libfts.a
ASM := nasm

ifeq ($(shell uname -s), Linux)
	ARCH := elf64
else
	ARCH := macho64
endif

OBJS := objs/ft_isalpha.o\
	objs/ft_isdigit.o

TESTS :=	run_test_isalpha\
		run_test_isdigit

#OBJS_TEST := objs/tests/isalpha.o\

.PHONY: all clean fclean re

all: $(NAME) $(TESTS)

$(NAME): $(OBJS)
	ar rcs $@ $^

run_test_%: test_%
	./tests/test_isalpha

test_%: $(NAME) objs/%.o
	@[[ -d tests ]] || mkdir -p tests
	cc objs/$@.o -L. -lfts -o tests/alpha_test

objs/%.o: srcs/%.s
	@[[ -d $(dir $@ ) ]] || mkdir -p $(dir $@)
	$(ASM) -f$(ARCH) $< -o $@

objs/%.o: srcs/%.c
	@[[ -d $(dir $@ ) ]] || mkdir -p $(dir $@)
	gcc -c $< -o $@ -Iincludes

clean:
ifeq ($(shell [ -e objs ] && echo 1 || echo 0),1)
	rm -rf objs
endif

fclean: clean
ifeq ($(shell [ -e $(NAME) ] && echo 1 || echo 0),1)
	rm -rf libfts.a
	rm -rf tests
endif

re:
	$(MAKE) fclean
	$(MAKE) all
