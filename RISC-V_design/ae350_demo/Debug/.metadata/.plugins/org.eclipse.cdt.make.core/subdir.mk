################################################################################
# �Զ����ɵ��ļ�����Ҫ�༭��
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../.metadata/.plugins/org.eclipse.cdt.make.core/specs.c 

OBJS += \
./.metadata/.plugins/org.eclipse.cdt.make.core/specs.o 

C_DEPS += \
./.metadata/.plugins/org.eclipse.cdt.make.core/specs.d 


# Each subdirectory must supply rules for building sources it contributes
.metadata/.plugins/org.eclipse.cdt.make.core/%.o: ../.metadata/.plugins/org.eclipse.cdt.make.core/%.c
	@echo '���ڹ����ļ��� $<'
	@echo '���ڵ��ã� Andes C Compiler'
	$(CROSS_COMPILE)gcc -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/ae350" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/config" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/driver/ae350" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/driver/include" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/bsp/lib" -I"/cygdrive/E/Gowin/Project_Contest/GOWIN-138K-AE350/RISC-V_design/ae350_demo/src/demo" -Og -mcmodel=medium -g3 -Wall -mcpu=a25 -ffunction-sections -fdata-sections -mext-dsp -c -fmessage-length=0 -fno-builtin -fomit-frame-pointer -fno-strict-aliasing -march=rv32imafdc -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d) $(@:%.o=%.o)" -o "$@" "$<"
	@echo '�ѽ��������� $<'
	@echo ' '


