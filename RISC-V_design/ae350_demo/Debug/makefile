################################################################################
# 自动生成的文件。不要编辑！
################################################################################

ifndef ANDESIGHT_ROOT
ANDESIGHT_ROOT=/cygdrive/E/Gowin/RDS
endif

ifndef CROSS_COMPILE
CROSS_COMPILE=riscv32-elf-
endif

ifndef SECONDARY_OUTPUT_PATH
SECONDARY_OUTPUT_PATH=output
endif

$(shell mkdir -p $(SECONDARY_OUTPUT_PATH))

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include .metadata/.plugins/org.eclipse.cdt.make.core/subdir.mk
-include src/bsp/ae350/subdir.mk
-include src/bsp/driver/ae350/subdir.mk
-include src/bsp/lib/subdir.mk
-include src/demo/cache/subdir.mk
-include src/demo/cache_lock/subdir.mk
-include src/demo/ddr3/subdir.mk
-include src/demo/dsp/subdir.mk
-include src/demo/gpio/subdir.mk
-include src/demo/gpio_spi/subdir.mk
-include src/demo/hsp/subdir.mk
-include src/demo/i2c/subdir.mk
-include src/demo/intr/subdir.mk
-include src/demo/led/subdir.mk
-include src/demo/subdir.mk
-include src/demo/mm/subdir.mk
-include src/demo/pfm/subdir.mk
-include src/demo/plic/subdir.mk
-include src/demo/plmt/subdir.mk
-include src/demo/powerbrake/subdir.mk
-include src/demo/printf/subdir.mk
-include src/demo/pwm/subdir.mk
-include src/demo/ram/subdir.mk
-include src/demo/rtc/subdir.mk
-include src/demo/scanf/subdir.mk
-include src/demo/slaveport/subdir.mk
-include src/demo/spi/subdir.mk
-include src/demo/stubs/subdir.mk
-include src/demo/tft/subdir.mk
-include src/demo/uart/subdir.mk
-include src/demo/wdt_pit/subdir.mk
-include src/demo/wfi/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
BUILD_ARTIFACT_FILE_BASE_NAME = ae350_demo

LINKER_OUTPUTS = ae350_demo.adx

GPROF_OUT += \
../gmon.sum ../gmon.out \

GCOV_OUT += \
$(foreach subdir,$(SUBDIRS),$(wildcard $(subdir)/*.gcda) $(wildcard $(subdir)/*.gcno)) \

SYMBOL_OUTPUTS += \
$(SECONDARY_OUTPUT_PATH)/symbol.txt \

READELF_OUTPUTS += \
$(SECONDARY_OUTPUT_PATH)/readelf.txt \

OBJDUMP_OUTPUTS += \
$(SECONDARY_OUTPUT_PATH)/objdump.txt \

OBJCOPY_OUTPUTS += \
$(SECONDARY_OUTPUT_PATH)/$(BUILD_ARTIFACT_FILE_BASE_NAME).bin \

SIZE_OUTPUTS += \
$(SECONDARY_OUTPUT_PATH)/.PHONY.size \

LDSAG_OUT = $(SECONDARY_OUTPUT_PATH)/ae350-ddr.ld

# 所有目标
all: ae350_demo.adx secondary-outputs

# 工具调用
ae350_demo.adx: $(OBJS) $(USER_OBJS) $(LDSAG_OUT)
	@echo '正在构建目标： $@'
	@echo '正在调用： Andes C Linker'
	$(CROSS_COMPILE)gcc -Og -nostartfiles -static -mcmodel=medium -T"$(LDSAG_OUT)" -Wl,--gc-sections -mext-dsp -ldsp -lm -o "ae350_demo.adx" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo '已结束构建目标： $@'
	@echo ' '

$(foreach subdir,$(SUBDIRS),$(wildcard $(subdir)/*.gcda) $(wildcard $(subdir)/*.gcno)): ae350_demo.adx $(OBJS) $(USER_OBJS) $(LDSAG_OUT)
../gmon.sum ../gmon.out: ae350_demo.adx $(OBJS) $(USER_OBJS) $(LDSAG_OUT)

$(SECONDARY_OUTPUT_PATH)/symbol.txt: $(LINKER_OUTPUTS)
	@echo '正在调用： NM (symbol listing)'
	$(CROSS_COMPILE)nm -n -l -C "ae350_demo.adx" > $(SECONDARY_OUTPUT_PATH)/symbol.txt
	@echo '已结束构建： $@'
	@echo ' '

$(SECONDARY_OUTPUT_PATH)/readelf.txt: $(LINKER_OUTPUTS)
	@echo '正在调用： Readelf (ELF info listing)'
	$(CROSS_COMPILE)readelf -a "ae350_demo.adx" > $(SECONDARY_OUTPUT_PATH)/readelf.txt
	@echo '已结束构建： $@'
	@echo ' '

$(SECONDARY_OUTPUT_PATH)/objdump.txt: $(LINKER_OUTPUTS)
	@echo '正在调用： Objdump (disassembly)'
	$(CROSS_COMPILE)objdump -x -d -C "ae350_demo.adx" > $(SECONDARY_OUTPUT_PATH)/objdump.txt
	@echo '已结束构建： $@'
	@echo ' '

$(SECONDARY_OUTPUT_PATH)/$(BUILD_ARTIFACT_FILE_BASE_NAME).bin: $(LINKER_OUTPUTS)
	@echo '正在调用： Objcopy (object content copy)'
	$(CROSS_COMPILE)objcopy -S -O binary "ae350_demo.adx" $(SECONDARY_OUTPUT_PATH)/$(BUILD_ARTIFACT_FILE_BASE_NAME).bin
	@echo '已结束构建： $@'
	@echo ' '

$(SECONDARY_OUTPUT_PATH)/.PHONY.size: $(LINKER_OUTPUTS)
	@echo '正在调用： Size (section size listing)'
	$(CROSS_COMPILE)size  "ae350_demo.adx" | tee $(SECONDARY_OUTPUT_PATH)/.PHONY.size
	@echo '已结束构建： $@'
	@echo ' '

$(SECONDARY_OUTPUT_PATH)/ae350-ddr.ld: $(SAG_SRCS)
	@echo '正在调用： LdSaG Tool'
	nds_ldsag --version=v5 -t "$(ANDESIGHT_ROOT)/utils/nds32_template_v5.txt" "$(SAG_FILE)" -o $(LDSAG_OUT)
	@echo '已结束构建： $@'
	@echo ' '

# 其他目标
clean:
	-$(RM) $(GPROF_OUT) $(SIZE_OUTPUTS) $(READELF_OUTPUTS) $(LDSAG_OUT) $(EXECUTABLES) $(OBJDUMP_OUTPUTS) $(OBJS) $(SYMBOL_OUTPUTS) $(S_UPPER_DEPS) $(GCOV_OUT) $(C_DEPS) $(OBJCOPY_OUTPUTS) ae350_demo.adx
	-@echo ' '

secondary-outputs: $(SYMBOL_OUTPUTS) $(READELF_OUTPUTS) $(OBJDUMP_OUTPUTS) $(OBJCOPY_OUTPUTS) $(SIZE_OUTPUTS)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
