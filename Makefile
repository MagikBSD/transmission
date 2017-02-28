BIN=transmission
OBJ=${BIN}.o

CC?=cc
CFLAGS?=-O2 -march=native
CFLAGS+=-I${PREFIX}/include
LDFLAGS+=-L${PREFIX}/lib
LIBS+=-lucl
PREFIX?=/usr/local


all: ${BIN}

${BIN}: ${OBJ}
	${CC} ${LDFLAGS} -o $@ ${OBJ} ${LIBS}

.c.o:
	${CC} -c ${CFLAGS} -o $@ $<

install: all
	install -d ${DESTDIR}${PREFIX}/bin
	install -m 0555 -s ${BIN} ${DESTDIR}${PREFIX}/bin

test: ${BIN}
	./${BIN} _test.conf _test.json
	rm -f _test.json

clean:
	rm -f ${BIN} ${OBJ}


${BIN}.o: ${BIN}.c
