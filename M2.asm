
_settingDevicesTime:

;M2.c,32 :: 		void settingDevicesTime(unsigned short *secON, unsigned short *minOff, unsigned short deviceNumber)
;M2.c,35 :: 		LCD_out(1, 1, "device ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,36 :: 		LCD_Chr(1, 8, deviceNumber);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       FARG_settingDevicesTime_deviceNumber+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;M2.c,37 :: 		LCD_Out(1, 10, "Sec On:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,38 :: 		while (set == 0)
L_settingDevicesTime0:
	BTFSC      PORTC+0, 2
	GOTO       L_settingDevicesTime1
;M2.c,40 :: 		if (increment == 1)
	BTFSS      PORTC+0, 0
	GOTO       L_settingDevicesTime2
;M2.c,42 :: 		delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_settingDevicesTime3:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime3
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime3
;M2.c,43 :: 		if (increment == 1)
	BTFSS      PORTC+0, 0
	GOTO       L_settingDevicesTime4
;M2.c,45 :: 		*secOn = *secOn + 1;
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;M2.c,47 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_settingDevicesTime5:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime5
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime5
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime5
	NOP
	NOP
;M2.c,49 :: 		}
L_settingDevicesTime4:
;M2.c,50 :: 		}
L_settingDevicesTime2:
;M2.c,51 :: 		if (decrement == 1)
	BTFSS      PORTC+0, 1
	GOTO       L_settingDevicesTime6
;M2.c,53 :: 		delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_settingDevicesTime7:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime7
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime7
;M2.c,54 :: 		if (decrement == 1)
	BTFSS      PORTC+0, 1
	GOTO       L_settingDevicesTime8
;M2.c,56 :: 		*secOn = *secOn - 1;
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	DECF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;M2.c,57 :: 		if (*secOn == 255) { *secOn = 0; }
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_settingDevicesTime9
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	CLRF       INDF+0
L_settingDevicesTime9:
;M2.c,59 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_settingDevicesTime10:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime10
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime10
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime10
	NOP
	NOP
;M2.c,61 :: 		}
L_settingDevicesTime8:
;M2.c,62 :: 		}
L_settingDevicesTime6:
;M2.c,63 :: 		byteToStr(*secOn, txt);
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;M2.c,64 :: 		LCD_OUT(2, 1, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,65 :: 		}
	GOTO       L_settingDevicesTime0
L_settingDevicesTime1:
;M2.c,67 :: 		while(set == 1){}
L_settingDevicesTime11:
	BTFSS      PORTC+0, 2
	GOTO       L_settingDevicesTime12
	GOTO       L_settingDevicesTime11
L_settingDevicesTime12:
;M2.c,69 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M2.c,70 :: 		LCD_Out(1, 1, "Seconds Set");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,71 :: 		delay_ms(700);
	MOVLW      18
	MOVWF      R11+0
	MOVLW      194
	MOVWF      R12+0
	MOVLW      102
	MOVWF      R13+0
L_settingDevicesTime13:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime13
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime13
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime13
	NOP
;M2.c,72 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M2.c,75 :: 		LCD_out(1, 1, "device ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,76 :: 		LCD_Chr(1, 8, deviceNumber);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       FARG_settingDevicesTime_deviceNumber+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;M2.c,77 :: 		LCD_Out(1, 10, "Min Off:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,78 :: 		while (set == 0)
L_settingDevicesTime14:
	BTFSC      PORTC+0, 2
	GOTO       L_settingDevicesTime15
;M2.c,80 :: 		if (increment == 1)
	BTFSS      PORTC+0, 0
	GOTO       L_settingDevicesTime16
;M2.c,82 :: 		delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_settingDevicesTime17:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime17
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime17
;M2.c,83 :: 		if (increment == 1)
	BTFSS      PORTC+0, 0
	GOTO       L_settingDevicesTime18
;M2.c,85 :: 		*minOff = *minOff + 1;
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;M2.c,87 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_settingDevicesTime19:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime19
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime19
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime19
	NOP
	NOP
;M2.c,89 :: 		}
L_settingDevicesTime18:
;M2.c,90 :: 		}
L_settingDevicesTime16:
;M2.c,91 :: 		if (decrement == 1)
	BTFSS      PORTC+0, 1
	GOTO       L_settingDevicesTime20
