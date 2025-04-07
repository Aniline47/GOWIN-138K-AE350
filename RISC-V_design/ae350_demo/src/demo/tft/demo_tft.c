/*
 * demo_tft.c
 *
 *  Created on: 2025年4月4日
 *      Author: AAA
 */

#include "demo.h"

#include "lcd_init.h"
#include "lcd.h"
#include "pic.h"
#include "uart.h"

#if RUN_DEMO_TFT

int demo_tft(){

	double t=0;
	LCD_Init();//LCD初始化
	LCD_Fill(0,0,LCD_W,LCD_H,WHITE);
	uart_init(115200);
	while(1){
		printf("working\n");
		LCD_ShowString(24,30,"LCD_W:",RED,WHITE,16,0);
		LCD_ShowIntNum(72,30,LCD_W,3,RED,WHITE,16);
		LCD_ShowString(24,50,"LCD_H:",RED,WHITE,16,0);
		LCD_ShowIntNum(72,50,LCD_H,3,RED,WHITE,16);
		LCD_ShowFloatNum1(50,80,t,5,RED,WHITE,16);
		t+=0.11;
		simple_delay_ms(100);

	}
}
#endif /* RUN_DEMO_tft */
