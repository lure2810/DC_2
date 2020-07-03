/* 自機クラス */
class Player{
  PVector loc;  //自機の位置
  float size;  //自機のサイズ
  float hitSize;
  int coolingTime;  //次弾発射までの間隔
  boolean isDead;  //やられ判定
  
  /* 自機の初期化 */
  Player(){
    size = 25;
    hitSize = size/2;
    loc = new PVector(width / 2, height - size / 2 - 10);
    coolingTime = 0;
    isDead = false;
  }
  
  /* 自機の表示用メソッド */
  void display(){
    stroke(255);
    fill(255, 100);
    ellipse(loc.x, loc.y, hitSize, hitSize);
    if(isDead){    //やられたとき
      fill(255, 255, 0);
      stroke(0, 255, 0);
      support++;
    } else {    //通常時
      noFill();
      stroke(0, 255, 0);
    }
    rect(loc.x, loc.y, size, size);
  }
  
  /* 自機のアップデートメソッド */
  void update(){
    isDead = false;
    this.moveByKey();  //キーボード入力で移動
    
    coolingTime++;
    
    /* 自機のやられ判定 */
    for(Bullet b: eneBullets){
      if(isHitBullet(b)){  //敵の弾に当たったとき
        isDead = true;
        b.isDead = true;
        break;
      }
    }
    for(Enemy e: enemies){
      if(isHitEnemy(e)){  //敵に当たったとき
        isDead = true;
        e.isDead = true;
        break;
      }
    }
  }
  
  /* キーボードの入力で移動するメソッド */
  void moveByKey(){
    /* 自機の移動、弾発射判定 */
    if(keyState.getState(RIGHT)&&(loc.x <= width-size/2)){ //右矢印キーで右に移動
      if(keyState.getState(SHIFT))loc.x += 2;
      else loc.x += 5;
    }
    if(keyState.getState(LEFT)&&(loc.x >= size/2)){  //左矢印キーで左に移動
      if(keyState.getState(SHIFT))loc.x += -2;
      else loc.x += -5;
    }
    if(keyState.getState(UP)&&(loc.y >= size/2+10)){  //上矢印キーで上に移動
      if(keyState.getState(SHIFT))loc.y += -2;
      else loc.y += -5;
    }
    if(keyState.getState(DOWN)&&(loc.y <= height-size/2-10)){ //下矢印キーで下に移動
      if(keyState.getState(SHIFT))loc.y += 2;
      else loc.y += 5;
    }
    if(keyState.getState(int('Z')) && coolingTime >= 5){  //zキーで弾を発射
      myBullets.add(new Bullet());
      mySubBullets1.add(new Bullet(this, true));
      mySubBullets2.add(new Bullet(this, false));
      coolingTime = 0;
    }
  }
  
  /* 敵弾に当たったかどうかを返すメソッド */
  boolean isHitBullet(Bullet b){
    if(dist(loc.x, loc.y, b.loc.x, b.loc.y ) < (hitSize)){  //敵の弾に当たったとき
      return true;
    }else{
      return false;
    }
  }
  
  /* 敵に当たったかどうかを返すメソッド */
  boolean isHitEnemy(Enemy e){
    if(abs(loc.x - e.loc.x) < hitSize + e.hitSize && abs(loc.y - e.loc.y) < hitSize + e.hitSize){
      return true;  //敵に当たったとき
    }else{
      return false;
    }
  }
}
