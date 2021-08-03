import processing.serial.*;
import controlP5.*;

ControlP5 cp5;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
float height_old = 0;
float height_new = 0;
float inByte = 0;
int BPM = 0;
int beat_old = 0;
float[] beats = new float[500];  // Used to calculate average BPM
int beatIndex;
float threshold = 620;  //Threshold at which BPM calculation occurs
boolean belowThreshold = true;
PFont font;
int mode = 0;
int frsReading = 0;
int inhale = 0;
int breaths;
int firstbreath = 0;
int breathsPerMin = 0;
int mhr=0;
int breathstart;
int breathrest;
int breathdiff;
int startingtime;
int restingtime;
int difference;
String MHRS;
int exhaleduration;
int inhaleduration;
int newInhale;
int counter =0;
int zonecheck = 0;
int newExhale;
int check = 0;
Textlabel title;
Textlabel maxheart;
Textfield textfield;
Textlabel cardiozone;
Textlabel stressed;
Textlabel zen;
int maxfsr=400;
int minfsr=400;


Button mode1;
Button mode2;
Button mode3;
Button submit;

void setup () {
  // set the window size:
  size(1000, 400);        

  // List all the available serial ports
  printArray(Serial.list());
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 115200);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background:
  background(0xff);
  font = createFont("Ariel", 12, true);

  cp5 = new ControlP5(this);
  title = cp5.addTextlabel("label")
    .setText("Heartrate Monitor ECG App")
    .setPosition(100, 50)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 20))
    ;

  textfield = cp5.addTextfield("Age").setPosition(650, 350).setColorValue(0xffffff00).setSize(100, 50).setAutoClear(false);
  println("Enter your age");
  fill(0x00);
  text("Enter your age:", 650, 340);
  submit = cp5.addButton("Submit").setPosition(500, 350).setSize(100, 50);
  maxheart = cp5.addTextlabel("maxheartrate").setPosition(700, 50).setColorValue(0xffffff00).setFont(createFont("Georgia", 20));

  mode1 = cp5.addButton("ModeOne").setPosition(100, 350).setSize(100, 50);
  mode1.hide();
  mode2 = cp5.addButton("ModeTwo").setPosition(200, 350).setSize(100, 50);
  mode2.hide();
  mode3 = cp5.addButton("ModeThree").setPosition(300, 350).setSize(100, 50);
  mode3.hide();

  Textlabel cardiozone;
  cardiozone = cp5.addTextlabel("Cardio").setText("").setPosition(600, 100).setColorValue(0xffffff00);
  cardiozone.hide();
  stressed = cp5.addTextlabel("Stressed").setText("").setPosition(600, 100).setColorValue(0xffffff00);
  stressed.hide();
  zen = cp5.addTextlabel("Zen").setText("").setPosition(600, 100).setColorValue(0xffffff00);
  zen.hide();
}

void Submit()
{
  startingtime = millis();
  String text = cp5.get(Textfield.class, "Age").getText();
  print("Your age is: ");
  println(text);

  //print("Your maximum heart rate is: ");
  mhr= 220 - Integer.parseInt(text);
  MHRS = ("maximum heart rate is " + Integer.toString(mhr) + " BPM");
  maxheart.setText(MHRS);
  //cp5.addTextfield(MHRS).setPosition(400,250).setSize(100,50).setAutoClear(false);
  submit.hide();
  textfield.hide();
}

void ModeOne()
{
  print(BPM);
  mode1.hide();
  mode2.hide();
  mode3.hide();
  mode = 1;
}

void ModeTwo()
{

  mode1.hide();
  mode2.hide();
  mode3.hide();
  mode = 2;
}

void ModeThree()
{
  zen.show();
  mode1.hide();
  mode2.hide();
  mode3.hide();
  mode = 3;
}

