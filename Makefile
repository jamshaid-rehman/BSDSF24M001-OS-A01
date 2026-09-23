# ============================================================
# Makefile for libmyutils project
# ============================================================

CC       = gcc
CFLAGS   = -Wall -Iinclude
PIC_FLAGS = -fPIC

SRC_DIR  = src
OBJ_DIR  = obj
LIB_DIR  = lib
BIN_DIR  = bin
INC_DIR  = include
MAN_DIR  = man/man3

# Install locations
PREFIX  = /usr/local
BINDIR  = $(PREFIX)/bin
LIBDIR  = $(PREFIX)/lib
MANDIR  = $(PREFIX)/share/man/man3

# ---- Object files ----
# Plain objects (used for direct multi-file build AND static lib)
OBJS      = $(OBJ_DIR)/mystrfunctions.o $(OBJ_DIR)/myfilefunctions.o
MAIN_OBJ  = $(OBJ_DIR)/main.o

# Position-independent objects (used only for the .so)
PIC_OBJS  = $(OBJ_DIR)/mystrfunctions_pic.o $(OBJ_DIR)/myfilefunctions_pic.o

# ---- Library targets ----
STATIC_LIB  = $(LIB_DIR)/libmyutils.a
DYNAMIC_LIB = $(LIB_DIR)/libmyutils.so

# ---- Executable targets ----
CLIENT_MULTIFILE = $(BIN_DIR)/client
CLIENT_STATIC    = $(BIN_DIR)/client_static
CLIENT_DYNAMIC   = $(BIN_DIR)/client_dynamic

# ============================================================
# Default target: build everything
# ============================================================
all: dirs $(CLIENT_MULTIFILE) $(CLIENT_STATIC) $(CLIENT_DYNAMIC)

# Make sure output directories exist
dirs:
	mkdir -p $(OBJ_DIR) $(LIB_DIR) $(BIN_DIR)

# ============================================================
# Feature-2: Direct multi-file compilation
# ============================================================
$(CLIENT_MULTIFILE): $(MAIN_OBJ) $(OBJS)
	$(CC) -o $@ $^

# ============================================================
# Feature-3: Static library
# ============================================================
$(STATIC_LIB): $(OBJS)
	ar rcs $@ $^

$(CLIENT_STATIC): $(MAIN_OBJ) $(STATIC_LIB)
	$(CC) -o $@ $(MAIN_OBJ) -L$(LIB_DIR) -lmyutils

# ============================================================
# Feature-4: Dynamic library
# ============================================================
$(DYNAMIC_LIB): $(PIC_OBJS)
	$(CC) -shared -o $@ $^

$(CLIENT_DYNAMIC): $(MAIN_OBJ) $(DYNAMIC_LIB)
	$(CC) -o $@ $(MAIN_OBJ) -L$(LIB_DIR) -lmyutils

# ============================================================
# Object file compilation rules
# ============================================================
$(OBJ_DIR)/main.o: $(SRC_DIR)/main.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%_pic.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $(PIC_FLAGS) -c $< -o $@

# ============================================================
# Feature-5: Install / Uninstall
# ============================================================
install: $(CLIENT_DYNAMIC) $(DYNAMIC_LIB)
	install -d $(BINDIR)
	install -m 755 $(CLIENT_DYNAMIC) $(BINDIR)/client
	install -d $(LIBDIR)
	install -m 755 $(DYNAMIC_LIB) $(LIBDIR)
	ldconfig
	install -d $(MANDIR)
	install -m 644 $(MAN_DIR)/*.3 $(MANDIR)

uninstall:
	rm -f $(BINDIR)/client
	rm -f $(LIBDIR)/libmyutils.so
	ldconfig
	rm -f $(MANDIR)/mystrlen.3 $(MANDIR)/mystrcpy.3 $(MANDIR)/mystrncpy.3 \
	      $(MANDIR)/mystrcat.3 $(MANDIR)/wordCount.3 $(MANDIR)/mygrep.3

# ============================================================
# Housekeeping
# ============================================================
clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f $(LIB_DIR)/*.a $(LIB_DIR)/*.so
	rm -f $(CLIENT_MULTIFILE) $(CLIENT_STATIC) $(CLIENT_DYNAMIC)

.PHONY: all dirs install uninstall clean
