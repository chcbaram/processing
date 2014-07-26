#include <Servo.h>


Servo ServoM[2];
int Angle[2] = { 0, 0 };

typedef struct
{
  int Min;
  int Max;
} SERVO_LIMIT_OBJ;


SERVO_LIMIT_OBJ  Servo_LimitTbl[2] = 
{ { 24, 180 },
  { 24, 180 }
};


int Servo_GetAngle( int Ch, int Degree )
{
  int Angle;
 
  if( Degree < 0 )
  {
    Degree = 0;
  }

  if( Degree > 180 )
  {
    Degree = 180;
  }  
   
  Angle  = Degree * (Servo_LimitTbl[Ch].Max-Servo_LimitTbl[Ch].Min) / 180;
  Angle += Servo_LimitTbl[Ch].Min; 
  
  return Angle;  
}


void setup()
{
   ServoM[0].attach(16);  //PC0 - Servomotor 
   ServoM[1].attach(17);
   
   Serial.begin(9600);
}



void loop()
{
   //ServoM[1].write(Servo_GetAngle(1, 90));
  
  //Serial.println(170);
  //delay(100);
  while (Serial.available() > 0) 
  {
    // look for the next valid integer in the incoming serial stream:
    Angle[0] = Serial.parseInt(); 
    Angle[1] = Serial.parseInt(); 

    if (Serial.read() == '\n') 
    {
      ServoM[0].write( Servo_GetAngle(0, Angle[0]));
      ServoM[1].write( Servo_GetAngle(1, Angle[1]));
    }  
  }
}
