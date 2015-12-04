import processing.serial.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;

Robot myRobot;
Serial myPort;  
String val;  
int linefeed = 10; // 10 - ASCII for linefeed
int values[];
int  x=0, y=0;
int offset = 3;

void setup()
{

  myPort = new Serial(this, "/dev/ttyACM0", 9600);
  delay(500);
  try
  {
    myRobot = new Robot();
  }
  catch(AWTException e)
  {
    e.printStackTrace();
  }
}

void draw()
{
  if (values[1]<=80)
    x-=offset;

  else if (values[1]>=180)
    x+=offset;

  if (values[2]<=80)
    y+=offset;

  else if (values[2]>=180)
    y-=offset;

  if (values[3]==0)
  {
    myRobot.mousePress(InputEvent.BUTTON1_MASK);
    myRobot.mouseRelease(InputEvent.BUTTON1_MASK);
  }
  
  x = constrain(x, 0, 1355);
  y = constrain(y, 0, 755);
  myRobot.mouseMove(x, y);
  println(x, y, values[3]);
}

void serialEvent(Serial myPort) 
{
  String myString = myPort.readStringUntil(linefeed);   // if you got any bytes other than the linefeed:

  if (myString != null) 
  {  
    myString = trim(myString);
    values = int(split(myString, ','));
  }
}