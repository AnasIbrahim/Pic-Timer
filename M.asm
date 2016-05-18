
_settingDevicesTime:

;M.c,32 :: 		void settingDevicesTime(int *secON, int *minOff, unsigned short deviceNumber)
;M.c,35 :: 		LCD_out(1, 1, "device ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,36 :: 		LCD_Chr(1, 8, deviceNumber);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       FARG_settingDevicesTime_deviceNumber+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;M.c,37 :: 		LCD_Out(1, 10, "Sec On:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,38 :: 		while (set == 0)
L_settingDevicesTime0:
	BTFSC      PORTC+0, 2
	GOTO       L_settingDevicesTime1
;M.c,40 :: 		if (increment == 1)
	BTFSS      PORTC+0, 0
	GOTO       L_settingDevicesTime2
;M.c,42 :: 		*secOn = *secOn + 1;
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	INCF       FSR, 1
	ADDWF      INDF+0, 0
	MOVWF      R0+1
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;M.c,44 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_settingDevicesTime3:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime3
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime3
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime3
	NOP
	NOP
;M.c,46 :: 		}
L_settingDevicesTime2:
;M.c,47 :: 		if (decrement == 1)
	BTFSS      PORTC+0, 1
	GOTO       L_settingDevicesTime4
;M.c,49 :: 		*secOn = *secOn - 1;
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVLW      1
	SUBWF      INDF+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	INCF       FSR, 1
	SUBWF      INDF+0, 0
	MOVWF      R0+1
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;M.c,50 :: 		if (*secOn == -1) { *secOn = 0; }
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      255
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__settingDevicesTime40
	MOVLW      255
	XORWF      R1+0, 0
L__settingDevicesTime40:
	BTFSS      STATUS+0, 2
	GOTO       L_settingDevicesTime5
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
L_settingDevicesTime5:
;M.c,52 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_settingDevicesTime6:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime6
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime6
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime6
	NOP
	NOP
;M.c,54 :: 		}
L_settingDevicesTime4:
;M.c,55 :: 		intToStr(*secOn, txt);
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M.c,56 :: 		LCD_OUT(2, 1, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,57 :: 		}
	GOTO       L_settingDevicesTime0
L_settingDevicesTime1:
;M.c,59 :: 		while(set == 1){}
L_settingDevicesTime7:
	BTFSS      PORTC+0, 2
	GOTO       L_settingDevicesTime8
	GOTO       L_settingDevicesTime7
L_settingDevicesTime8:
;M.c,61 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M.c,62 :: 		LCD_Out(1, 1, "Seconds Set");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,63 :: 		delay_ms(700);
	MOVLW      18
	MOVWF      R11+0
	MOVLW      194
	MOVWF      R12+0
	MOVLW      102
	MOVWF      R13+0
L_settingDevicesTime9:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime9
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime9
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime9
	NOP
;M.c,64 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M.c,67 :: 		LCD_out(1, 1, "device ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,68 :: 		LCD_Chr(1, 8, deviceNumber);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       FARG_settingDevicesTime_deviceNumber+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;M.c,69 :: 		LCD_Out(1, 10, "Min Off:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,70 :: 		while (set == 0)
L_settingDevicesTime10:
	BTFSC      PORTC+0, 2
	GOTO       L_settingDevicesTime11
;M.c,72 :: 		if (increment == 1)
	BTFSS      PORTC+0, 0
	GOTO       L_settingDevicesTime12
;M.c,74 :: 		*minOff = *minOff + 1;
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	INCF       FSR, 1
	ADDWF      INDF+0, 0
	MOVWF      R0+1
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;M.c,76 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_settingDevicesTime13:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime13
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime13
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime13
	NOP
	NOP
;M.c,78 :: 		}
L_settingDevicesTime12:
;M.c,79 :: 		if (decrement == 1)
	BTFSS      PORTC+0, 1
	GOTO       L_settingDevicesTime14
;M.c,81 :: 		*minOff = *minOff - 1;
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVLW      1
	SUBWF      INDF+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	INCF       FSR, 1
	SUBWF      INDF+0, 0
	MOVWF      R0+1
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;M.c,82 :: 		if (*minOff == -1) { *minOff = 0; }
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      255
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__settingDevicesTime41
	MOVLW      255
	XORWF      R1+0, 0
