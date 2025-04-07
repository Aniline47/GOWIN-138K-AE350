################################################################################
# 自动生成的文件。不要编辑！
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/demo/stubs/close.c \
../src/demo/stubs/exit.c \
../src/demo/stubs/fstat.c \
../src/demo/stubs/isatty.c \
../src/demo/stubs/lseek.c \
../src/demo/stubs/read.c \
../src/demo/stubs/sbrk.c \
../src/demo/stubs/write.c \
../src/demo/stubs/write_hex.c 

OBJS += \
./src/demo/stubs/close.o \
./src/demo/stubs/exit.o \
./src/demo/stubs/fstat.o \
./src/demo/stubs/isatty.o \
./src/demo/stubs/lseek.o \
./src/demo/stubs/read.o \
./src/demo/stubs/sbrk.o \
./src/demo/stubs/write.o \
./src/demo/stubs/write_hex.o 

C_DEPS += \
./src/demo/stubs/close.d \
./src/demo/stubs/exit.d \
./src/demo/stubs/fstat.d \
./src/demo/stubs/isatty.d \
./src/demo/stubs/lseek.d \
./src/demo/stubs/read.d \
./src/demo/stubs/sbrk.d \
./src/demo/stubs/write.d \
./src/demo/stubs/write_hex.d 


# Each subdirectory must supply rules for building sources it contributes
src/demo/stubs/%.o: ../src/demo/stubs/%.c
	@echo '正在构建文件： $<'
	@echo '正在调用： Andes C Compiler'
	$(CROSS_COMPILE)gcc -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/ae350" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/config" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/driver/ae350" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/driver/include" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/lib" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/demo" -Og -mcmodel=medium -g3 -Wall -mcpu=a25 -ffunction-sections -fdata-sections -mext-dsp -c -fmessage-length=0 -fno-builtin -fomit-frame-pointer -fno-strict-aliasing -march=rv32imafdc -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d) $(@:%.o=%.o)" -o "$@" "$<"
	@echo '已结束构建： $<'
	@echo ' '


