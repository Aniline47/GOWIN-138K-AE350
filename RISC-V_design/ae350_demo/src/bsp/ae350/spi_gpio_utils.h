/*
 * spi_gpio_utils.h
 *
 *  Created on: 2025��4��4��
 *      Author: AAA
 */

#ifndef __SPI_GPIO_UTILS_H__
#define __SPI_GPIO_UTILS_H__

#include <stdint.h>

// ********** ����SPI���� ********** //
// ����λ����8λ��16λ��
#define SPI_DATA_BITS        8   // �ɸ�Ϊ16

// ����˳��MSB��LSB first��
#define SPI_MSB_FIRST        1   // 1��ʾMSB first��0��ʾLSB first

// ����GPIO���ţ�����ʵ��Ӳ���޸ģ�
#define GPIO_CS          0x0200  // оƬѡ��Chip Select��
#define GPIO_SCK         0x0100  // ʱ���źţ�Serial Clock��
#define GPIO_MOSI        0x0080   // ����������루Master Out Slave In��
#define GPIO_MISO        0x0040   // ������������Master In Slave Out��

// ���� GPIO ���ţ�ʹ�� pin_num��
#define GPIO_CS_PIN         9    // оƬѡ��Chip Select��
#define GPIO_SCK_PIN        8    // ʱ���źţ�Serial Clock��
#define GPIO_MOSI_PIN       7    // ����������루Master Out Slave In��
#define GPIO_MISO_PIN       6    // ������������Master In Slave Out��

#define GPIO_SPI_MASK    (GPIO_CS | GPIO_SCK | GPIO_MOSI | GPIO_MISO)

// ��������
void spi_gpio_init(void);       // ��ʼ��SPI GPIO
void spi_gpio_send(uint16_t data);   // �������ݣ�֧��8/16λ��
uint16_t spi_receive(void);     // �������ݣ�֧��8/16λ��
void spi_gpio_transceive(uint16_t send_data, uint16_t *received_data);  // ͬʱ���ͺͽ�������

#endif // __SPI_GPIO_UTILS_H__
