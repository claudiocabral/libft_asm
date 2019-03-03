NAME := libfts.a
ASM := nasm

ifeq ($(shell uname -s), Linux)
	ARCH := elf64
else
	ARCH := macho64
endif

OBJS := objs/ft_isalpha.o\
		objs/ft_isdigit.o\
		objs/ft_isalnum.o

TESTS :=	run_test_isalpha\
		run_test_isdigit

.PHONY: all clean fclean re

all: $(NAME) run_test

$(NAME): $(OBJS)
	ar rcs $@ $^

run_test: test
	./$<


objs/%.o: srcs/%.s
	@[[ -d $(dir $@ ) ]] || mkdir -p $(dir $@)
	$(ASM) -f$(ARCH) $< -o $@

test: srcs/tests/test.d $(NAME)
	dmd  $(NAME) $< -of=$@

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
