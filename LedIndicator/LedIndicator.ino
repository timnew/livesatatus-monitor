#include "Arduino.h"
#include "RGBLed.h"
#include "SerialHelper.h"

//#define RGBLED
#define RGBLED

#define RedPin 11
#define GreenPin 10
#define BluePin 9

#if defined RGBLED
RGBLed led(RedPin, GreenPin, BluePin);
#elif defined RBGLED
RGBLed led(RedPin, BluePin, GreenPin);
#endif

void setup() {
  led.setColor(0, 0, 0);
  led.blink(0xFFFFFFL, 2);
  
  Serial.begin(9600);

  Serial.println("LED:Ready");
}

void loop() { 

  if(Serial.available()) {
	skipUntil('+'); // ignore LED+

	String command = String(readStringUntil('='));

	if(command == "RGB") {
		byte r = (byte)Serial.parseInt();
		Serial.read();
		byte g = (byte)Serial.parseInt();
		Serial.read();
		byte b = (byte)Serial.parseInt();
		Serial.read();

		led.setColor(r,g,b);
		Serial.print("LED:RGB=");
		Serial.print(r,DEC);
		Serial.print(",");
		Serial.print(g,DEC);
		Serial.print(",");
		Serial.print(b,DEC);
		Serial.println();
	}
  }
}

