CC=gcc
CFLAGS=-g -fPIC
LDFLAGS=-shared -o

WIN_BIN=lib_<project>.dll
UNIX_BIN=lib<project>.so

OBJFILES=$(wildcard src/*.c)

all: unix

unix:
	$(CC) $(CFLAGS) $(OBJFILES) $(LDFLAGS) $(UNIX_BIN)

win:
	$(CC) $(CFLAGS) $(OBJFILES) $(LDFLAGS) $(WIN_BIN)

clean:
	rm $(TARGET)
