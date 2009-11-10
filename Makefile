#
# Makefile
#
# Makefile for fbv

include Make.conf

CC	= gcc -O2 -Wall

SOURCES	= main.c jpeg.c gif.c png.c fb_display.c resize.c
OBJECTS	= ${SOURCES:.c=.o}

OUT	= fbv
LIBS	= -lungif -lX11 -L/usr/X11R6/lib -ljpeg -lpng

all: $(OUT)
	@echo Build DONE.

$(OUT): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $(OUT) $(OBJECTS) $(LIBS)

clean:
	rm -f $(OBJECTS) *~ $$$$~* *.bak core config.log

distclean: clean
	echo -e "error:\n\t@echo Please run ./configure first..." >Make.conf
	rm -f $(OUT) config.h

install: $(OUT)
	cp $(OUT) $(DESTDIR)$(bindir)
	gzip -9c $(OUT).1 > $(DESTDIR)$(mandir)/man1/$(OUT).1.gz

uninstall: $(DESTDIR)$(bindir)/$(OUT)
	rm -f $(DESTDIR)$(bindir)/$(OUT)
	rm -f $(DESTDIR)$(mandir)/man1/$(OUT).1.gz