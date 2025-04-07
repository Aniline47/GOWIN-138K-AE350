#ifndef __LCD_INIT_H
#define __LCD_INIT_H

#include <stdint.h>
#include "spi_gpio_utils.h"
#include "Driver_GPIO.h"
#include "delay.h"
#include "config.h"
#include <stdio.h>
#include "platform.h"

#define USE_HORIZONTAL 1  //设置横屏或者竖屏显示 0或1为竖屏 2或3为横屏
extern AE350_DRIVER_GPIO Driver_GPIO;

#if USE_HORIZONTAL==0||USE_HORIZONTAL==1
#define LCD_W 128
#define LCD_H 128

#else
#define LCD_W 128
#define LCD_H 128
#endif

// 定义GPIO引脚（根据实际硬件修改）

#define GPIO_RES         0x1000
#define GPIO_DC          0x0800
#define GPIO_BLK         0x0400

// 定义 GPIO 引脚（使用 pin_num）
#define GPIO_RES_PIN        12
#define GPIO_DC_PIN         11
#define GPIO_BLK_PIN        10

#define GPIO_TFT_MASK    (GPIO_RES | GPIO_DC | GPIO_BLK)





void LCD_GPIO_Init(void);//初始化GPIO
void LCD_Writ_Bus(uint8_t dat);//模拟SPI时序
void LCD_WR_DATA8(uint8_t dat);//写入一个字节
void LCD_WR_DATA(uint16_t dat);//写入两个字节
void LCD_WR_REG(uint8_t dat);//写入一个指令
void LCD_Address_Set(uint16_t x1,uint16_t y1,uint16_t x2,uint16_t y2);//设置坐标函数
void LCD_Init(void);//LCD初始化
#endif




