class Midge extends Insect
{
  float lifespan;
  
  // Creating the constructor.
  Midge(float x, float y, float m){
    super(x, y, m); 
    lifespan = 100;
  }
  
  // Updating the measures.
  float xoff = 0, yoff = 1000;
  void update(float d1, float d2){
    // Implements the force of wind.
    xoff = xoff + 0.01;
    yoff = yoff + 0.01;
    PVector wind = new PVector(map(noise(xoff), 0, 1, -1, 1), map(noise(yoff), 0, 1, -1, 1));
    applyForce(wind);
    
     // Implementing the force of fear.
    float Distance1 = sqrt(pow(location.x - Dragonfly1.location.x, 2) + pow(location.y - Dragonfly1.location.y, 2));
    PVector fear1 = new PVector(Dragonfly1.velocity.x, Dragonfly1.velocity.y);
    fear1.normalize();
    fear1.mult(1);
  
    float Distance2 = sqrt(pow(location.x - Dragonfly2.location.x, 2) + pow(location.y - Dragonfly2.location.y, 2));
    PVector fear2 = new PVector(Dragonfly2.velocity.x, Dragonfly2.velocity.y);
    fear2.normalize();
    fear2.mult(1);
    if (Distance1 < 150){
       applyForce(fear1); 
    }
    if (Distance2 < 150){
       applyForce(fear2); 
    } 
    
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
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(4);
    acceleration.mult(0);
    
    if (d1 > 60){
       displayMidge();
    } else
    if (d1 <= 60){
       lifespan -= 0.5;
    }
    
    if (d2 > 60){
       displayMidge();
    } else
    if (d2 <= 60){
       lifespan -= 0.5;
    }
  }
   
  void displayMidge()
  {  
    //Finding the angle of the velocity vector.  
    float theta = velocity.heading();

    //Moving the midge.
    pushMatrix();
      translate(location.x, location.y);
      rotate(theta); 
      pushMatrix();
        scale(0.2);
        rotate(radians(90));
        translate(-328, -50);
    
        noStroke();
        if (degrees >= 60){
          down = 1;
        } else 
        if (degrees <= -60){
            down = 0; 
        }
    
        float speed = 30;
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
      
        // Head and eyes
        fill(205,192,142);
          circle(310, 43, 15);
          circle(339, 43, 15);
        noFill();
        
        fill(0);
        circle(324, 56, 40);
        
        // Middle body.
        ellipse(325, 107, 38, 62);
        circle(338, 84, 1);
      
        // Lower body.
        ellipse(326, 245, 40, 240);
        noFill();
      popMatrix();
    popMatrix();
  }
  
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
