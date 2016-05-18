#line 1 "C:/Users/Anas/Desktop/M/M.c"

sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;
#line 30 "C:/Users/Anas/Desktop/M/M.c"
char txt[7];

void settingDevicesTime(int *secON, int *minOff, unsigned short deviceNumber)
{

 LCD_out(1, 1, "device ");
 LCD_Chr(1, 8, deviceNumber);
 LCD_Out(1, 10, "Sec On:");
 while ( PortC.F2  == 0)
 {
 if ( PortC.F0  == 1)
 {
 *secOn = *secOn + 1;

 delay_ms(300);

 }
 if ( PortC.F1  == 1)
 {
 *secOn = *secOn - 1;
 if (*secOn == -1) { *secOn = 0; }

 delay_ms(300);

 }
 intToStr(*secOn, txt);
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
 *minOff = *minOff + 1;

 delay_ms(300);

 }
 if ( PortC.F1  == 1)
 {
 *minOff = *minOff - 1;
 if (*minOff == -1) { *minOff = 0; }

 delay_ms(300);

 }
 intToStr(*minOff, txt);
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

void setDevice(int *count, int *secOn, int *secOff, char device)
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
 if (*count == (*secOn + *secOff)){ *count = 0; }
}

void main()
{
 int secOn1 = 0, minOff1 = 0, secOn2 = 0, minOff2 = 0, secOn3 = 0, minOff3 = 0;
 int secOff1 = 0, secOff2 = 0, secOff3 = 0;
 int count = 0, count1 = 0, count2 = 0, count3 = 0;
 int sec, min;


 TrisC = 0x0f;


 LCD_Init();
 LCD_CMD(_LCD_Cursor_Off);


 LCD_Out(1, 1, "Welcome");
 delay_ms(700);
 LCD_CMD(_LCD_Clear);


 settingDevicesTime(&secOn1, &minOff1, '1');


 settingDevicesTime(&secOn2, &minOff2, '2');


 settingDevicesTime(&secOn3, &minOff3, '3');


 secOff1 = minOff1 * 60;
 secOff2 = minOff2 * 60;
 secOff3 = minOff3 * 60;


 LCD_Out(2, 1, "1:");
 LCD_Out(2, 7, "2:");
 LCD_Out(2, 13, "3:");


 while(1)
 {

 setDevice(&count1, &secOn1, &secOff1, '1');

 setDevice(&count2, &secOn2, &secOff2, '2');

 setDevice(&count3, &secOn3, &secOff3, '3');


 min = (int)(count / 60);
 sec = count - min * 60;
 intToStr(sec, txt);
 LCD_Out(1, 9, txt);
 intToStr(min, txt);
 LCD_Out(1, 1, txt);
 LCD_Out(1, 1, "Min:");
 LCD_Out(1, 7, ",");
 LCD_Out(1, 9, "sec:");

 delay_ms(1000);
 count++;
 }
}
