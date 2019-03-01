NAME := libfts.a
ASM := nasm

ifeq ($(shell uname -s), Linux)
	ARCH := elf64
else
	ARCH := macho64
endif

OBJS := objs/ft_isalpha.o\
	objs/test.o

all: $(NAME)

$(NAME): $(OBJS)
	ar rcs $@ $<

test:
	gcc -Iincludes -L. -lfts tests/isalpha.c -oalpha_test

objs/%.o: srcs/%.s
	@[[ -d $(dir $@ ) ]] || mkdir -p $(dir $@)
	$(ASM) -f$(ARCH) $< -o $@
