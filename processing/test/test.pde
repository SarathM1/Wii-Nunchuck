import processing.serial.*;

Serial myPort;
public static final short portIndex = 1;

void setup()
{
  size(200,200);
  myPort = new Serial(this,"/dev/ttyACM0",9600);
}

void loop()
{
  if(myPort.available()>0)
  {
    int y = myPort.read();
    background(255);
    line(0,63-y,127,y);
  }
}