;M2.c,93 :: 		delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_settingDevicesTime21:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime21
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime21
;M2.c,94 :: 		if (decrement == 1)
	BTFSS      PORTC+0, 1
	GOTO       L_settingDevicesTime22
;M2.c,96 :: 		*minOff = *minOff - 1;
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	DECF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;M2.c,97 :: 		if (*minOff == 255) { *minOff = 0; }
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_settingDevicesTime23
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	CLRF       INDF+0
L_settingDevicesTime23:
;M2.c,99 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_settingDevicesTime24:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime24
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime24
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime24
	NOP
	NOP
;M2.c,101 :: 		}
L_settingDevicesTime22:
;M2.c,102 :: 		}
L_settingDevicesTime20:
;M2.c,103 :: 		byteToStr(*minOff, txt);
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _txt+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;M2.c,104 :: 		LCD_OUT(2, 1, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,105 :: 		}
	GOTO       L_settingDevicesTime14
L_settingDevicesTime15:
;M2.c,107 :: 		while(set == 1){}
L_settingDevicesTime25:
	BTFSS      PORTC+0, 2
	GOTO       L_settingDevicesTime26
	GOTO       L_settingDevicesTime25
L_settingDevicesTime26:
;M2.c,109 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M2.c,110 :: 		LCD_Out(1, 1, "Minutes Set");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,111 :: 		delay_ms(700);
	MOVLW      18
	MOVWF      R11+0
	MOVLW      194
	MOVWF      R12+0
	MOVLW      102
	MOVWF      R13+0
L_settingDevicesTime27:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime27
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime27
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime27
	NOP
