#ifndef _SERIAL_HELPER_H_
#define _SERIAL_HELPER_H_

#include "Arduino.h"

byte skipUntil(char terminator);
char* readStringUntil(char terminator);
String* readNewStringUntil(char terminator);


#endif _SERIAL_HELPER_H_