void draw () {
  restingtime = millis();
  difference = restingtime - startingtime;
  if (millis() % 30 == 0) {
    fill(0xFF);
    rect(0, 0, 200, 20);
    fill(0x00);
    if(BPM > 30)
    text("Current BPM: " + BPM, 15, 15);
  }
  if (difference > 30000 && mode == 0)
  {
    breathsPerMin = breaths * 2;

    fill(0xFF);
    rect(0, 0, 200, 20); 
    fill(0x00);
    text(" Resting BPM: " + BPM, 15, 35);
    text(" Resting Breaths Per Minute: " + breathsPerMin, 15, 50);
    mode1.show();
    mode2.show();
    mode3.show();
    mode = 4;
  }

  if (mode == 1)
  {
    //Map and draw the line for new data point
    inByte = map(inByte, 0, 1023, 0, height);
    height_new = height - inByte; 
    line(xPos - 1, height_old, xPos, height_new);
    height_old = height_new;

    // at the edge of the screen, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      background(0xff);
    } else {
      // increment the horizontal position:
      xPos++;
    }
    String zone= "test";
    if (BPM <.6 *mhr)
      zone = ("Very Light");
    else if ( BPM <.7 * mhr)
      zone = ("Light");
    else if (BPM < .8*mhr)
      zone = ("Moderate");
    else if (BPM <.9 * mhr)
      zone = ("Hard");
    else if (BPM < mhr)
      zone = ("Very hard");


    fill(0xff);
    rect(600, 90, 170, 20);
    fill(0x00);
    text("Cardio zone is " + zone, 600, 100);
  }
  if (mode ==2)
  {
    if (breathsPerMin > 16) {
      fill(0xff);
      rect(600, 90, 170, 20);
      fill(0xff);
      text("You are stressed", 600, 100);
    } else
    {
      fill(0xff);
      rect(600, 90, 170, 20);
      fill(0x00);
      text("You are calm", 600, 100);
    }
  }
  if (mode ==3)
  {
    if (check==1) {
      fill(0xff);
      rect(600, 90, 170, 20);
      fill(0x00);
      text("You are meditating", 600, 100);
      
    } else {
      fill(0xff);
      rect(600, 90, 170, 20);
      fill(0x00);
      text("You are not meditating", 600, 100);
    }
  }
}


void serialEvent (Serial myPort) 
{
  // get the ASCII string:
  String val = myPort.readString();
  String[] list = split(val, ',');
  if (list.length ==2) {
    String inString = list[0];
    String a1 = list[1];
    print(inString);
    print("\n");
    print(a1);
    if (inString != null) 
    {
      // trim off any whitespace:
      inString = trim(inString);

      // If leads off detection is true notify with blue line
      if (inString.equals('!')) 
      { 
        stroke(0, 0, 0xff); //Set stroke to blue ( R, G, B)
        inByte = 512;  // middle of the ADC range (Flat Line)
      }
      // If the data is good let it through
      else 
      {

        //stroke(0xff, 0, 0); //Set stroke to red ( R, G, B)
        inByte = float(inString); 

        // BPM calculation check
        if (inByte > threshold && belowThreshold == true)
        {
          calculateBPM();
          if (BPM <.6 *mhr)
            stroke (192, 192, 192);
          else if ( BPM <.7 * mhr) 
            stroke (0, 255, 255);
          else if (BPM < .8*mhr)
            stroke (0, 153, 76);
          else if (BPM <.9 * mhr)
            stroke (255, 255, 0);
          belowThreshold = false;
        } else if (inByte < threshold)
        {
          belowThreshold = true;
        }
      }
    }
    if (a1 != null)
    {
      a1 = trim(a1);
      int frsReading= Integer.parseInt(a1);
      if (frsReading > maxfsr)
          maxfsr = frsReading;
      if (frsReading < minfsr)
          minfsr = frsReading;
      if (firstbreath == 0) {
        if (frsReading < (maxfsr + minfsr)/2)
          inhale = 1;
        else
          inhale = 0;
        firstbreath =1;
      }
      if (inhale ==0) {
        if (frsReading < (maxfsr + minfsr)/2 ) {
          newInhale = millis();
          inhale = 1;
          exhaleduration = newInhale-newExhale;
          if (inhaleduration/3 > exhaleduration) {
            counter++;
            if (counter == 3) {
              print("meditating");
              check = 1;
              counter = 0;
            }
          } else
          {
            check = 0;
            counter = 0;
          }
        }
      }
      if (inhale == 1) {
        if (frsReading >= (maxfsr + minfsr)/2) {
          inhale = 0;
          breaths++;
          newExhale = millis();
          inhaleduration = newExhale-newInhale;
        }
      }
    }
  }
}

void calculateBPM () 
{
  int beat_new = millis();    // get the current millisecond
  int diff = beat_new - beat_old;    // find the time between the last two beats
  float currentBPM = 60000 / diff;    // convert to beats per minute
  beats[beatIndex] = currentBPM;  // store to array to convert the average
  float total = 0.0;
  float j = 0.0;
  for (int i = 0; i < 500; i++) {
    if (beats[i] < 200 && beats[i] > 30)
    {
      total += beats[i];
      j += 1.0;
    }
  }
  BPM = int(total / j);
  beat_old = beat_new;
  beatIndex = (beatIndex + 1) % 500;  // cycle through the array instead of using FIFO queue
}
