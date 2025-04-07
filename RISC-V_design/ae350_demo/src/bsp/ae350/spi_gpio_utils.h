/*
 * spi_gpio_utils.h
 *
 *  Created on: 2025年4月4日
 *      Author: AAA
 */

#ifndef __SPI_GPIO_UTILS_H__
#define __SPI_GPIO_UTILS_H__

#include <stdint.h>

// ********** 定义SPI参数 ********** //
// 数据位数（8位或16位）
#define SPI_DATA_BITS        8   // 可改为16

// 数据顺序（MSB或LSB first）
#define SPI_MSB_FIRST        1   // 1表示MSB first，0表示LSB first

// 定义GPIO引脚（根据实际硬件修改）
#define GPIO_CS          0x0200  // 芯片选择（Chip Select）
#define GPIO_SCK         0x0100  // 时钟信号（Serial Clock）
#define GPIO_MOSI        0x0080   // 主输出从输入（Master Out Slave In）
#define GPIO_MISO        0x0040   // 主输入从输出（Master In Slave Out）

// 定义 GPIO 引脚（使用 pin_num）
#define GPIO_CS_PIN         9    // 芯片选择（Chip Select）
#define GPIO_SCK_PIN        8    // 时钟信号（Serial Clock）
#define GPIO_MOSI_PIN       7    // 主输出从输入（Master Out Slave In）
#define GPIO_MISO_PIN       6    // 主输入从输出（Master In Slave Out）

#define GPIO_SPI_MASK    (GPIO_CS | GPIO_SCK | GPIO_MOSI | GPIO_MISO)

// 函数声明
void spi_gpio_init(void);       // 初始化SPI GPIO
void spi_gpio_send(uint16_t data);   // 发送数据（支持8/16位）
uint16_t spi_receive(void);     // 接收数据（支持8/16位）
void spi_gpio_transceive(uint16_t send_data, uint16_t *received_data);  // 同时发送和接收数据

#endif // __SPI_GPIO_UTILS_H__
