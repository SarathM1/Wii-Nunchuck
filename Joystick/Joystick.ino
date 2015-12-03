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
  int joyX  = rawData[0];
  int joyY = rawData[1];
  int accelX = rawData[2];
  int accelY = rawData[3];
  int accelZ = rawData[4] ;
  
  if(joyX <= 78)
    Serial.write("left");
  else if(joyX >= 176)
    Serial.write("Right");
  else
    Serial.write("Centre");
    
  Serial.write(',');

  if(joyY <= 70)
    Serial.write("Down");
  else if(joyY >=  176)
    Serial.write("Up");
  else
    Serial.write("Centre");
  
  Serial.write(',');

  if(joyY <= 70)
    Serial.write("Down");
  else if(joyY >=  176)
    Serial.write("Up");
  else
    Serial.write("Centre");
      
  Serial.write(',');
  Serial.print(accelX,HEX);
  
  Serial.write(',');
  Serial.print(accelY,HEX);
  
  Serial.write("\r\n");
  delay(100);
  
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

