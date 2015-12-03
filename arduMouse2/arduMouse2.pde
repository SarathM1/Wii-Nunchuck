import java.awt.AWTException;
import java.awt.Robot;
 
 Robot myRobot;
 
 void setup()
{
  size(200,200);
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
  int i;
  for(i=0;i<=200;i++)
  {
    myRobot.mouseMove(i, i);
    delay(10);
  }
}

 