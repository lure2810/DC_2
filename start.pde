void setup(){
  rectMode(CENTER);
  size(850,1000);
  background(0);
  textSize(150);
  textAlign(CENTER,TOP);
  text("A.L.F.S.G",width/2,height/10);
}

void draw(){
  fill(255);
  textSize(50);
  rect(width/2,height*4/10,400,80);  
  rect(width/2,height*5.5/10,400,80);
  rect(width/2,height*7/10,400,80);
  rect(width/2,height*8.5/10,400,80);
  
 fill(0);
  text("EASY",width/2,height*3.7/10);
  text("NORMAL",width/2,height*5.2/10);
  text("HARD",width/2,height*6.7/10);
  text("VERY HARD",width/2,height*8.2/10);
  
}
