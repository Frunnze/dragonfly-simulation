ArrayList<Midge> mlist = new ArrayList<Midge>();
int total = 4;
void setup(){
   size(1500, 1000, P3D);
 
   for (int i = 0; i < total; i++){
       mlist.add(new Midge(random(width), random(height), random(20)));
   }
}

// Defining the insects.
Insect Dragonfly1 = new Insect(1500 - 10, 1000 - 10, 1);
Insect Dragonfly2 = new Insect(10, 10, 5);

float minDistance1 = width, minDistance2 = width, midge1X, midge1Y, midge2X, midge2Y;
void draw(){
  //background(49, 167, 0);
  background(256, 256, 256);
  
  for (int i = 0; i < mlist.size(); i++){
     Midge m = mlist.get(i);
     
     // Distance between the dragonfly1 and 2.
     float distance1 = sqrt(pow(Dragonfly1.location.x - m.location.x, 2) + pow(Dragonfly1.location.y - m.location.y, 2));
     float distance2 = sqrt(pow(Dragonfly2.location.x - m.location.x, 2) + pow(Dragonfly2.location.y - m.location.y, 2));
     
     m.update(distance1, distance2);
     if (m.isDead()){
        mlist.remove(i); 
     }

     if (distance1 < minDistance1){
         minDistance1 = distance1;
         midge1X = m.location.x;
         midge1Y = m.location.y;
     }
     
     if (distance2 < minDistance2){
         minDistance2 = distance2;
         midge2X = m.location.x;
         midge2Y = m.location.y;
     }
   }
   minDistance1 = width;
   minDistance2 = width;
   
   if (mlist.size() == 0){
       for (int i = 0; i < total; i++){
         mlist.add(new Midge(random(-width - 100), random(-height - 100), random(20)));
       }
     
   }
  
   // Finds the nearest midge for the Dragonfly1.
   Dragonfly1.update(midge1X, midge1Y);
   Dragonfly1.displayDragonfly('f');
   Dragonfly1.eat(midge1X, midge1Y);
    
   Dragonfly2.update(midge2X, midge2Y);
   Dragonfly2.displayDragonfly('f');
   Dragonfly2.eat(midge2X, midge2Y);
}
