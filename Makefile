PROG = main
NAME = film-parser
CC = gnatmake
DEST = /usr/local/bin
all: build clean

build:
	$(CC) $(PROG).adb -o $(NAME)
clean:
	rm -f $(PROG)*.ali $(PROG)*.o 
install:
	install $(NAME) $(DEST)
uninstall:
	rm $(DEST)/$(NAME)