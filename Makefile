CV=$(shell if [ `uname` = "Darwin" ]; then echo "c11"; elif [ `uname` = "Linux" ]; then echo "gnu11"; fi;)
CFLAGS=-c -Wall -Wextra -ggdb3 -O3 -march=native  -std=$(CV) -pedantic

SRC_DIR=ext/rinku
LIB_DIR=lib
INC_DIR=include
SRCS=ext/rinku/rinku.c ext/rinku/autolink.c ext/rinku/buffer.c ext/rinku/utf8.c
HEADERS=ext/rinku/rinku.h ext/rinku/autolink.h ext/rinku/buffer.h ext/rinku/utf8.h
OBJS=$(SRCS:.c=.o)
TARGET=$(LIB_DIR)/librinku.a

all: $(LIB_DIR) $(INC_DIR) $(TARGET)

clean:
	$(RM) $(OBJS)
	$(RM) $(TARGET)

$(LIB_DIR):
	mkdir -p $@

$(INC_DIR):
	mkdir -p $@

$(TARGET): $(OBJS)
	ar -rcs $@ $(OBJS)

%.o : %.c  $(HEADERS)
	$(CC) -I. -I$(SRC_DIR) $(CFLAGS) -o $@ $<

