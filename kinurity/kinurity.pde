
/* --------------------------------------------------------------------------
 * SimpleOpenNI DepthImage Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */
import de.bezier.data.sql.*;
MySQL msql;
import SimpleOpenNI.*;
import processing.net.*; 
Client myClient; 
int dataIn; 
int yn = 0;
PImage pic;
PImage ir;
boolean request = false;
int photoNum = 0;
 
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
 


SimpleOpenNI  context;

void setup()
{
   String user     = "root";
    String pass     = "";
    String database = "mysql";
    msql = new MySQL( this, "localhost", database, user, pass );
  if(msql.connect())
  {
      msql.query( "TRUNCATE  TABLE images" );
     // println("yay!");
  }
  
  size(640*2, 480);
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  myClient = new Client(this, "127.0.0.1", 80); 


  // mirror is by default enabled
  context.setMirror(true);

  // enable depthMap generation 
  context.enableDepth();

  // enable ir generation
  context.enableRGB();
   
	
  }

void draw()
{
  // update the cam
  context.update();

  background(200, 0, 0);

  // draw depthImageMap
  image(context.depthImage(), 0, 0);

  // draw irImageMap
  image(context.rgbImage(), context.depthWidth() + 10, 0);
    if (myClient.available() > 0) { 
    dataIn = myClient.read(); 
  } 
//  println(dataIn);
  
}
void keyPressed(){
  request=true;
  if(request){
   saveImages();
   String p1 = "kinurity\\\\rgb"+photoNum+".jpg";
   println(p1);
   String p2 = "kinurity\\\\ir"+photoNum+".jpg";
   println(p2);
   sendToServer(); 
   if(msql.connect())
  {
      msql.query( "INSERT INTO images VALUES(\""+p1+"\",\""+p2+"\")" );
     // println("yay!");
  }
  // request=false;
  }
   photoNum++;
}
void saveImages(){
  PImage Kpic = context.rgbImage();
  PImage Kir = context.depthImage();
  PImage pic = createImage(640,480,RGB);
  for (int i = 0; i < pic.pixels.length; i++) {
  pic.pixels[i] = Kpic.pixels[i]; 
  }
  //pic = Kpic.get();
  PImage ir = createImage(640,480,RGB);
  for (int i = 0; i < ir.pixels.length; i++) {
  ir.pixels[i] = Kir.pixels[i]; 
  }
 // ir = Kir.get();
//  Kpic.get();
 // pic.savePath();
  //ir.savePath();
 // String savePath = selectOutput();
  pic.save("rgb"+photoNum+".jpg");
  ir.save("ir"+photoNum+".jpg");
 


}
void sendToServer(){

}
