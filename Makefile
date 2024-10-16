STM32_PROJECT_ROOT_DIR = ..

STM32_SRC_DIR = $(STM32_PROJECT_ROOT_DIR)/Core/Src
STM32_INCLUDE_DIR = $(STM32_PROJECT_ROOT_DIR)/Core/Inc

# STM32 Drivers Compilation
STM32_DRIVERS_DIR = $(STM32_PROJECT_ROOT_DIR)/Drivers

STM32_HAL_DRIVERS_DIR = $(STM32_DRIVERS_DIR)/STM32F0xx_HAL_Driver
STM32_HAL_DRIVERS_INC_DIR = $(STM32_HAL_DRIVERS_DIR)/Inc
STM32_HAL_DRIVERS_INC_LEG_DIR = $(STM32_HAL_DRIVERS_DIR)/Legacy

STM32_CMSIS_DRIVERS_DIR = $(STM32_DRIVERS_DIR)/CMSIS
STM32_CMSIS_DRIVERS_INC_DIR = $(STM32_CMSIS_DRIVERS_DIR)/Include
STM32_CMSIS_DRIVERS_ST_INC_DIR = $(STM32_CMSIS_DRIVERS_DIR)/Device/ST/STM32F0xx/Include

STM32_HAL_DRIVERS_SRC_DIR= $(STM32_HAL_DRIVERS_DIR)/Src

# Driver Flags
STM32_DRIVER_FLAGS = -mcpu=cortex-m0 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER \
										 -DSTM32F030x8 \
										 -I$(STM32_INCLUDE_DIR) \ 
										 -I$(STM32_DRIVERS_INC_DIR) \ 
										 -I$(STM32_DRIVERS_INC_LEG_DIR) \ 
										 -I$(STM32_CMSIS_DRIVERS_INC_DIR) \ 
										 -I$(STM32_CMSIS_DRIVERS_ST_INC_DIR) \ 
										 -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage \
										 -fcyclomatic-complexity --specs=nano.specs \
										 -mfloat-abi=soft -mthumb \


# Toolchain
CC = arm-none-eabi-gcc

# Files
TARGET = omni-mapper

# Flags
F_MCU = cortex-m0
F_WFLAGS = -Wall -Wextra -Wshadow
F_DEBUG = -g3
F_OPTIMIZATION = -O0

$(TARGET): $(STM32_SRC_DIR)/main.c
	$(CC) "$(STM32_SRC_DIR)/main.c" \
	-mcpu=$(F_MCU) -std=gnu11 \
	$(F_DEBUG) \
	-I$(STM32_INCLUDE_DIR) \
	-I$(STM32_DRIVERS_DIR)/STM32F0xx_HAL_Driver/Inc \
	-I$(STM32_DRIVERS_DIR)/STM32F0xx_HAL_Driver/Inc/Legacy  \
	-I$(STM32_DRIVERS_DIR)/CMSIS/Device/ST/STM32F0xx/Include  \
	-I$(STM32_DRIVERS_DIR)/CMSIS/Include  \
	-DDEBUG -DUSE_HAL_DRIVER -DSTM32F030x8 \
	$(F_OPTIMIZATION) \
	-ffunction-sections -fdata-sections \
	$(F_WFLAGS) \
	-fstack-usage  -MMD -MP \
	-MF"Core/Src/main.d" -MT"Core/Src/main.o" \
	--specs=nano.specs -mfloat-abi=soft -mthumb -o \
	"Core/Src/main.o" -c

# Recipe for HAL_DRIVERS
# arm-none-eabi-gcc "../Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal.c"
#%mcpu=cortex-m0
#%std=gnu11
#%g3
#%DDEBUG
#%DUSE_HAL_DRIVER
#%DSTM32F030x8
# -c
#%-I../Core/Inc
#%-I../Drivers/STM32F0xx_HAL_Driver/Inc
#%-I../Drivers/STM32F0xx_HAL_Driver/Inc/Legacy
#%-I../Drivers/CMSIS/Device/ST/STM32F0xx/Include
#%-I../Drivers/CMSIS/Include
#%-O0
#%-ffunction-sections
#%-fdata-sections
#%-Wall
#%-fstack-usage
#%-fcyclomatic-complexity
# -MMD
# -MP
# -MF"Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal.d"
# -MT"Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal.o"
#%--specs=nano.specs
#%-mfloat-abi=soft
#%-mthumb
# -o "Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal.o"
