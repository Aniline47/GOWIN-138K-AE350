#include <tft/lcd_init.h>

//-----------------LCD�˿ڶ���----------------
AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;
#define LCD_RES_Clr()  GPIO_Dri->PinWrite(GPIO_RES_PIN, 0)
#define LCD_RES_Set()  GPIO_Dri->PinWrite(GPIO_RES_PIN, 1)

#define LCD_DC_Clr()   GPIO_Dri->PinWrite(GPIO_DC_PIN, 0)
#define LCD_DC_Set()   GPIO_Dri->PinWrite(GPIO_DC_PIN, 1)

#define LCD_BLK_Clr()  GPIO_Dri->PinWrite(GPIO_BLK_PIN, 0)
#define LCD_BLK_Set()  GPIO_Dri->PinWrite(GPIO_BLK_PIN, 1)

/******************************************************************************
      ����˵����LCD��������д�뺯��
      ������ݣ�dat  Ҫд��Ĵ�������
      ����ֵ��  ��
******************************************************************************/
void LCD_Writ_Bus(uint8_t dat)
{	
	spi_gpio_send(dat);
}


/******************************************************************************
      ����˵����LCDд������
      ������ݣ�dat д�������
      ����ֵ��  ��
******************************************************************************/
void LCD_WR_DATA8(uint8_t dat)
{
	LCD_Writ_Bus(dat);
}


/******************************************************************************
      ����˵����LCDд������
      ������ݣ�dat д�������
      ����ֵ��  ��
******************************************************************************/
void LCD_WR_DATA(uint16_t dat)
{
	LCD_Writ_Bus(dat>>8);
	LCD_Writ_Bus(dat);
}


/******************************************************************************
      ����˵����LCDд������
      ������ݣ�dat д�������
      ����ֵ��  ��
******************************************************************************/
void LCD_WR_REG(uint8_t dat)
{
	LCD_DC_Clr();//д����
	LCD_Writ_Bus(dat);
	LCD_DC_Set();//д����
}


/******************************************************************************
      ����˵����������ʼ�ͽ�����ַ
      ������ݣ�x1,x2 �����е���ʼ�ͽ�����ַ
                y1,y2 �����е���ʼ�ͽ�����ַ
      ����ֵ��  ��
******************************************************************************/
void LCD_Address_Set(uint16_t x1,uint16_t y1,uint16_t x2,uint16_t y2)
{
	if(USE_HORIZONTAL==0)
	{
		LCD_WR_REG(0x2a);//�е�ַ����
		LCD_WR_DATA(x1+2);
		LCD_WR_DATA(x2+2);
		LCD_WR_REG(0x2b);//�е�ַ����
		LCD_WR_DATA(y1+1);
		LCD_WR_DATA(y2+1);
		LCD_WR_REG(0x2c);//������д
	}
	else if(USE_HORIZONTAL==1)
	{
		LCD_WR_REG(0x2a);//�е�ַ����
		LCD_WR_DATA(x1+2);
		LCD_WR_DATA(x2+2);
		LCD_WR_REG(0x2b);//�е�ַ����
		LCD_WR_DATA(y1+3);
		LCD_WR_DATA(y2+3);
		LCD_WR_REG(0x2c);//������д
	}
	else if(USE_HORIZONTAL==2)
	{
		LCD_WR_REG(0x2a);//�е�ַ����
		LCD_WR_DATA(x1+1);
		LCD_WR_DATA(x2+1);
		LCD_WR_REG(0x2b);//�е�ַ����
		LCD_WR_DATA(y1+2);
		LCD_WR_DATA(y2+2);
		LCD_WR_REG(0x2c);//������д
	}
	else
	{
		LCD_WR_REG(0x2a);//�е�ַ����
		LCD_WR_DATA(x1+3);
		LCD_WR_DATA(x2+3);
		LCD_WR_REG(0x2b);//�е�ַ����
		LCD_WR_DATA(y1+2);
		LCD_WR_DATA(y2+2);
		LCD_WR_REG(0x2c);//������д
	}
}


void LCD_GPIO_Init(void)
{
	spi_gpio_init();
    GPIO_Dri->SetDir(GPIO_TFT_MASK, AE350_GPIO_DIR_OUTPUT);
}

