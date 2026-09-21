CC = gcc
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

