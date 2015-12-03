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
    myRobot.mouseMove(1350, 750);
}


 