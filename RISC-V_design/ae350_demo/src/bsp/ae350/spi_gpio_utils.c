/*
 * spi_gpio_utils.c
 *
 *  Created on: 2025年4月4日
 *      Author: AAA
 */

#include <spi_gpio_utils.h>
#include "Driver_GPIO.h"
#include "uart.h"
#include "delay.h"

extern AE350_DRIVER_GPIO Driver_GPIO;

void gpio_callback_spi(uint32_t event)
{
	switch (event)
	{
		// Don't have GPIO pins as interrupt event
		default:
			break;
	}
}
// 初始化SPI GPIO方向和默认状态
void spi_gpio_init() {
    AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;

    // 设置GPIO方向：
    // - CS、SCK、MOSI为输出
    // - MISO为输入
    GPIO_Dri->Initialize(gpio_callback_spi);
    GPIO_Dri->SetDir(GPIO_CS | GPIO_SCK | GPIO_MOSI, AE350_GPIO_DIR_OUTPUT);
    GPIO_Dri->SetDir(GPIO_MISO, AE350_GPIO_DIR_INPUT);

    // 初始化时拉高CS（不选中从设备）
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 1);
}

// 发送数据函数（支持8/16位，MSB/LSB配置）
void spi_gpio_send(uint16_t data) {
    AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;

    // 选中从设备（拉低CS）
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 0);

    #if SPI_MSB_FIRST
        int start = (SPI_DATA_BITS - 1);
        int end = -1;
        int step = -1;
    #else
        int start = 0;
        int end = SPI_DATA_BITS;
        int step = 1;
    #endif

    for (int i = start; i != end; i += step) {
        // 设置MOSI电平
        if (data & (1 << i)) {
            GPIO_Dri->PinWrite(GPIO_MOSI_PIN, 1);
        } else {
            GPIO_Dri->PinWrite(GPIO_MOSI_PIN, 0);
        }

        // 生成时钟脉冲（假设在SCK上升沿采样）
        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 1);  // SCK高电平
        //simple_delay_ms(10);            // 稳定时间
        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 0);  // SCK低电平
        //simple_delay_ms(10);            // 下一个时钟周期前的延迟
    }

    // 取消选中从设备（拉高CS）
    GPIO_Dri->Write(GPIO_CS, 1);
}

// 接收数据函数（支持8/16位，MSB/LSB配置）
uint16_t spi_gpio_receive() {
    AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;
    uint16_t received_data = 0;

    // 选中从设备（拉低CS）
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 0);

    #if SPI_MSB_FIRST
        int start = (SPI_DATA_BITS - 1);
        int end = -1;
        int step = -1;
    #else
        int start = 0;
        int end = SPI_DATA_BITS;
        int step = 1;
    #endif

    for (int i = start; i != end; i += step) {
        // 生成时钟脉冲（假设在SCK上升沿采样）
        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 1);  // SCK高电平
        simple_delay_ms(1);            // 稳定时间

        // 读取MISO的当前电平
        if (GPIO_Dri->PinRead(GPIO_MISO_PIN)) {
            received_data |= (1 << i);
        }

        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 0);  // SCK低电平
        simple_delay_ms(1);            // 下一个时钟周期前的延迟
    }

    // 取消选中从设备（拉高CS）
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 1);

    return received_data;
}

// 收发数据函数（支持8/16位，MSB/LSB配置）
void spi_gpio_transceive(uint16_t send_data, uint16_t *received_data) {
    AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;
    *received_data = 0;  // 初始化接收数据

    // 选中从设备（拉低CS）
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 0);

    #if SPI_MSB_FIRST
        int start = (SPI_DATA_BITS - 1);
        int end = -1;
        int step = -1;
    #else
        int start = 0;
        int end = SPI_DATA_BITS;
        int step = 1;
    #endif

    for (int i = start; i != end; i += step) {
        // 设置MOSI电平（发送）
        if (send_data & (1 << i)) {
            GPIO_Dri->PinWrite(GPIO_MOSI_PIN, 1);
        } else {
            GPIO_Dri->PinWrite(GPIO_MOSI_PIN, 0);
        }

        // 生成时钟脉冲（假设在SCK上升沿采样）
        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 1);  // SCK高电平
        simple_delay_ms(1);            // 稳定时间

        // 读取MISO的当前电平（接收）
        if (GPIO_Dri->PinRead(GPIO_MISO_PIN)) {
            *received_data |= (1 << i);
        }

        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 0);  // SCK低电平
        simple_delay_ms(1);            // 下一个时钟周期前的延迟
    }

    // 取消选中从设备（拉高CS）
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 1);
}
