int state;    // 現在の状態 (0=タイトル, 1=ゲーム, 2=エンディング)
long t_start; // 現在の状態になった時刻[ミリ秒]
float t;      // 現在の状態になってからの経過時間[秒]

void setup(){
  size(850, 1000);
  textSize(32);
  textAlign(CENTER);
  fill(255);
  state = 0;
  t_start = millis();
}

void draw(){
  background(0);
  t = (millis() - t_start) / 1000.0; // 経過時間を更新
  text(nf(t, 1, 3)  + "sec.", width * 0.5, height * 0.9); // 経過時間を表示
  
  int nextState= 0;
  if(state == 0){ nextState = title(); }
  else if(state == 1){ nextState = game_easy(); }
  else if(state == 2){ nextState = game_nomal(); }
  else if(state == 3){ nextState = game_hard(); }
  else if(state == 4){ nextState = game_veryhard(); }
  else if(state == 5){ nextState = ending(); }
  
  if(state != nextState){ t_start = millis(); } // 状態が遷移するので、現在の状態になった時刻を更新する
  state = nextState;
}

int title(){
  text("A.L.F.S.G", width * 0.5, height * 0.3);
  text("Press '1' key to start easy", width * 0.5, height * 0.5);
  text("Press '2' key to start nomal", width * 0.5, height * 0.6);
  text("Press '3' key to start hard", width * 0.5, height * 0.7);
  text("Press '4' key to start veryhard", width * 0.5, height * 0.8);
  if(keyPressed && key == '1'){ // if '1' key is pressed
    return 1; // start game
  }else if(keyPressed && key == '2'){
    return 2;
  }else if(keyPressed && key == '3'){
    return 3;
  }else if(keyPressed && key == '4'){
    return 4;
  }
  return 0;
}

int game_easy(){
  text("Game Start -mode easy-(for 3 seconds)", width * 0.5, height * 0.5);
  if(t > 3){  // if ellapsed time is larger than 5 seconds
    return 5; // go to ending
  } 
  return 1;
}
int game_nomal(){
  text("Game Start -mode nomal-(for 3 seconds)", width * 0.5, height * 0.5);
  if(t > 3){  // if ellapsed time is larger than 5 seconds
    return 5; // go to ending
  } 
  return 2;
}
int game_hard(){
  text("Game Start -mode hard-(for 3 seconds)", width * 0.5, height * 0.5);
  if(t > 3){  // if ellapsed time is larger than 5 seconds
    return 5; // go to ending
  } 
  return 3;
}
int game_veryhard(){
  text("Game Start -mode veryhard-(for 3 seconds)", width * 0.5, height * 0.5);
  if(t > 3){  // if ellapsed time is larger than 5 seconds
    return 5; // go to ending
  } 
  return 4;
}




int ending(){
  text("Ending", width * 0.5, height * 0.5);
  if(t > 3){
    text("Press 'a' to restart.", width * 0.5, height * 0.7);
    if(keyPressed && key == 'a') return 0;
  }
  return 5;
}