L__settingDevicesTime41:
	BTFSS      STATUS+0, 2
	GOTO       L_settingDevicesTime15
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
L_settingDevicesTime15:
;M.c,84 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_settingDevicesTime16:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime16
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime16
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime16
	NOP
	NOP
;M.c,86 :: 		}
L_settingDevicesTime14:
;M.c,87 :: 		intToStr(*minOff, txt);
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M.c,88 :: 		LCD_OUT(2, 1, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,89 :: 		}
	GOTO       L_settingDevicesTime10
L_settingDevicesTime11:
;M.c,91 :: 		while(set == 1){}
L_settingDevicesTime17:
	BTFSS      PORTC+0, 2
	GOTO       L_settingDevicesTime18
	GOTO       L_settingDevicesTime17
L_settingDevicesTime18:
;M.c,93 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M.c,94 :: 		LCD_Out(1, 1, "Minutes Set");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,95 :: 		delay_ms(700);
	MOVLW      18
	MOVWF      R11+0
	MOVLW      194
	MOVWF      R12+0
	MOVLW      102
	MOVWF      R13+0
L_settingDevicesTime19:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime19
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime19
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime19
	NOP
;M.c,96 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M.c,98 :: 		LCD_Out(1, 1, "Seconds = ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,99 :: 		IntToStr(*secOn, txt);
	MOVF       FARG_settingDevicesTime_secON+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M.c,100 :: 		LCD_Out(1, 11, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,101 :: 		LCD_Out(2, 1, "Minutes = ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,102 :: 		IntToStr(*minOff, txt);
	MOVF       FARG_settingDevicesTime_minOff+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M.c,103 :: 		LCD_Out(2, 11, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,104 :: 		delay_ms(700);
	MOVLW      18
	MOVWF      R11+0
	MOVLW      194
	MOVWF      R12+0
	MOVLW      102
	MOVWF      R13+0
L_settingDevicesTime20:
	DECFSZ     R13+0, 1
	GOTO       L_settingDevicesTime20
	DECFSZ     R12+0, 1
	GOTO       L_settingDevicesTime20
	DECFSZ     R11+0, 1
	GOTO       L_settingDevicesTime20
	NOP
;M.c,105 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M.c,106 :: 		}
L_end_settingDevicesTime:
	RETURN
; end of _settingDevicesTime

_setDevice:

;M.c,108 :: 		void setDevice(int *count, int *secOn, int *secOff, char device)
;M.c,110 :: 		if (*count < *secOn)
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R3+1
	MOVF       FARG_setDevice_secOn+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__setDevice43
	MOVF       R1+0, 0
	SUBWF      R3+0, 0
L__setDevice43:
	BTFSC      STATUS+0, 0
	GOTO       L_setDevice21
;M.c,112 :: 		if      (device == '1') { device1 = on; LCD_OUT(2, 3, "ON "); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice22
	BSF        PORTC+0, 4
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_setDevice23
L_setDevice22:
;M.c,113 :: 		else if (device == '2') { device2 = on; LCD_OUT(2, 9, "ON "); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice24
	BSF        PORTC+0, 5
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_setDevice25
L_setDevice24:
;M.c,114 :: 		else if (device == '3') { device3 = on; LCD_OUT(2, 15, "ON "); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice26
	BSF        PORTC+0, 6
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_setDevice26:
L_setDevice25:
L_setDevice23:
;M.c,115 :: 		}
	GOTO       L_setDevice27
L_setDevice21:
;M.c,116 :: 		else if (*count >= *secOn)
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R3+1
	MOVF       FARG_setDevice_secOn+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__setDevice44
	MOVF       R1+0, 0
	SUBWF      R3+0, 0
L__setDevice44:
	BTFSS      STATUS+0, 0
	GOTO       L_setDevice28
;M.c,118 :: 		if      (device == '1') { device1 = off; LCD_OUT(2, 3, "Off"); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice29
	BCF        PORTC+0, 4
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_setDevice30
L_setDevice29:
;M.c,119 :: 		else if (device == '2') { device2 = off; LCD_OUT(2, 9, "Off"); }
	MOVF       FARG_setDevice_device+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice31
	BCF        PORTC+0, 5
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_setDevice32
L_setDevice31:
;M.c,120 :: 		else if (device == '3') { device3 = off; LCD_OUT(2, 15, "Off");}
	MOVF       FARG_setDevice_device+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice33
	BCF        PORTC+0, 6
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_setDevice33:
L_setDevice32:
L_setDevice30:
;M.c,121 :: 		}
L_setDevice28:
L_setDevice27:
;M.c,122 :: 		*count = *count + 1;
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	INCF       FSR, 1
	ADDWF      INDF+0, 0
	MOVWF      R0+1
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;M.c,123 :: 		if (*count == (*secOn + *secOff)){ *count = 0; }
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R4+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R4+1
	MOVF       FARG_setDevice_secOn+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVF       FARG_setDevice_secOff+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	INCF       FSR, 1
	ADDWF      INDF+0, 0
	MOVWF      R2+1
	MOVF       R4+1, 0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__setDevice45
	MOVF       R2+0, 0
	XORWF      R4+0, 0
L__setDevice45:
	BTFSS      STATUS+0, 2
	GOTO       L_setDevice34
	MOVF       FARG_setDevice_count+0, 0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
L_setDevice34:
;M.c,124 :: 		}
L_end_setDevice:
	RETURN
; end of _setDevice

_main:

;M.c,126 :: 		void main()
;M.c,128 :: 		int secOn1 = 0, minOff1 = 0, secOn2 = 0, minOff2 = 0, secOn3 = 0, minOff3 = 0;
	CLRF       main_secOn1_L0+0
	CLRF       main_secOn1_L0+1
	CLRF       main_minOff1_L0+0
	CLRF       main_minOff1_L0+1
	CLRF       main_secOn2_L0+0
	CLRF       main_secOn2_L0+1
	CLRF       main_minOff2_L0+0
	CLRF       main_minOff2_L0+1
	CLRF       main_secOn3_L0+0
	CLRF       main_secOn3_L0+1
	CLRF       main_minOff3_L0+0
	CLRF       main_minOff3_L0+1
	CLRF       main_secOff1_L0+0
	CLRF       main_secOff1_L0+1
	CLRF       main_secOff2_L0+0
	CLRF       main_secOff2_L0+1
	CLRF       main_secOff3_L0+0
	CLRF       main_secOff3_L0+1
	CLRF       main_count_L0+0
	CLRF       main_count_L0+1
	CLRF       main_count1_L0+0
	CLRF       main_count1_L0+1
	CLRF       main_count2_L0+0
	CLRF       main_count2_L0+1
	CLRF       main_count3_L0+0
	CLRF       main_count3_L0+1
;M.c,134 :: 		TrisC = 0x0f;
	MOVLW      15
	MOVWF      TRISC+0
;M.c,137 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;M.c,138 :: 		LCD_CMD(_LCD_Cursor_Off);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M.c,141 :: 		LCD_Out(1, 1, "Welcome");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr15_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,142 :: 		delay_ms(700);
	MOVLW      18
	MOVWF      R11+0
	MOVLW      194
	MOVWF      R12+0
	MOVLW      102
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
;M.c,143 :: 		LCD_CMD(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;M.c,146 :: 		settingDevicesTime(&secOn1, &minOff1, '1');
	MOVLW      main_secOn1_L0+0
	MOVWF      FARG_settingDevicesTime_secON+0
	MOVLW      main_minOff1_L0+0
	MOVWF      FARG_settingDevicesTime_minOff+0
	MOVLW      49
	MOVWF      FARG_settingDevicesTime_deviceNumber+0
	CALL       _settingDevicesTime+0
;M.c,149 :: 		settingDevicesTime(&secOn2, &minOff2, '2');
	MOVLW      main_secOn2_L0+0
	MOVWF      FARG_settingDevicesTime_secON+0
	MOVLW      main_minOff2_L0+0
	MOVWF      FARG_settingDevicesTime_minOff+0
	MOVLW      50
	MOVWF      FARG_settingDevicesTime_deviceNumber+0
	CALL       _settingDevicesTime+0
;M.c,152 :: 		settingDevicesTime(&secOn3, &minOff3, '3');
	MOVLW      main_secOn3_L0+0
	MOVWF      FARG_settingDevicesTime_secON+0
	MOVLW      main_minOff3_L0+0
	MOVWF      FARG_settingDevicesTime_minOff+0
	MOVLW      51
	MOVWF      FARG_settingDevicesTime_deviceNumber+0
	CALL       _settingDevicesTime+0
;M.c,155 :: 		secOff1 = minOff1 * 60;
	MOVF       main_minOff1_L0+0, 0
	MOVWF      R0+0
	MOVF       main_minOff1_L0+1, 0
	MOVWF      R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      main_secOff1_L0+0
	MOVF       R0+1, 0
	MOVWF      main_secOff1_L0+1
;M.c,156 :: 		secOff2 = minOff2 * 60;
	MOVF       main_minOff2_L0+0, 0
	MOVWF      R0+0
	MOVF       main_minOff2_L0+1, 0
	MOVWF      R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      main_secOff2_L0+0
	MOVF       R0+1, 0
	MOVWF      main_secOff2_L0+1
;M.c,157 :: 		secOff3 = minOff3 * 60;
	MOVF       main_minOff3_L0+0, 0
	MOVWF      R0+0
	MOVF       main_minOff3_L0+1, 0
	MOVWF      R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      main_secOff3_L0+0
	MOVF       R0+1, 0
	MOVWF      main_secOff3_L0+1
;M.c,160 :: 		LCD_Out(2, 1, "1:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr16_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,161 :: 		LCD_Out(2, 7, "2:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr17_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,162 :: 		LCD_Out(2, 13, "3:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr18_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,165 :: 		while(1)
L_main36:
;M.c,168 :: 		setDevice(&count1, &secOn1, &secOff1, '1');
	MOVLW      main_count1_L0+0
	MOVWF      FARG_setDevice_count+0
	MOVLW      main_secOn1_L0+0
	MOVWF      FARG_setDevice_secOn+0
	MOVLW      main_secOff1_L0+0
	MOVWF      FARG_setDevice_secOff+0
	MOVLW      49
	MOVWF      FARG_setDevice_device+0
	CALL       _setDevice+0
;M.c,170 :: 		setDevice(&count2, &secOn2, &secOff2, '2');
	MOVLW      main_count2_L0+0
	MOVWF      FARG_setDevice_count+0
	MOVLW      main_secOn2_L0+0
	MOVWF      FARG_setDevice_secOn+0
	MOVLW      main_secOff2_L0+0
	MOVWF      FARG_setDevice_secOff+0
	MOVLW      50
	MOVWF      FARG_setDevice_device+0
	CALL       _setDevice+0
;M.c,172 :: 		setDevice(&count3, &secOn3, &secOff3, '3');
	MOVLW      main_count3_L0+0
	MOVWF      FARG_setDevice_count+0
	MOVLW      main_secOn3_L0+0
	MOVWF      FARG_setDevice_secOn+0
	MOVLW      main_secOff3_L0+0
	MOVWF      FARG_setDevice_secOff+0
	MOVLW      51
	MOVWF      FARG_setDevice_device+0
	CALL       _setDevice+0
;M.c,175 :: 		min = (int)(count / 60);
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
	MOVF       R0+1, 0
	MOVWF      main_min_L0+1
;M.c,176 :: 		sec = count - min * 60;
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	SUBWF      main_count_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      main_count_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
;M.c,177 :: 		intToStr(sec, txt);
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M.c,178 :: 		LCD_Out(1, 9, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,179 :: 		intToStr(min, txt);
	MOVF       main_min_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_min_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;M.c,180 :: 		LCD_Out(1, 1, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,181 :: 		LCD_Out(1, 1, "Min:"); //written every time to overcome empty int conversion space
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr19_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,182 :: 		LCD_Out(1, 7, ",");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr20_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,183 :: 		LCD_Out(1, 9, "sec:"); //written every time to overcome empty int conversion space
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr21_M+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;M.c,185 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main38:
	DECFSZ     R13+0, 1
	GOTO       L_main38
	DECFSZ     R12+0, 1
	GOTO       L_main38
	DECFSZ     R11+0, 1
	GOTO       L_main38
	NOP
;M.c,186 :: 		count++;
	INCF       main_count_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_count_L0+1, 1
;M.c,187 :: 		}
	GOTO       L_main36
;M.c,188 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
