// Ghost in the Codec
// by Ryan Maguire w/ Joselyn McDonald

import gifAnimation.*;    // import the gifAnimation library
Gif myAnimation;

import processing.video.*;

int numPixels;
int[] backgroundPixels;
Capture video;

//image Tests
PImage png;   // Source image
PImage jpg;
PImage ghost;  // Destination image
Boolean mePic=false;

//font
PFont f; 

//design aesthetic variables
int yDeep = 120; 
int yDeep2 = 55; 
int textY = 55;

int  text1x = 180; 
int text2x = 810; 
int text3x = 1370;
int gap = 200;
int gapP = 250; 
int ga = 75; 

int id = 9;

boolean saveText = false;
boolean compressText = false; 
boolean printText = false; 

//timer
int interval = 750; 
int intervalP = 9000; 
int intervalC = 2000;

int time; 
int time2; 
int time3; 

int wallLeft = 40; 
int wallDown = 450; 
int wallGap = 15; 

void setup() {
   background(0); 
   fill(255); 
   
  size(displayWidth, displayHeight); 
  println(displayWidth);
  println(displayHeight);

  f = loadFont("AndaleMono-16.vlw"); 
  textFont(f, 30); 
  
  myAnimation = new Gif(this, "ryanGif.gif"); // load animated GIF file from 
                                            // the data folder,
  myAnimation.play();  
  
  //timer
  time = millis(); 
 

  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error

  video = new Capture(this, 960, 720);

  // Start capturing the images from the camera
  video.start();  

  numPixels = video.width * video.height;
  // Create array to store the background image
  backgroundPixels = new int[numPixels];
  // Make the pixels[] array available for direct manipulation
  loadPixels();
}

boolean sketchFullScreen() {
  return true;
}

void pause(int pause)
{
  int time = millis();
  while(millis() - time <= pause);
}

