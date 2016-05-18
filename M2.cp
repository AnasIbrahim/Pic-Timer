#line 1 "E:/Anas/a Studing/1. Electrical, Mechatronics, Programming & Basic Science Books/Projects/Mohamed Timer Project/M2.c"

sbit LCD_RS at RB5_bit;
sbit LCD_EN at RB4_bit;
sbit LCD_D4 at RB3_bit;
sbit LCD_D5 at RB2_bit;
sbit LCD_D6 at RB1_bit;
sbit LCD_D7 at RB0_bit;

sbit LCD_RS_Direction at TRISB5_bit;
sbit LCD_EN_Direction at TRISB4_bit;
sbit LCD_D4_Direction at TRISB3_bit;
sbit LCD_D5_Direction at TRISB2_bit;
sbit LCD_D6_Direction at TRISB1_bit;
sbit LCD_D7_Direction at TRISB0_bit;
#line 30 "E:/Anas/a Studing/1. Electrical, Mechatronics, Programming & Basic Science Books/Projects/Mohamed Timer Project/M2.c"
char txt[7];

void settingDevicesTime(unsigned short *secON, unsigned short *minOff, unsigned short deviceNumber)
{

 LCD_out(1, 1, "device ");
 LCD_Chr(1, 8, deviceNumber);
 LCD_Out(1, 10, "Sec On:");
 while ( PortC.F2  == 0)
 {
 if ( PortC.F0  == 1)
 {
 delay_ms(30);
 if ( PortC.F0  == 1)
 {
 *secOn = *secOn + 1;

 delay_ms(300);

 }
 }
 if ( PortC.F1  == 1)
 {
 delay_ms(30);
 if ( PortC.F1  == 1)
 {
 *secOn = *secOn - 1;
 if (*secOn == 255) { *secOn = 0; }

 delay_ms(300);

 }
 }
 byteToStr(*secOn, txt);
 LCD_OUT(2, 1, txt);
 }

 while( PortC.F2  == 1){}

 LCD_CMD(_LCD_Clear);
 LCD_Out(1, 1, "Seconds Set");
 delay_ms(700);
 LCD_CMD(_LCD_Clear);


 LCD_out(1, 1, "device ");
 LCD_Chr(1, 8, deviceNumber);
 LCD_Out(1, 10, "Min Off:");
 while ( PortC.F2  == 0)
 {
 if ( PortC.F0  == 1)
 {
 delay_ms(30);
 if ( PortC.F0  == 1)
 {
 *minOff = *minOff + 1;

 delay_ms(300);

 }
 }
 if ( PortC.F1  == 1)
 {
 delay_ms(30);
 if ( PortC.F1  == 1)
 {
 *minOff = *minOff - 1;
 if (*minOff == 255) { *minOff = 0; }

 delay_ms(300);

 }
 }
 byteToStr(*minOff, txt);
 LCD_OUT(2, 1, txt);
 }

 while( PortC.F2  == 1){}

 LCD_CMD(_LCD_Clear);
 LCD_Out(1, 1, "Minutes Set");
 delay_ms(700);
 LCD_CMD(_LCD_Clear);

 LCD_Out(1, 1, "Seconds = ");
 IntToStr(*secOn, txt);
 LCD_Out(1, 11, txt);
 LCD_Out(2, 1, "Minutes = ");
 IntToStr(*minOff, txt);
 LCD_Out(2, 11, txt);
 delay_ms(700);
 LCD_CMD(_LCD_Clear);
}

void setDevice(unsigned short *count, unsigned short *secOn, int totalTime, char device)
{
 if (*count < *secOn)
 {
 if (device == '1') {  PortC.F4  =  1 ; LCD_OUT(2, 3, "ON "); }
 else if (device == '2') {  PortC.F5  =  1 ; LCD_OUT(2, 9, "ON "); }
 else if (device == '3') {  PortC.F6  =  1 ; LCD_OUT(2, 15, "ON "); }
 }
 else if (*count >= *secOn)
 {
 if (device == '1') {  PortC.F4  =  0 ; LCD_OUT(2, 3, "Off"); }
 else if (device == '2') {  PortC.F5  =  0 ; LCD_OUT(2, 9, "Off"); }
 else if (device == '3') {  PortC.F6  =  0 ; LCD_OUT(2, 15, "Off");}
 }
 *count = *count + 1;
 if (*count == totalTime){ *count = 0;}
}

void main()
{
 unsigned short secOn1 = 3, minOff1 = 1, secOn2 = 6, minOff2 = 1, secOn3 = 9, minOff3 = 1;
 int totalTime1 = 0, totalTime2 = 0, totalTime3 = 0;
 unsigned short count1 = 0, count2 = 0, count3 = 0;
 int count = 0;
 unsigned short sec, min;


 TrisB = 0x00;
 TrisC = 0x0F;


 LCD_Init();
 LCD_CMD(_LCD_Cursor_Off);


 LCD_Out(1, 1, "Welcome");
 delay_ms(700);
 LCD_CMD(_LCD_Clear);


 settingDevicesTime(&secOn1, &minOff1, '1');


 settingDevicesTime(&secOn2, &minOff2, '2');


 settingDevicesTime(&secOn3, &minOff3, '3');


 totalTime1 = (int)minOff1 * 60 + (int)secOn1;
 totalTime2 = (int)minOff2 * 60 + (int)secOn2;
 totalTime3 = (int)minOff3 * 60 + (int)secOn3;


 LCD_Out(2, 1, "1:");
 LCD_Out(2, 7, "2:");
 LCD_Out(2, 13, "3:");


 while(1)
 {

 setDevice(&count1, &secOn1, totalTime1, '1');

 setDevice(&count2, &secOn2, totalTime2, '2');

 setDevice(&count3, &secOn3, totalTime3, '3');


 min = (unsigned short)(count / 60);
 sec = (unsigned short)(count - min * 60);
 byteToStr(sec, txt);
 LCD_Out(1, 12, txt);
 intToStr(min, txt);
 LCD_Out(1, 1, txt);
 LCD_Out(1, 1, "Min:");
 LCD_Out(1, 7, ",");
 LCD_Out(1, 9, "sec:");

 delay_ms(1000);
 count++;
 }
}
