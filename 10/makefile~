.SUFFIXES: .erl .beam

.erl.beam:
	erlc -W $<

ERL = erl -boot start_clean

MODS = hello

all: compile
	${ERL} -pa '/home/jinwh/erlang/erlang/10/' -s hello start
	
compile: ${MODS:%=%.beam}

clean:
	rm -rf *.beam erl_crash.dump
