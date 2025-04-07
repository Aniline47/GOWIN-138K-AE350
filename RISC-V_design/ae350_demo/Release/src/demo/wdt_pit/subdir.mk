################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/demo/wdt_pit/demo_wdt_pit.c 

OBJS += \
./src/demo/wdt_pit/demo_wdt_pit.o 

C_DEPS += \
./src/demo/wdt_pit/demo_wdt_pit.d 


# Each subdirectory must supply rules for building sources it contributes
src/demo/wdt_pit/%.o: ../src/demo/wdt_pit/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Andes C Compiler'
	$(CROSS_COMPILE)gcc -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/ae350" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/config" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/driver/ae350" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/driver/include" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/bsp/lib" -I"/cygdrive/E/RDS5/workspace/ae350_demo/src/demo" -Og -mcmodel=medium -g -Wall -mcpu=a25 -ffunction-sections -fdata-sections -c -fmessage-length=0 -fno-builtin -fomit-frame-pointer -fno-strict-aliasing -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d) $(@:%.o=%.o)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


