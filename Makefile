NAME := libfts.a
ASM := nasm

ifeq ($(shell uname -s), Linux)
	ARCH := elf64
else
	ARCH := macho64
endif

ifeq ($(DEBUG), 1)
    DFLAGS := -debug
endif

OBJS := objs/ft_isalpha.o\
		objs/ft_isalnum.o\
		objs/ft_isdigit.o\
		objs/ft_isascii.o\
		objs/ft_isprint.o\
		objs/ft_tolower.o\
		objs/ft_toupper.o\
		objs/ft_puts.o\
		objs/ft_memset.o\
		objs/ft_memcpy.o\
		objs/ft_strcat.o\
		objs/ft_strdup.o\
		objs/ft_strlen.o\
		objs/ft_cat.o

TEST_OBJS :=	objs/tests/test.o \
		objs/tests/bsd_functions.o\
		objs/tests/compare.o\
		objs/tests/capture_stdout.o\
		objs/tests/strlen.o\
		objs/tests/memory.o\
		objs/tests/cat.o\
		objs/tests/puts_test.o

.PHONY: all clean fclean re

all: $(NAME) run_test

$(NAME): $(OBJS)
	ar rcs $@ $^

run_test: test
	./$<

objs/%.o: srcs/%.s
	@[[ -d $(dir $@ ) ]] || mkdir -p $(dir $@)
	$(ASM) -f$(ARCH) $< -o $@

objs/%.o: srcs/%.d
	@[[ -d $(dir $@ ) ]] || mkdir -p $(dir $@)
	dmd -c $(DFLAGS) -Isrcs/tests $< -of=$@

test: $(NAME) $(TEST_OBJS)
	dmd $(DFLAGS)  $^ -of=$@

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
