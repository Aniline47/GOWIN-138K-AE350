################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/bsp/driver/ae350/dma_ae350.c \
../src/bsp/driver/ae350/gpio_ae350.c \
../src/bsp/driver/ae350/i2c_ae350.c \
../src/bsp/driver/ae350/pit_ae350.c \
../src/bsp/driver/ae350/pwm_ae350.c \
../src/bsp/driver/ae350/rtc_ae350.c \
../src/bsp/driver/ae350/spi_ae350.c \
../src/bsp/driver/ae350/uart_ae350.c \
../src/bsp/driver/ae350/wdt_ae350.c 

OBJS += \
./src/bsp/driver/ae350/dma_ae350.o \
./src/bsp/driver/ae350/gpio_ae350.o \
./src/bsp/driver/ae350/i2c_ae350.o \
./src/bsp/driver/ae350/pit_ae350.o \
./src/bsp/driver/ae350/pwm_ae350.o \
./src/bsp/driver/ae350/rtc_ae350.o \
./src/bsp/driver/ae350/spi_ae350.o \
./src/bsp/driver/ae350/uart_ae350.o \
./src/bsp/driver/ae350/wdt_ae350.o 

C_DEPS += \
./src/bsp/driver/ae350/dma_ae350.d \
./src/bsp/driver/ae350/gpio_ae350.d \
./src/bsp/driver/ae350/i2c_ae350.d \
./src/bsp/driver/ae350/pit_ae350.d \
./src/bsp/driver/ae350/pwm_ae350.d \
./src/bsp/driver/ae350/rtc_ae350.d \
./src/bsp/driver/ae350/spi_ae350.d \
./src/bsp/driver/ae350/uart_ae350.d \
./src/bsp/driver/ae350/wdt_ae350.d 


# Each subdirectory must supply rules for building sources it contributes
src/bsp/driver/ae350/%.o: ../src/bsp/driver/ae350/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Andes C Compiler'
	$(CROSS_COMPILE)gcc -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/ae350" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/config" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/driver/ae350" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/driver/include" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/lib" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/demo" -Og -mcmodel=medium -g -Wall -mcpu=a25 -ffunction-sections -fdata-sections -c -fmessage-length=0 -fno-builtin -fomit-frame-pointer -fno-strict-aliasing -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d) $(@:%.o=%.o)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