void draw() {
  
background (0); 
  
  
  if (video.available()) {
    video.read();
  } 

image(myAnimation,0,0, displayWidth*69, displayHeight*69);
fill(100, 100);
rect(0, 0, displayWidth, displayHeight);
  image(video, 480, 203);
 
 
  textFont(f, 25);

//TEST on top of Screen>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  fill(255);
 stroke(0); 
 text( "1 click to capture image", text1x, textY); 
 
    fill(200, 100);
   stroke(0); 
  triangle(text1x+gap, yDeep2, text1x+gapP, yDeep, text1x+ga, yDeep); 
    triangle(text1x-gap, yDeep2+40, text1x+gapP* sin(second()), yDeep + 60, text1x+ga, yDeep); 
        triangle(text1x-gap * sin(second()) , yDeep2+40, text1x+gapP, yDeep + 60, text1x+ga, yDeep); 

 fill(255);
 stroke(0);
  text("2 click to compress", text2x, textY);
     fill(200, 100);
   stroke(0); 
  triangle(text2x+gap, yDeep2, text2x+gapP, yDeep, text2x+ga, yDeep); 
    triangle(text2x+gap , yDeep2, text2x+gapP * sin(second()), yDeep , text2x+ga, yDeep); 
        triangle(text2x+gap , yDeep2, text2x+gapP +20, yDeep* cos(second()), text2x+ga, yDeep + 30); 


   fill(255);
   stroke(0);
  text("3 click to print GHOST", text3x, textY); 
   fill(200, 100);
   stroke(0); 
  triangle(text3x+gap, yDeep2, text3x+gapP, yDeep, text3x+ga, yDeep);
    triangle(text3x+gap, yDeep2, text3x+gapP, yDeep, text3x+ga, yDeep * sin(second()));    
    triangle(text3x+gap, yDeep2, text3x+gapP + 40, yDeep, text3x+ga, yDeep * cos(second()));
    
 //   end TEST on RIGHT Panel of Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    textFont(f, 12);
    fill(255, 120);
    text("ghost in the codec", displayWidth-200  + cos(millis()), displayHeight -45); 
        text("by Ryan Maguire", displayWidth-200 , displayHeight -25);
               text( "w/ Joselyn McDonald", displayWidth-200, displayHeight -12); 
               
 //  TEXT on LEFT Panel of Screen>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    textFont(f, 16);
    fill(255);
    text("Your MP3's, JPEG's, and MPEG's are haunted.", wallLeft, wallDown + cos(second())); 
        textFont(f, 13);

       text("Their ghosts are the material that is deleted", wallLeft, wallDown + wallGap*2); 
              text("when they are compressed from their original digital", wallLeft, wallDown + wallGap*3);
                      text("format. The Ghost in the Codec provides you the chance", wallLeft,wallDown + wallGap*4); 
                        text("to give these ghosts a tangible form,", wallLeft, wallDown + wallGap*5); 
                          text("by printing the information lost during JPEG", wallLeft, wallDown + wallGap*6);
                           text("compression and adding it to the walls", wallLeft, wallDown + wallGap*7); 
                            text("in this room.", wallLeft, wallDown + wallGap*8); 
                            
                                text("The sounds you hear were deleted by MP3", wallLeft, wallDown + wallGap*10);
                                       text("compression during the original MP3 listening tests", wallLeft, wallDown + wallGap*11);
                                       text("and at other times.", wallLeft, wallDown + wallGap*12);


  if (mePic == true) {
    
    png = loadImage("me"+id+".png"); 
    jpg = loadImage("me"+id+".jpg");
    ghost = createImage(png.width, png.height, RGB);

    png.loadPixels();
    jpg.loadPixels();
    ghost.loadPixels();

    // Difference between the current frame and the stored background
    int presenceSum = 100;

    for (int x = 0; x < png.width; x++) {
      for (int y = 0; y < png.height; y++ ) {
        int loc = x + y*png.width;
        color pix1 = png.pixels[loc];
        color pix2 = jpg.pixels[loc];

        // ghost.pixels[loc] = color(diff);

        // Extract the red, green, and blue components of the current pixel's color
        int pix1R = (pix1 >> 16) & 0xFF;
        int pix1G = (pix1 >> 8) & 0xFF;
        int pix1B = pix1 & 0xFF;
        // Extract the red, green, and blue components of the background pixel's color
        int pix2R = (pix2 >> 16) & 0xFF;
        int pix2G = (pix2 >> 8) & 0xFF;
        int pix2B = pix2 & 0xFF;
        // Compute the difference of the red, green, and blue values
        float diffR = abs(color(pix2R) - color(pix1R));
        float diffG = abs(color(pix2G) - color(pix1G));
        float diffB = abs(color(pix2B) - color(pix1B));

        // Render the difference image to the screen
        ghost.pixels[loc] = color(diffR, diffG, diffB);

        mePic = false;
      }
    }
    ghost.updatePixels();
    ghost.save("data/ghost"+id+".png");
  }

//image save Text -----------------------------------
  if (saveText == true) {
    fill(255, 200); 
      textFont(f, 40);
  
  fill(102, 255, 102); 
     text( "Image", displayWidth - 400, wallDown + 20); 
          text( "Being", displayWidth - 400, wallDown + 70 ); 
                    text( "Captured", displayWidth - 400, wallDown + 120); 


 
   if (millis() - time > intervalC){
    saveText = false; 
    //time = millis(); 
  }
}



//image print Text -----------------------------------

  if (printText == true) {
    
    fill(255, 200); 
    textFont(f, 35);
      fill(102, 255, 102); 
     text( "PRINTING", displayWidth - 400, wallDown +20);
          text("in progress", displayWidth - 400, wallDown +70);
        text("please hold", displayWidth - 400, wallDown + 120);
 
 

   if (millis() - time3 > intervalP){
   
    printText = false; 
   time3 = millis(); 
  }
}

}

void mousePressed() {

  
  //capture image
  if (mouseX > text1x && mouseX < text1x +200) {
    if (mouseY >0 && mouseY<220 ) {
        id += 1;      
         stroke(255); 
        fill(200, 200, 200, 100); 
        
       
            PImage partialSave =get(480, 203, 960, 720); 
      partialSave.save("me"+id+".jpg");
      partialSave.save("me"+id+".png");
        
    saveText = true;
    time = millis(); 

    }
    
  }

  // save image
  if (mouseX > text2x && mouseX < text2x+200) {
    if (mouseY >0 && mouseY<220 ) {
      
     fill(255, 200); 
     textFont(f, 40);
      fill(102, 255, 102); 

     text( "GHOST", displayWidth - 400, wallDown + 50);
     text( "compression", displayWidth - 400, wallDown + 100); 
     text( "in progress", displayWidth - 400, wallDown + 150);
      
     //time2 = millis();
     println("saved");
     //compressText = true;
     mePic=true; 
    
    }
  }

  //print image

  if (mouseX > text3x && mouseX < text3x+250) {
    if (mouseY >0 && mouseY<220 ) {
     
      printText = true; 
      time3 = millis(); 
      
      printImage("ghost"+id+".png");
      
    }
  }
}