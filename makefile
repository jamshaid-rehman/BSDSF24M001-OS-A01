CC = gcc
CFLAGS = -Wall -Iinclude
PIC_FLAGS = -fPIC

STATIC_LIB = lib/libmyutils.a
DYNAMIC_LIB = lib/libmyutils.so

OBJS = obj/mystrfunctions.o obj/myfilefunctions.o
PIC_OBJS = obj/mystrfunctions_pic.o obj/myfilefunctions_pic.o

# --- static (already have this from Feature 3) ---
$(STATIC_LIB): $(OBJS)
	ar rcs $@ $^

# --- dynamic (new) ---
$(DYNAMIC_LIB): $(PIC_OBJS)
	$(CC) -shared -o $@ $^

obj/%_pic.o: src/%.c
	$(CC) $(CFLAGS) $(PIC_FLAGS) -c $< -o $@

bin/client_dynamic: obj/main.o $(DYNAMIC_LIB)
	$(CC) -o $@ obj/main.o -Llib -lmyutils

all: $(STATIC_LIB) $(DYNAMIC_LIB) bin/client_static bin/client_dynamic
