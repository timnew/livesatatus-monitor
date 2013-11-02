#include "Arduino.h"
#include "SerialHelper.h"
#include "IRremote.h"

#define VERSION "IR,1"

IRsend irsend;

// Send Pin: Mega 9, Other 3

unsigned long codeValue;
int codeLen;

void setup() {
  codeLen = 0;
  codeValue = 0;
  
  Serial.begin(9600);

  Serial.println("LED:Ready");
}

void loop() { 
  	if(Serial.available()) {
		String command = String(readStringUntil('?', '='));

	 	if(command == "IR+NEC=") {		 
		  Serial.readBytes((char*)&codeValue, 4);
		  Serial.readBytes((char*)&codeLen, 2);
		  skipUntil('\n');
		  Serial.print("IR+NEC:");
		  Serial.println(codeValue,HEX);
		  irsend.sendNEC(codeValue, 32);		  
		} else if(command == "BOARD+VERSION?") {
			skipUntil('\n');
			Serial.print("BOARD+VERSION:");
			Serial.println(VERSION);
		} else {
			skipUntil('\n');
            Serial.print("BOARD:Unknown Command:");
            Serial.println(command);
	    }
  	}

  // 	if(codeLen > 0) {
		// irsend.sendNEC(codeValue, codeLen);
		// delay(100);
  // 	}
}