;M2.c,112 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M2.c,114 :: 		LCD_Out(1, 1, "Seconds = ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,115 :: 		IntToStr(*secOn, txt);
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M2.c,116 :: 		LCD_Out(1, 11, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,117 :: 		LCD_Out(2, 1, "Minutes = ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,118 :: 		IntToStr(*minOff, txt);
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M2.c,119 :: 		LCD_Out(2, 11, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,120 :: 		delay_ms(700);
	MOVLW      18
	MOVWF      R11+0
	MOVLW      194
	MOVWF      R12+0
	MOVLW      102
	MOVWF      R13+0
L_settingDevicesTime28:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime28
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime28
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime28
	NOP
;M2.c,121 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M2.c,122 :: 		}
L_end_settingDevicesTime:
	RETURN
; end of _settingDevicesTime

_setDevice:

;M2.c,124 :: 		void setDevice(unsigned short *count, unsigned short *secOn, int totalTime, char device)
;M2.c,126 :: 		if (*count < *secOn)
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       FARG_setDevice_secOn+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setDevice29
;M2.c,128 :: 		if      (device == '1') { device1 = on; LCD_OUT(2, 3, "ON "); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice30
	BSF        PORTC+0, 4
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_setDevice31
L_setDevice30:
;M2.c,129 :: 		else if (device == '2') { device2 = on; LCD_OUT(2, 9, "ON "); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice32
	BSF        PORTC+0, 5
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_setDevice33
L_setDevice32:
;M2.c,130 :: 		else if (device == '3') { device3 = on; LCD_OUT(2, 15, "ON "); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice34
	BSF        PORTC+0, 6
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_setDevice34:
L_setDevice33:
L_setDevice31:
;M2.c,131 :: 		}
	GOTO       L_setDevice35
L_setDevice29:
;M2.c,132 :: 		else if (*count >= *secOn)
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       FARG_setDevice_secOn+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_setDevice36
;M2.c,134 :: 		if      (device == '1') { device1 = off; LCD_OUT(2, 3, "Off"); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice37
	BCF        PORTC+0, 4
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_setDevice38
L_setDevice37:
;M2.c,135 :: 		else if (device == '2') { device2 = off; LCD_OUT(2, 9, "Off"); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice39
	BCF        PORTC+0, 5
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_setDevice40
L_setDevice39:
;M2.c,136 :: 		else if (device == '3') { device3 = off; LCD_OUT(2, 15, "Off");}
	MOVF       FARG_setDevice_device+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice41
	BCF        PORTC+0, 6
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_setDevice41:
L_setDevice40:
L_setDevice38:
;M2.c,137 :: 		}
L_setDevice36:
L_setDevice35:
;M2.c,138 :: 		*count = *count + 1;
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;M2.c,139 :: 		if (*count == totalTime){ *count = 0;}
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVLW      0
	XORWF      FARG_setDevice_totalTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__setDevice49
	MOVF       FARG_setDevice_totalTime+0, 0
	XORWF      R1+0, 0
L__setDevice49:
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice42
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	CLRF       INDF+0
L_setDevice42:
;M2.c,140 :: 		}
L_end_setDevice:
	RETURN
; end of _setDevice

_main:

;M2.c,142 :: 		void main()
;M2.c,144 :: 		unsigned short secOn1 = 3, minOff1 = 1, secOn2 = 6, minOff2 = 1, secOn3 = 9, minOff3 = 1;
	MOVLW      3
	MOVWF      main_secOn1_L0+0
	MOVLW      1
	MOVWF      main_minOff1_L0+0
	MOVLW      6
	MOVWF      main_secOn2_L0+0
	MOVLW      1
	MOVWF      main_minOff2_L0+0
	MOVLW      9
	MOVWF      main_secOn3_L0+0
	MOVLW      1
	MOVWF      main_minOff3_L0+0
	CLRF       main_totalTime1_L0+0
	CLRF       main_totalTime1_L0+1
	CLRF       main_totalTime2_L0+0
	CLRF       main_totalTime2_L0+1
	CLRF       main_totalTime3_L0+0
	CLRF       main_totalTime3_L0+1
	CLRF       main_count1_L0+0
	CLRF       main_count2_L0+0
	CLRF       main_count3_L0+0
	CLRF       main_count_L0+0
	CLRF       main_count_L0+1
;M2.c,151 :: 		TrisB = 0x00;
	CLRF       TRISB+0
;M2.c,152 :: 		TrisC = 0x0F;
	MOVLW      15
	MOVWF      TRISC+0
;M2.c,155 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;M2.c,156 :: 		LCD_CMD(_LCD_Cursor_Off);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M2.c,159 :: 		LCD_Out(1, 1, "Welcome");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr15_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,160 :: 		delay_ms(700);
	MOVLW      18
	MOVWF      R11+0
	MOVLW      194
	MOVWF      R12+0
	MOVLW      102
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	DECFSZ     R11+0, 1
	GOTO       L_main43
	NOP
;M2.c,161 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M2.c,164 :: 		settingDevicesTime(&secOn1, &minOff1, '1');
	MOVLW      main_secOn1_L0+0
	MOVWF      FARG_settingDevicesTime_secON+0
	MOVLW      main_minOff1_L0+0
	MOVWF      FARG_settingDevicesTime_minOff+0
	MOVLW      49
	MOVWF      FARG_settingDevicesTime_deviceNumber+0
	CALL       _settingDevicesTime+0
;M2.c,167 :: 		settingDevicesTime(&secOn2, &minOff2, '2');
	MOVLW      main_secOn2_L0+0
	MOVWF      FARG_settingDevicesTime_secON+0
	MOVLW      main_minOff2_L0+0
	MOVWF      FARG_settingDevicesTime_minOff+0
	MOVLW      50
	MOVWF      FARG_settingDevicesTime_deviceNumber+0
	CALL       _settingDevicesTime+0
;M2.c,170 :: 		settingDevicesTime(&secOn3, &minOff3, '3');
	MOVLW      main_secOn3_L0+0
	MOVWF      FARG_settingDevicesTime_secON+0
	MOVLW      main_minOff3_L0+0
	MOVWF      FARG_settingDevicesTime_minOff+0
	MOVLW      51
	MOVWF      FARG_settingDevicesTime_deviceNumber+0
	CALL       _settingDevicesTime+0
;M2.c,173 :: 		totalTime1 = (int)minOff1 * 60 + (int)secOn1;
	MOVF       main_minOff1_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       main_secOn1_L0+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      main_totalTime1_L0+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      main_totalTime1_L0+1
;M2.c,174 :: 		totalTime2 = (int)minOff2 * 60 + (int)secOn2;
	MOVF       main_minOff2_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       main_secOn2_L0+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      main_totalTime2_L0+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      main_totalTime2_L0+1
;M2.c,175 :: 		totalTime3 = (int)minOff3 * 60 + (int)secOn3;
	MOVF       main_minOff3_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       main_secOn3_L0+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      main_totalTime3_L0+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      main_totalTime3_L0+1
;M2.c,178 :: 		LCD_Out(2, 1, "1:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr16_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,179 :: 		LCD_Out(2, 7, "2:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr17_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,180 :: 		LCD_Out(2, 13, "3:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr18_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,183 :: 		while(1)
L_main44:
;M2.c,186 :: 		setDevice(&count1, &secOn1, totalTime1, '1');
	MOVLW      main_count1_L0+0
	MOVWF      FARG_setDevice_count+0
	MOVLW      main_secOn1_L0+0
	MOVWF      FARG_setDevice_secOn+0
	MOVF       main_totalTime1_L0+0, 0
	MOVWF      FARG_setDevice_totalTime+0
	MOVF       main_totalTime1_L0+1, 0
	MOVWF      FARG_setDevice_totalTime+1
	MOVLW      49
	MOVWF      FARG_setDevice_device+0
	CALL       _setDevice+0
;M2.c,188 :: 		setDevice(&count2, &secOn2, totalTime2, '2');
	MOVLW      main_count2_L0+0
	MOVWF      FARG_setDevice_count+0
	MOVLW      main_secOn2_L0+0
	MOVWF      FARG_setDevice_secOn+0
	MOVF       main_totalTime2_L0+0, 0
	MOVWF      FARG_setDevice_totalTime+0
	MOVF       main_totalTime2_L0+1, 0
	MOVWF      FARG_setDevice_totalTime+1
	MOVLW      50
	MOVWF      FARG_setDevice_device+0
	CALL       _setDevice+0
;M2.c,190 :: 		setDevice(&count3, &secOn3, totalTime3, '3');
	MOVLW      main_count3_L0+0
	MOVWF      FARG_setDevice_count+0
	MOVLW      main_secOn3_L0+0
	MOVWF      FARG_setDevice_secOn+0
	MOVF       main_totalTime3_L0+0, 0
	MOVWF      FARG_setDevice_totalTime+0
	MOVF       main_totalTime3_L0+1, 0
	MOVWF      FARG_setDevice_totalTime+1
	MOVLW      51
	MOVWF      FARG_setDevice_device+0
	CALL       _setDevice+0
;M2.c,193 :: 		min = (unsigned short)(count / 60);
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_count_L0+0, 0
	MOVWF      R0+0
	MOVF       main_count_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_min_L0+0
;M2.c,194 :: 		sec = (unsigned short)(count - min * 60);
	MOVLW      60
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	SUBWF      main_count_L0+0, 0
	MOVWF      FARG_ByteToStr_input+0
;M2.c,195 :: 		byteToStr(sec, txt);
	MOVLW      _txt+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;M2.c,196 :: 		LCD_Out(1, 12, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,197 :: 		intToStr(min, txt);
	MOVF       main_min_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M2.c,198 :: 		LCD_Out(1, 1, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,199 :: 		LCD_Out(1, 1, "Min:"); //written every time to overcome empty int conversion space
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr19_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,200 :: 		LCD_Out(1, 7, ",");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr20_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,201 :: 		LCD_Out(1, 9, "sec:"); //written every time to overcome empty int conversion space
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr21_M2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M2.c,203 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	DECFSZ     R11+0, 1
	GOTO       L_main46
	NOP
;M2.c,204 :: 		count++;
	INCF       main_count_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_count_L0+1, 1
;M2.c,205 :: 		}
	GOTO       L_main44
;M2.c,206 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
