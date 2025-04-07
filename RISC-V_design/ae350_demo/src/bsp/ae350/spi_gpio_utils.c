/*
 * spi_gpio_utils.c
 *
 *  Created on: 2025��4��4��
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
// ��ʼ��SPI GPIO�����Ĭ��״̬
void spi_gpio_init() {
    AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;

    // ����GPIO����
    // - CS��SCK��MOSIΪ���
    // - MISOΪ����
    GPIO_Dri->Initialize(gpio_callback_spi);
    GPIO_Dri->SetDir(GPIO_CS | GPIO_SCK | GPIO_MOSI, AE350_GPIO_DIR_OUTPUT);
    GPIO_Dri->SetDir(GPIO_MISO, AE350_GPIO_DIR_INPUT);

    // ��ʼ��ʱ����CS����ѡ�д��豸��
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 1);
}

// �������ݺ�����֧��8/16λ��MSB/LSB���ã�
void spi_gpio_send(uint16_t data) {
    AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;

    // ѡ�д��豸������CS��
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
        // ����MOSI��ƽ
        if (data & (1 << i)) {
            GPIO_Dri->PinWrite(GPIO_MOSI_PIN, 1);
        } else {
            GPIO_Dri->PinWrite(GPIO_MOSI_PIN, 0);
        }

        // ����ʱ�����壨������SCK�����ز�����
        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 1);  // SCK�ߵ�ƽ
        //simple_delay_ms(10);            // �ȶ�ʱ��
        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 0);  // SCK�͵�ƽ
        //simple_delay_ms(10);            // ��һ��ʱ������ǰ���ӳ�
    }

    // ȡ��ѡ�д��豸������CS��
    GPIO_Dri->Write(GPIO_CS, 1);
}

// �������ݺ�����֧��8/16λ��MSB/LSB���ã�
uint16_t spi_gpio_receive() {
    AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;
    uint16_t received_data = 0;

    // ѡ�д��豸������CS��
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
        // ����ʱ�����壨������SCK�����ز�����
        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 1);  // SCK�ߵ�ƽ
        simple_delay_ms(1);            // �ȶ�ʱ��

        // ��ȡMISO�ĵ�ǰ��ƽ
        if (GPIO_Dri->PinRead(GPIO_MISO_PIN)) {
            received_data |= (1 << i);
        }

        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 0);  // SCK�͵�ƽ
        simple_delay_ms(1);            // ��һ��ʱ������ǰ���ӳ�
    }

    // ȡ��ѡ�д��豸������CS��
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 1);

    return received_data;
}

// �շ����ݺ�����֧��8/16λ��MSB/LSB���ã�
void spi_gpio_transceive(uint16_t send_data, uint16_t *received_data) {
    AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;
    *received_data = 0;  // ��ʼ����������

    // ѡ�д��豸������CS��
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
        // ����MOSI��ƽ�����ͣ�
        if (send_data & (1 << i)) {
            GPIO_Dri->PinWrite(GPIO_MOSI_PIN, 1);
        } else {
            GPIO_Dri->PinWrite(GPIO_MOSI_PIN, 0);
        }

        // ����ʱ�����壨������SCK�����ز�����
        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 1);  // SCK�ߵ�ƽ
        simple_delay_ms(1);            // �ȶ�ʱ��

        // ��ȡMISO�ĵ�ǰ��ƽ�����գ�
        if (GPIO_Dri->PinRead(GPIO_MISO_PIN)) {
            *received_data |= (1 << i);
        }

        GPIO_Dri->PinWrite(GPIO_SCK_PIN, 0);  // SCK�͵�ƽ
        simple_delay_ms(1);            // ��һ��ʱ������ǰ���ӳ�
    }

    // ȡ��ѡ�д��豸������CS��
    GPIO_Dri->PinWrite(GPIO_CS_PIN, 1);
}
