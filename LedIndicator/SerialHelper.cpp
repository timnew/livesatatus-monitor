#include "SerialHelper.h"

#define BUFFER_SIZE 256
char buffer[BUFFER_SIZE];
int size = 0;

byte skipUntil(char terminator) {
	size = Serial.readBytesUntil(terminator, buffer, BUFFER_SIZE);

	return size;
}

char* readStringUntil(char terminator) {
	skipUntil(terminator);
	buffer[size] = 0;
	return buffer;
}

String* readNewStringUntil(char terminator) {
	readStringUntil(terminator);
	return new String(buffer);
}


