.SUFFIXES: .erl .beam .yrl

.erl.beam:
	erlc -W $<

#ERL = erl -boot start_clean

MODS = example1 example1_lib unit_test

all: compile
	@erl -noshell -s unit_test start
	
example1: example1.c erl_comm.c example1_driver.c
	gcc -o example1 example1.c erl_comm.c example1_driver.c
	
example1_drv.so: example1_lib.c example1.c
	gcc -arch x86-64 -I /usr/local/lib/erlang/usr/include\
	-o example1_drv.so -fPIC -bundle -flat_namespace -undefined suppress\
	example1.c example1_lib.c
	
	
	
	
compile: ${MODS:%=%.beam} example1 example1_drv.so

clean:
	rm example1 example1_drv.so *.beam
	
