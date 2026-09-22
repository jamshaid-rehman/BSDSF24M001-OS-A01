CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -D_POSIX_C_SOURCE=200809L

SRC_DIR = src
OBJ_DIR = obj
LIB_DIR = lib
BIN_DIR = bin

LIB = $(LIB_DIR)/libmyutils.a
TARGET = $(BIN_DIR)/client_static

LIB_SOURCES = $(SRC_DIR)/mystrfunctions.c \
              $(SRC_DIR)/myfilefunctions.c

LIB_OBJECTS = $(LIB_SOURCES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

MAIN_OBJECT = $(OBJ_DIR)/main.o


all: $(TARGET)


$(LIB): $(LIB_OBJECTS)
	@mkdir -p $(LIB_DIR)
	ar rcs $(LIB) $(LIB_OBJECTS)
	ranlib $(LIB)


$(TARGET): $(MAIN_OBJECT) $(LIB)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) $(MAIN_OBJECT) $(LIB) -o $(TARGET)


$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@


clean:
	rm -rf $(OBJ_DIR) $(LIB) $(TARGET)


run: $(TARGET)
	./$(TARGET)


rebuild: clean all


.PHONY: all clean run rebuildCC = gcc
CFLAGS = -Wall -Wextra -std=c11 -D_POSIX_C_SOURCE=200809L

TARGET = bin/client

SRC_DIR = src
OBJ_DIR = obj

SOURCES = $(SRC_DIR)/mystrfunctions.c \
          $(SRC_DIR)/myfilefunctions.c \
          $(SRC_DIR)/main.c

OBJECTS = $(SOURCES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)


all: $(TARGET)


$(TARGET): $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(TARGET)


$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@


clean:
	rm -rf $(OBJ_DIR) $(TARGET)


run: $(TARGET)
	./$(TARGET)


rebuild: clean all


.PHONY: all clean run rebuildO

