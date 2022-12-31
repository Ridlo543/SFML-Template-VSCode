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
  ifeq ($(OS),Windows_NT)
    @echo "------------------------------------------------------------------"
    @echo "			Cleaning build directory..."
    @echo "------------------------------------------------------------------"
    del build\*.o
    del build\*.exe
  else
    @echo "------------------------------------------------------------------"
    @echo "			Cleaning build directory..."
    @echo "------------------------------------------------------------------"
    rm -f build/*.o build/*.exe
  endif
  @echo "			Creating build directory..."
  mkdir -p build
  @echo "------------------------------------------------------------------"
  @echo "			Building '$(PROJECT_NAME)'..."
  @echo "------------------------------------------------------------------"
  $(MAKE) $(TARGET)
  @echo
  @echo "------------------------------------------------------------------"
  @echo "			Copying File..."
  @echo "------------------------------------------------------------------"
  $(MAKE) copy
  @echo
  @echo "------------------------------------------------------------------"
  @echo "			Running project..."
  @echo "------------------------------------------------------------------"
  $(MAKE) run
  @echo "------------------------------------------------------------------"
  @echo "Build finished! Have a nice day!"

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

build/%.o: src/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@
	@echo
	@echo "project built..!"

clean:
  ifeq ($(OS),Windows_NT)
    rd /s /q build
  else
    rm -rf build
  endif
	@echo
	@echo "project clean..!"

copy: $(TARGET)
  ifeq ($(OS),Windows_NT)
    cp lib/SFML-2.5.1/bin/*.dll build
    xcopy /s /i assets\image build
    xcopy /s /i assets\font build
    xcopy /s /i assets\audio build
  else
    cp lib/SFML-2.5.1/bin/*.so build
    cp -rf assets/image build
    cp -rf assets/font build
    cp -rf assets/audio build
  endif
	@echo
	@echo "Supported file copied..!"

run: $(TARGET)
  ifeq ($(OS),Windows_NT)
    cd build && $(TARGET)
  else
    cd build && ./$(PROJECT_NAME)
  endif
	@echo
	@echo "Project finished running..!"
