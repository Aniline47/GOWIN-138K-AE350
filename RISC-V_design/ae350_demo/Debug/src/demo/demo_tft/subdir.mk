################################################################################
# 自动生成的文件。不要编辑！
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/demo/demo_tft/lcd.c \
../src/demo/demo_tft/lcd_init.c 

OBJS += \
./src/demo/demo_tft/lcd.o \
./src/demo/demo_tft/lcd_init.o 

C_DEPS += \
./src/demo/demo_tft/lcd.d \
./src/demo/demo_tft/lcd_init.d 


# Each subdirectory must supply rules for building sources it contributes
src/demo/demo_tft/%.o: ../src/demo/demo_tft/%.c
	@echo '正在构建文件： $<'
	@echo '正在调用： Andes C Compiler'
	$(CROSS_COMPILE)gcc -I"/cygdrive/E/Gowin/Project_Contest/TangMega-138KPro-example-main/TangMega-138KPro-example-main/ae350_customized_demo/workspace/ae350_demo/src/bsp/ae350" -I"/cygdrive/E/Gowin/Project_Contest/TangMega-138KPro-example-main/TangMega-138KPro-example-main/ae350_customized_demo/workspace/ae350_demo/src/bsp/config" -I"/cygdrive/E/Gowin/Project_Contest/TangMega-138KPro-example-main/TangMega-138KPro-example-main/ae350_customized_demo/workspace/ae350_demo/src/bsp/driver/ae350" -I"/cygdrive/E/Gowin/Project_Contest/TangMega-138KPro-example-main/TangMega-138KPro-example-main/ae350_customized_demo/workspace/ae350_demo/src/bsp/driver/include" -I"/cygdrive/E/Gowin/Project_Contest/TangMega-138KPro-example-main/TangMega-138KPro-example-main/ae350_customized_demo/workspace/ae350_demo/src/bsp/lib" -I"/cygdrive/E/Gowin/Project_Contest/TangMega-138KPro-example-main/TangMega-138KPro-example-main/ae350_customized_demo/workspace/ae350_demo/src/demo" -Og -mcmodel=medium -g3 -Wall -mcpu=a25 -ffunction-sections -fdata-sections -c -fmessage-length=0 -fno-builtin -fomit-frame-pointer -fno-strict-aliasing -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d) $(@:%.o=%.o)" -o "$@" "$<"
	@echo '已结束构建： $<'
	@echo ' '


