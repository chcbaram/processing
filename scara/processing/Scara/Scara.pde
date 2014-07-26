import processing.serial.*;

int sx,sy,ex,ey,hx,hy,hxo,hyo;
int armLength,ua,la;
float uad, lad;


Serial myPort;  // Create object from Serial class


void setup()
{
  size(500,500);
  background(255, 224, 150);
  sx = width/2;
  sy = height/2;
  armLength = int(width/5);
  
  myPort = new Serial(this, "/dev/tty.SLAB_USBtoUART", 9600);
  myPort.clear();
  
}
 
void draw()
{
  fill(255);
  rect(0,0,width,height);
  upperArm();
}
 
void upperArm(){
  int dx = mouseX - sx;
  int dy = mouseY - sy;
  float distance = sqrt(dx*dx+dy*dy);
   
  int a = armLength;
  int b = armLength;
  float c = min(distance, a + b);
   
  float B = acos((b*b-a*a-c*c)/(-2*a*c));
  float C = acos((c*c-a*a-b*b)/(-2*a*b));
   
  float D = atan2(dy,dx);
  float E = D + B + PI + C;

  float UpperAngle;
  float LowerAngle;
   
  ex = int((cos(E) * a)) + sx;
  ey = int((sin(E) * a)) + sy;
  //print("UpperArm Angle=  "+degrees(E)+"    ");
  
  UpperAngle = degrees(E) - 180;
  
  print("UpperArm Angle=  "+ UpperAngle+"    "); 
   
  hx = int((cos(D+B) * b)) + ex;
  hy = int((sin(D+B) * b)) + ey;
  //println("LowerArm Angle=  "+degrees((D+B)));
  
  LowerAngle = (-degrees(D+B)) + UpperAngle;

  print("D "+(int)degrees(D)+" B "+(int)degrees(B) + " "); 
  
  //print("K "+(int)(UpperAngle+LowerAngle) + " "); 

  
  println("LowerArm Angle=  "+LowerAngle);
      
  stroke(255,0,0,100);
  fill(240,0,0,200);
  ellipse(sx,sy,10,10);
  ellipse(ex,ey,8,8);
  ellipse(hx,hy,6,6);
  stroke(0);
  line(sx,sy,ex,ey);
  line(ex,ey,hx,hy);
  //float angle = atan2(dy, dx);
  //println("angle = " + degrees(angle))
  //ex = int((cos(angle) * r)) + sx;
  //ey = int((sin(angle) * r)) + sy;
  //line(sx,sy,ex,ey);
  
  myPort.write(str((int)UpperAngle) + " " + (int)LowerAngle +  "\n");

}