void LCD_Init(void)
{
	LCD_GPIO_Init();//��ʼ��GPIO
	
	LCD_RES_Clr();//��λ
	simple_delay_ms(100);
	LCD_RES_Set();
	simple_delay_ms(100);
	
	LCD_BLK_Set();//�򿪱���
	simple_delay_ms(100);
	
	LCD_WR_REG(0x11); //Sleep out
	simple_delay_ms(100); //Delay 120ms
	//------------------------------------ST7735S Frame rate-------------------------------------------------//
	LCD_WR_REG(0xB1); //Frame rate 80Hz
	LCD_WR_DATA8(0x02);
	LCD_WR_DATA8(0x35);
	LCD_WR_DATA8(0x36);
	LCD_WR_REG(0xB2); //Frame rate 80Hz
	LCD_WR_DATA8(0x02);
	LCD_WR_DATA8(0x35);
	LCD_WR_DATA8(0x36);
	LCD_WR_REG(0xB3); //Frame rate 80Hz
	LCD_WR_DATA8(0x02);
	LCD_WR_DATA8(0x35);
	LCD_WR_DATA8(0x36);
	LCD_WR_DATA8(0x02);
	LCD_WR_DATA8(0x35);
	LCD_WR_DATA8(0x36);
	//------------------------------------End ST7735S Frame rate-------------------------------------------//
	LCD_WR_REG(0xB4); //Dot inversion
	LCD_WR_DATA8(0x03);
	//------------------------------------ST7735S Power Sequence-----------------------------------------//
	LCD_WR_REG(0xC0);
	LCD_WR_DATA8(0xA2);
	LCD_WR_DATA8(0x02);
	LCD_WR_DATA8(0x84);
	LCD_WR_REG(0xC1);
	LCD_WR_DATA8(0xC5);
	LCD_WR_REG(0xC2);
	LCD_WR_DATA8(0x0D);
	LCD_WR_DATA8(0x00);
	LCD_WR_REG(0xC3);
	LCD_WR_DATA8(0x8D);
	LCD_WR_DATA8(0x2A);
	LCD_WR_REG(0xC4);
	LCD_WR_DATA8(0x8D);
	LCD_WR_DATA8(0xEE);
	//---------------------------------End ST7735S Power Sequence---------------------------------------//
	LCD_WR_REG(0xC5); //VCOM
	LCD_WR_DATA8(0x0a);
	LCD_WR_REG(0x36);
	if(USE_HORIZONTAL==0)LCD_WR_DATA8(0x08);
	else if(USE_HORIZONTAL==1)LCD_WR_DATA8(0xC8);
	else if(USE_HORIZONTAL==2)LCD_WR_DATA8(0x78);
	else LCD_WR_DATA8(0xA8);
	//------------------------------------ST7735S Gamma Sequence-----------------------------------------//
	LCD_WR_REG(0XE0);
	LCD_WR_DATA8(0x12);
	LCD_WR_DATA8(0x1C);
	LCD_WR_DATA8(0x10);
	LCD_WR_DATA8(0x18);
	LCD_WR_DATA8(0x33);
	LCD_WR_DATA8(0x2C);
	LCD_WR_DATA8(0x25);
	LCD_WR_DATA8(0x28);
	LCD_WR_DATA8(0x28);
	LCD_WR_DATA8(0x27);
	LCD_WR_DATA8(0x2F);
	LCD_WR_DATA8(0x3C);
	LCD_WR_DATA8(0x00);
	LCD_WR_DATA8(0x03);
	LCD_WR_DATA8(0x03);
	LCD_WR_DATA8(0x10);
	LCD_WR_REG(0XE1);
	LCD_WR_DATA8(0x12);
	LCD_WR_DATA8(0x1C);
	LCD_WR_DATA8(0x10);
	LCD_WR_DATA8(0x18);
	LCD_WR_DATA8(0x2D);
	LCD_WR_DATA8(0x28);
	LCD_WR_DATA8(0x23);
	LCD_WR_DATA8(0x28);
	LCD_WR_DATA8(0x28);
	LCD_WR_DATA8(0x26);
	LCD_WR_DATA8(0x2F);
	LCD_WR_DATA8(0x3B);
	LCD_WR_DATA8(0x00);
	LCD_WR_DATA8(0x03);
	LCD_WR_DATA8(0x03);
	LCD_WR_DATA8(0x10);
	//------------------------------------End ST7735S Gamma Sequence-----------------------------------------//
	LCD_WR_REG(0x3A); //65k mode
	LCD_WR_DATA8(0x05);
	LCD_WR_REG(0x29); //Display on 
}








