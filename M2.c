//Intializing LCD
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

//defining ON & OFF
#define on 1
#define off 0

//defining output ports names
#define device1 PortC.F4
#define device2 PortC.F5
#define device3 PortC.F6

//defining input ports names
#define increment PortC.F0
#define decrement PortC.F1
#define set PortC.F2

char txt[7];

void settingDevicesTime(unsigned short *secON, unsigned short *minOff, unsigned short deviceNumber)
{
     //setting Second
     LCD_out(1, 1, "device ");
     LCD_Chr(1, 8, deviceNumber);
     LCD_Out(1, 10, "Sec On:");
     while (set == 0)
     {
         if (increment == 1)
         {
             delay_ms(30);
             if (increment == 1)
             {
                 *secOn = *secOn + 1;
                 //wait untill button is released
                 delay_ms(300);
                 //while(increment == 1){}
             }
         }
         if (decrement == 1)
         {
             delay_ms(30);
             if (decrement == 1)
             {
                 *secOn = *secOn - 1;
                 if (*secOn == 255) { *secOn = 0; }
                 //wait untill button is released
                 delay_ms(300);
                 //while(decrement ==1){}
             }
         }
         byteToStr(*secOn, txt);
         LCD_OUT(2, 1, txt);
     }
     //waiting untill set button is released
     while(set == 1){}

     LCD_CMD(_LCD_Clear);
     LCD_Out(1, 1, "Seconds Set");
     delay_ms(700);
     LCD_CMD(_LCD_Clear);

     //setting Minutes
     LCD_out(1, 1, "device ");
     LCD_Chr(1, 8, deviceNumber);
     LCD_Out(1, 10, "Min Off:");
     while (set == 0)
     {
         if (increment == 1)
         {
             delay_ms(30);
             if (increment == 1)
             {
                 *minOff = *minOff + 1;
                 //wait untill button is released
                 delay_ms(300);
                 //while(increment == 1){}
             }
         }
         if (decrement == 1)
         {
             delay_ms(30);
             if (decrement == 1)
             {
                 *minOff = *minOff - 1;
                 if (*minOff == 255) { *minOff = 0; }
                 //wait untill button is released
                 delay_ms(300);
                 //while(decrement ==1){}
             }
         }
         byteToStr(*minOff, txt);
         LCD_OUT(2, 1, txt);
     }
     //waiting untill set button is released
     while(set == 1){}

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
        if      (device == '1') { device1 = on; LCD_OUT(2, 3, "ON "); }
        else if (device == '2') { device2 = on; LCD_OUT(2, 9, "ON "); }
        else if (device == '3') { device3 = on; LCD_OUT(2, 15, "ON "); }
    }
    else if (*count >= *secOn)
    {
        if      (device == '1') { device1 = off; LCD_OUT(2, 3, "Off"); }
        else if (device == '2') { device2 = off; LCD_OUT(2, 9, "Off"); }
        else if (device == '3') { device3 = off; LCD_OUT(2, 15, "Off");}
    }
    *count = *count + 1;
    if (*count == totalTime){ *count = 0;}
}

void main()
{
     unsigned short secOn1 = 3, minOff1 = 1, secOn2 = 6, minOff2 = 1, secOn3 = 9, minOff3 = 1;
     int totalTime1 = 0, totalTime2 = 0, totalTime3 = 0;
     unsigned short count1 = 0, count2 = 0, count3 = 0;
     int  count = 0;
     unsigned short sec, min;

     //declaring ports
     TrisB = 0x00;
     TrisC = 0x0F;

     //Intializing LCD and Keypad
     LCD_Init();
     LCD_CMD(_LCD_Cursor_Off);

     //welcome sign - starting program
     LCD_Out(1, 1, "Welcome");
     delay_ms(700);
     LCD_CMD(_LCD_Clear);

     //setting device 1 time
     settingDevicesTime(&secOn1, &minOff1, '1');

     //setting device 2 time
     settingDevicesTime(&secOn2, &minOff2, '2');

     //setting device 3 time
     settingDevicesTime(&secOn3, &minOff3, '3');

     //setting min to sec
     totalTime1 = (int)minOff1 * 60 + (int)secOn1;
     totalTime2 = (int)minOff2 * 60 + (int)secOn2;
     totalTime3 = (int)minOff3 * 60 + (int)secOn3;

     //writing devices output data on lcd
     LCD_Out(2, 1, "1:");
     LCD_Out(2, 7, "2:");
     LCD_Out(2, 13, "3:");

     //starting outputs
     while(1)
     {
         //device1 control
         setDevice(&count1, &secOn1, totalTime1, '1');
         //device2 control
         setDevice(&count2, &secOn2, totalTime2, '2');
         //device3 control
         setDevice(&count3, &secOn3, totalTime3, '3');

         //showing time on lcd
         min = (unsigned short)(count / 60);
         sec = (unsigned short)(count - min * 60);
         byteToStr(sec, txt);
         LCD_Out(1, 12, txt);
         intToStr(min, txt);
         LCD_Out(1, 1, txt);
         LCD_Out(1, 1, "Min:"); //written every time to overcome empty int conversion space
         LCD_Out(1, 7, ",");
         LCD_Out(1, 9, "sec:"); //written every time to overcome empty int conversion space

         delay_ms(1000);
         count++;
     }
}