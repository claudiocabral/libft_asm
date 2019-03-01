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

.PHONY: all clean fclean re

.PRECIOUS: %.o

all: $(NAME) $(TESTS)

$(NAME): $(OBJS)
	ar rcs $@ $^

run_test_%: tests/test_%
	./$<

tests/test_%: objs/tests/%.o $(NAME)
	@[[ -d tests ]] || mkdir -p tests
	cc $< -L. -lfts -o $@

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
