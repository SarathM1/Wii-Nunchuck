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
  
  check(joyX,78,176,"left","right","centre");
  
    
  Serial.write(',');
  
  check(joyY,78,176,"down","up","centre");
   
  Serial.write(',');

  check(accelX,100,150,"pitchLeft","pitchRight","centre");
  
  Serial.write(',');
  check(accelY,115,164,"rollUp","rollDown","centre");
  
  //Serial.write(',');
  //Serial.print(accelZ,HEX);
  
  Serial.write("\r\n");
  delay(100);
  
}

void check(int val,int x,int y,char str1[10],char str2[10],char str3[10])
{
  if(val <= x)
    Serial.write(str1);
  else if(val >= y)
    Serial.write(str2);
  else
    Serial.write(str3); 
   
   Serial.write("( ") ;
   Serial.print(val,DEC);
   Serial.write(" )");
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

