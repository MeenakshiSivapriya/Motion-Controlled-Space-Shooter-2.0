
import processing.net.*; 
Server myServer;
Server myServer1;


PrintWriter output;
import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

void setup() {
  size(1920, 1080, P3D);

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  
  myServer = new Server(this, 8887); 
   myServer1 = new Server(this, 5204); 
  kinect.init();
}

void draw() {
  background(0);

  image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
 // for tracking only two people
   if( skeletonArray.size()>1){
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(0);
    if (skeleton.isTracked()) {
      
      KJoint[] joints = skeleton.getJoints();
      System.out.println();

      color col  = skeleton.getIndexColor();
   
          if (joints[16].getY()<joints[7].getY())
     {
             myServer.write("0\r\n");
             System.out.println("first person 0");
     }
     
  //left
     else if(joints[6].getX()<joints[2].getX()){
       myServer.write("2\r\n");
                    System.out.println("2");

     }
     
      //right
     else if(joints[6].getX()>joints[2].getX()){
       myServer.write("3\r\n");
                    System.out.println("3");

     }
 
    else
       {  
         myServer.write("1\r\n");
       }
       
     
    //  col1 = -16776961
     // col2 = -65536

      fill(col);
      stroke(col);
      drawBody(joints);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
      
      
    KSkeleton skeleton1 = (KSkeleton) skeletonArray.get(1);
    if (skeleton.isTracked()) {
      
      KJoint[] joints1 = skeleton1.getJoints();
      System.out.println();

      color col1  = skeleton1.getIndexColor();
    
     
          if (joints1[16].getY()<joints1[7].getY())
     {
             myServer1.write("0\r\n");
             System.out.println("second person 0");
     }
     
  //left
     else if(joints1[6].getX()<joints1[2].getX()){
       myServer1.write("2\r\n");
                    System.out.println("2");

     }
     
      //right
     else if(joints1[6].getX()>joints1[2].getX()){
       myServer1.write("3\r\n");
                    System.out.println("3");

     }
 
    else
       {  
         myServer1.write("1\r\n");
       }
      
      fill(col1);
      stroke(col1);
      drawBody(joints1);

      //draw different color for each hand state
      drawHandState(joints1[KinectPV2.JointType_HandRight]);
      drawHandState(joints1[KinectPV2.JointType_HandLeft]);
           
    }
  }

  fill(255, 0, 0);
  text(frameRate, 50, 50);
}}

//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);    
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
 }

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}