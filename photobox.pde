import processing.video.*;
import java.util.Date;

Capture myCapture;
Date time;
String file;
boolean buzzered = false;
PImage img;
StringList filenames = new StringList();
int counter;
int currentImage;

void setup(){
  size(displayWidth, displayHeight);
  String[] cameras = Capture.list();
  if(cameras.length > 0){
    myCapture = new Capture(this, cameras[1]);
    myCapture.start(); 
  }  
  java.io.File folder = new java.io.File(dataPath("../fotos"));
  System.out.println(folder);
  System.out.println(folder.list().length);
  
  for(int i = 0; i<folder.list().length; i++){
    filenames.append(folder.list()[i]);
  }
}


boolean sketchFullScreen(){
  return true;
}

void draw(){
  if(buzzered){
    if (myCapture.available()) {
      myCapture.read();
    }
    pushMatrix();
    scale(-1.0, 1.0);
    image(myCapture, -displayWidth, 0, displayWidth, displayHeight);
    popMatrix();
    
    Date time2 = new Date();
    textSize(200);
    if(time2.getTime() < time.getTime()+1000){
      text("5", 300, 300);
    } else if(time2.getTime() < time.getTime()+2000){
      text("4", 300, 300);
    } else if(time2.getTime() < time.getTime()+3000){
      text("3", 300, 300);
    } else if(time2.getTime() < time.getTime()+4000){
      text("2", 300, 300);
    } else if(time2.getTime() < time.getTime()+5000){
      text("1", 300, 300);
    } else if(time2.getTime() > time.getTime()+6000){
      file = time2.getTime()+".jpg";
      saveFrame("fotos/"+file);
      filenames.append(file);
      fill(255,255,255);
      rect(0,0,displayWidth, displayHeight);
      buzzered = false;
      counter = 100;
    }    
  } else{

      if(counter == 0){
        currentImage = (currentImage+1)%filenames.size();
        file = filenames.get(currentImage);        
        counter = 100;
      }
      if(counter == 100){
        img = loadImage("../fotos/"+file);
      }
      image(img,0,0);
      counter--;
      
  }
}  

void keyPressed(){
  if(keyCode == 35) {
    buzzered = true;
    time = new Date();
  }
}  
