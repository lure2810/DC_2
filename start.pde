String[] level = {"EASY","NORMAL","HARD","VERY HARD"};

void setup(){
  rectMode(CENTER);
  size(850,1000);
  background(0);
  textSize(150);
  textAlign(CENTER,TOP);
  text("A.L.F.S.G",width/2,height/10);
}

void draw(){
  for(int i = 0; i < 4; i++){
    if(mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height*(i+4)/10 - 40 && mouseY < height*(i+4)/10 + 40){
      fill(127,255,0);
    }else{
      fill(255);
    }    
    rect(width/2,height*(i+4)/10,400,80);
    textSize(50);
    fill(0);
    text(level[i],width/2,height*(i+4-0.3)/10);
  }
  
}
