
class Daun{
  float x;
  float y;
  float angleDaun = 0;     // Angle of rotation
  float angleSpeed = PI / 360; // Speed of rotation (1 degree per frame)
  boolean rotatingClockwise = true; // Flag to track direction of rotation
  
  Daun(float tempX, float tempY){
    x = tempX;
    y = tempY;
  }

  void move(){
    if (rotatingClockwise) {
      angleDaun += angleSpeed;
      if (angleDaun >= radians(30)) {
        rotatingClockwise = false;
      }
    } else {
      angleDaun -= angleSpeed;
      if (angleDaun <= 0) {
        rotatingClockwise = true;
      }
    }
  }
 
  void show(float angle, boolean terbalik, float speed) {
    if(terbalik == true){
    pushMatrix();
      fill(#39A514);
      translate(x, y);
      rotate(radians(angle) + angleDaun*speed);
      beginShape();
        vertex(0, 0);
        bezierVertex(100, -170, 350, -170, 400, 0);
        bezierVertex(100, -40, 150, -40, 0, 0);
      endShape();
    popMatrix();
    } else{
    pushMatrix();
      fill(#39A514);
      translate(x, y);
      rotate(radians(angle)+ angleDaun*speed);
      beginShape();
        vertex(0, 0);
        bezierVertex(-100, -170, -350, -170, -400, 0);
        bezierVertex(-100, -40, -150, -40, 0, 0);
      endShape();
    popMatrix();
    }
}
}
