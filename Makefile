BUILD_DIR = ./build
OPTIONS = -march=armv8-a+sve

$(shell mkdir -p $(BUILD_DIR))

KERNELS = ./kernels/gemm_asm_sve_128_6_48.s
OBJ_FILES = $(patsubst kernels/%.s, $(BUILD_DIR)/%.o, $(KERNELS))

test: $(OBJ_FILES) test.cpp
	g++ ${OPTIONS} -g -pedantic -Wall -Wextra -Werror -O2 -fopenmp $^ -o $(BUILD_DIR)/test