#include<Wire.h>

static byte rawData[6];

void setup()
{
  Serial.begin(9600);
  i2c_init();
}

void loop()
{
  i2c_read();
  i2c_read_init();
  int data  = (int)rawData[0];
  Serial.print(data,HEX);
  Serial.write("\r\n");
  delay(20);
  
}

void i2c_read()
{
  int i = 0;
  Wire.requestFrom(0x52,6);
  while(Wire.available())
  {
    rawData[i++] = wii_decode(Wire.read());    
  }
  i2c_read_init();
}

void i2c_init()
{
  Wire.begin();
  Wire.beginTransmission(0x52);
  Wire.write((byte)0x40);
  Wire.write((byte)0x00);
  Wire.endTransmission();
}

void i2c_read_init()
{
  Wire.beginTransmission(0x52);
  Wire.write((byte)0x00);
  Wire.endTransmission();
}

static char wii_decode(byte data)
{
  return ((data^0x17)+0x17);
}

