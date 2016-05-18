//Intializing LCD
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

void settingDevicesTime(int *secON, int *minOff, unsigned short deviceNumber)
{
     //setting Second
     LCD_out(1, 1, "device ");
     LCD_Chr(1, 8, deviceNumber);
     LCD_Out(1, 10, "Sec On:");
     while (set == 0)
     {
         if (increment == 1)
         {
             *secOn = *secOn + 1;
             //wait untill button is released
             delay_ms(300);
             //while(increment == 1){}
         }
         if (decrement == 1)
         {
             *secOn = *secOn - 1;
             if (*secOn == -1) { *secOn = 0; }
             //wait untill button is released
             delay_ms(300);
             //while(decrement ==1){}
         }
         intToStr(*secOn, txt);
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
             *minOff = *minOff + 1;
             //wait untill button is released
             delay_ms(300);
             //while(increment == 1){}
         }
         if (decrement == 1)
         {
             *minOff = *minOff - 1;
             if (*minOff == -1) { *minOff = 0; }
             //wait untill button is released
             delay_ms(300);
             //while(decrement ==1){}
         }
         intToStr(*minOff, txt);
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

void setDevice(int *count, int *secOn, int *secOff, char device)
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
    if (*count == (*secOn + *secOff)){ *count = 0; }
}

void main()
{
     int secOn1 = 0, minOff1 = 0, secOn2 = 0, minOff2 = 0, secOn3 = 0, minOff3 = 0;
     int secOff1 = 0, secOff2 = 0, secOff3 = 0;
     int count = 0, count1 = 0, count2 = 0, count3 = 0;
     int sec, min;

     //declaring ports
     TrisC = 0x0f;
     
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
     secOff1 = minOff1 * 60;
     secOff2 = minOff2 * 60;
     secOff3 = minOff3 * 60;
     
     //writing devices output data on lcd
     LCD_Out(2, 1, "1:");
     LCD_Out(2, 7, "2:");
     LCD_Out(2, 13, "3:");

     //starting outputs
     while(1)
     {
         //device1 control
         setDevice(&count1, &secOn1, &secOff1, '1');
         //device2 control
         setDevice(&count2, &secOn2, &secOff2, '2');
         //device3 control
         setDevice(&count3, &secOn3, &secOff3, '3');
         
         //showing time on lcd
         min = (int)(count / 60);
         sec = count - min * 60;
         intToStr(sec, txt);
         LCD_Out(1, 9, txt);
         intToStr(min, txt);
         LCD_Out(1, 1, txt);
         LCD_Out(1, 1, "Min:"); //written every time to overcome empty int conversion space
         LCD_Out(1, 7, ",");
         LCD_Out(1, 9, "sec:"); //written every time to overcome empty int conversion space
         
         delay_ms(1000);
         count++;
     }
}