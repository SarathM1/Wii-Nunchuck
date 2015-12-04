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
int btnPrev = 1;
long lastDebounceTime = 0;
int btn; 

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

  if (btnPrev!=values[3])
    lastDebounceTime = millis();

  if (millis()-lastDebounceTime > 50)
  {
    if (values[3]!=btn)
      btn = values[3];

    if (btn==0)
    {
      //myRobot.mousePress(InputEvent.BUTTON1_MASK);
      //myRobot.mouseRelease(InputEvent.BUTTON1_MASK);
      print(1);
    }
  }

  x = constrain(x, 0, 1355);
  y = constrain(y, 0, 755);
  myRobot.mouseMove(x, y);
  println(btn,values[3]);
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