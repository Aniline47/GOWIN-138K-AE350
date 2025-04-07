/*
 * spi_gpio_utils.c
 *
 *  Created on: 2025年4月4日
 *      Author: AAA
 */

// Includes ---------------------------------------------------------------------------------
#include "demo.h"

// If running waterfall led demo
#if RUN_GPIO_SPI

// *********** Includes *********** //
#include "Driver_GPIO.h"
#include "uart.h"
#include "delay.h"
#include "config.h"
#include <stdio.h>
#include "platform.h"
#include <spi_gpio_utils.h>

int gpio_spi() {
    // 初始化UART和SPI
    uart_init(115200);
    spi_gpio_init();

    // 示例数据
    uint8_t send_data_8 = 0xAA;

    // 发送8位数据
    while(1){
    	spi_gpio_send(send_data_8);
    	printf("8-bit: Send 0x%02X\n", send_data_8);
    	simple_delay_ms(1000);
    }
//    received_data_8 = spi_receive();
//    printf("8-bit: Send 0x%02X, Receive 0x%02X\r\n", send_data_8, received_data_8);

    return 0;
}

#endif

