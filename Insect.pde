class Insect
{
  // Defining the vectors.
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  // Creating a contructor.
  Insect(float x, float y, float m){
     location = new PVector(x, y);
     velocity = new PVector(0, 0);
     acceleration = new PVector(0, 0);
     mass = m;
  }
  
  // Using the force.
  void applyForce(PVector force){
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  // Updating the measures of the insect.
  float xoff = 0, yoff = 1000;
  void update(float x, float y){
    // Implements the force of wind.
    xoff = xoff + 0.01;
    yoff = yoff + 0.01;
    PVector wind = new PVector(map(noise(xoff), 0, 1, -1, 1), map(noise(yoff), 0, 1, -1, 1));
    applyForce(wind);
    
    // Implements the force of hunger.
    PVector target = new PVector(x, y);
    PVector hunger = PVector.sub(target, location);
    hunger.normalize();
    hunger.mult(0.5);
    applyForce(hunger);
    
    // Borders
    if (location.x > width){
       location.x = 0;
    } else
    if (location.x < 0){
       location.x =  width;
    }
    
    if (location.y > height){
        location.y = 0;
    } else
    if (location.y < 0){
       location.y = height;
    }
    
    // Updating.
    velocity.limit(5);
    velocity.add(acceleration);
    acceleration.mult(0);
  }
  
  // Defining some needed variables and creating the eat method.
  float degrees = 0; int down = 0; float adegrees = 0;
  void eat(float x, float y){  
    float distance = sqrt(pow(x - location.x, 2) + pow(y - location.y, 2));
    float theta = velocity.heading();
    pushMatrix();
        translate(location.x, location.y);
        rotate(theta);  
        pushMatrix();
            scale(0.8);
            rotate(radians(90));
            translate(-328, -50);
            
            // Finds the distance between the food and the dragonfly, and stops it there.
            if (distance > 60){
                location.add(velocity);
                displayDragonflyAntennas();
                
                // Head and eyes
                fill(205,192,142);
                  circle(310, 43, 15);
                  circle(339, 43, 15);
                noFill();
                
                fill(78,109,154);
                  circle(324, 56, 40);
                noFill();
            } else
            {
               location.add(velocity.limit(4));
                if (adegrees >= 60){
                  down = 1;
                } else 
                if (adegrees <= -60){
                    down = 0; 
                }
            
                float aspeed = 10;
                if (down == 1){
                    adegrees -= aspeed;
                } else
                if (down == 0){
                   adegrees += aspeed; 
                }
                pushMatrix();
                    translate(0, 80);
                    rotateX(radians(adegrees));
                    pushMatrix();
                       translate(0, -80);
                       displayDragonflyAntennas();
                    popMatrix();
                popMatrix();
                
                // Head and eyes                
                fill(255,5,5);
                  circle(310, 43, 15);
                  circle(339, 43, 15);
                noFill();
                
                fill(78,109,154);
                  circle(324, 56, 40);
                noFill();
            }
        popMatrix();
    popMatrix();
  }
  
  // Showing the body of the dragonfly.
  void displayDragonfly(char state)
  {  
    //Finding the angle of the velocity vector.  
    float theta = velocity.heading();

    //Moving the dragongly.
    pushMatrix();
      translate(location.x, location.y);
      rotate(theta); 
      pushMatrix();
        scale(0.8);
        rotate(radians(90));
        translate(-328, -50);
    
        noStroke();
        if (state == 's'){
          // Right wings.
          displayDragonflyWings();
      
          // Left wings.
          pushMatrix();
          translate(650, 0, 0);
          rotateY(radians(-180));
          displayDragonflyWings();
          popMatrix();
        } else
        if (state == 'f'){
          if (degrees >= 60){
            down = 1;
          } else 
          if (degrees <= -60){
              down = 0; 
          }
      
          float speed = 20;
          if (down == 1){
              degrees -= speed;
          } else
          if (down == 0){
             degrees += speed; 
          }
          
          pushMatrix();
            translate(340, 0);
              rotateY(radians(degrees));
              pushMatrix();
                translate(-339, 0);
                displayDragonflyWings();
              popMatrix();
          popMatrix();
        
          pushMatrix();
            translate(310, 0);
            rotateY(radians(-degrees));
            pushMatrix();
              translate(340, 0, 0);
              rotateY(radians(-180));
              displayDragonflyWings();
            popMatrix();
          popMatrix();
        }
      
        // Middle body.
        fill(78,109,154);
        ellipse(325, 107, 38, 62);
        circle(338, 84, 1);
      
        // Lower body.
        ellipse(326, 245, 40, 240);
        noFill();
      popMatrix();
    popMatrix();
  }
  
  // Drawing the wings.
  void displayDragonflyWings()
  {
    fill(177,212,170);
    beginShape();
    curveVertex(338, 84); curveVertex(338, 84);
    curveVertex(461, 32); curveVertex(548, 9);
    curveVertex(612, 10); curveVertex(640, 26);
    curveVertex(608, 69); curveVertex(508, 117);
    curveVertex(344, 117); curveVertex(344, 117);
    endShape();
  
    beginShape();
    curveVertex(344, 117); curveVertex(344, 117);
    curveVertex(376, 121); curveVertex(438, 128);
    curveVertex(501, 141); curveVertex(569, 160);
    curveVertex(628, 188); curveVertex(614, 210);
    curveVertex(554, 220); curveVertex(335, 135);
    curveVertex(335, 135);
    endShape();
    noFill();
  }
  
  // Drawing the arms.
  void displayDragonflyAntennas()
  {
    // Antenna 1
    strokeWeight(5);
    stroke(57,46,44);
    beginShape();
      vertex(316, 82); vertex(290, 64); 
      vertex(291, 30); vertex(296, 20); 
    endShape();
  
    // Antenna 2
    pushMatrix();
      translate(650, 0);
      rotateY(radians(-180));
      beginShape();
        vertex(316, 82); vertex(290, 64); 
        vertex(291, 30); vertex(296, 20); 
      endShape();
    popMatrix();
    noStroke();
  }
}
