import processing.serial.*;
import java.awt.AWTException;
import java.awt.Robot;

Robot myRobot;
Serial myPort;  
String val;  
int linefeed = 10; // 10 - ASCII for linefeed
int values[];
int  x=0,y=0;

void setup()
{
  
  myPort = new Serial(this,"/dev/ttyACM0",9600);
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
  if(values[1]<=80)
    myRobot.mouseMove(x++, y);
  else if(values[1]>=180)
    myRobot.mouseMove(x--, y);
  
  if(values[2]<=80)
    myRobot.mouseMove(x, y++);
  else if(values[2]>=180)
    myRobot.mouseMove(x, y--);
    
  println(x,y);
  
}

void serialEvent(Serial myPort) {

  // read the serial buffer:
  String myString = myPort.readStringUntil(linefeed);

  // if you got any bytes other than the linefeed:
  if (myString != null) {

    myString = trim(myString);

    // split the string at the commas
    // and convert the sections into integers:

   
    values = int(split(myString, ','));

    // print out the values you got:
    
    /*for (int i = 1; i <=2; i++) {
      print("Values " + i + ": " + values[i] + "\t");
    }*/
    //println();// add a linefeed after all the sensor values are printed:
    
    
  }
}