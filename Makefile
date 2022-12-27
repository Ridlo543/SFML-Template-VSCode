CC = g++
CFLAGS = -std=c++11 -I lib/SFML-2.5.1/include
LDFLAGS = -L lib/SFML-2.5.1/lib
LDLIBS = -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

SRCS = $(wildcard src/*.cpp)
SRCS += src/main.cpp
OBJS = $(SRCS:src/%.cpp=build/%.o)

PROJECT_NAME = project1
TARGET = build/$(PROJECT_NAME)

.PHONY: all clean copy run

all:	
	@echo "			Creating build directory..."
	mkdir -p build
	@echo "------------------------------------------------------------------"
	@echo "			Building '$(PROJECT_NAME)'..."
	@echo "------------------------------------------------------------------"
	@$(MAKE) $(TARGET)

	@echo
	@echo "------------------------------------------------------------------"
	@echo "			Copying SFML DLLs..."
	@echo "------------------------------------------------------------------"
	@$(MAKE) copy
	
	@echo
	@echo "------------------------------------------------------------------"
	@echo "			Running project..."
	@echo "------------------------------------------------------------------"
	@$(MAKE) run
	@echo "------------------------------------------------------------------"
	@echo "Build finished! Have a nice day!"

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

build/%.o: src/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@
	@echo
	@echo "project built..!"

clean:
	rm -f $(OBJS) $(TARGET)
	@echo
	@echo "project clean..!"

copy: $(TARGET)
	cp lib/SFML-2.5.1/bin/*.dll build
	@echo
	@echo "SFML DLLs copied..!"

run: $(TARGET)
	cd build && ./$(PROJECT_NAME)
	@echo
	@echo "Project finished running..!"