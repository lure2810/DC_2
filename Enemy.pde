int angle_split = 21;
float addAngle = 5.0;

/* 敵クラス */
class Enemy{
  PVector loc;  //敵の位置
  float velX, velY;  //敵の移動速度(x, y)
  float size;  //敵のサイズ
  float hitSize;  //敵の当たり判定のサイズ
  float angle;
  int coolingTime;  //次弾発射までの間隔
  boolean isDead;  //やられ判定
  boolean isSlide;  //左右に移動する敵かどうか
  
  /* 敵クラスの初期化 */
  Enemy(float locX, float locY, float _velX, float _velY){
    loc = new PVector(locX, locY);  //横移動の敵
    size = 25;
    angle = 0;
    hitSize = size/2;
    velX = _velX;
    velY = _velY;
    coolingTime = int(random(60));
    isDead = false;
  }
  
  /* 敵の表示をするメソッド */
  void display(){
    noFill();
    if(velX >= 0) stroke(255, 0, 0);
    else stroke(0, 255, 255);
    rect(loc.x, loc.y, size, size);
  }
  
  /* 敵のアップデートをするメソッド */
  void update(){//敵の位置更新
    loc.x += velX;
    loc.y += velY;
    
    if(isOutDisplay()){  //画面外に出たとき
      isDead = true;
    }
    coolingTime++;
    if(coolingTime >= 60 && loc.y <= height*3/5){    //次弾発射条件
      if(random(1) <= 0.08) eneBullets.add(new Bullet(this, true));
      else if(velX < 0){
        for(int i = 0; i < angle_split; i++){
          eneBullets.add(new Bullet(this, i, 1, angle));
        }
      }
      else eneBullets.add(new Bullet(this, false));
      coolingTime = 0;
    }
    hitOthers();
  }
  
  void hitOthers(){
    for(Bullet b: myBullets){
      if(isHit(b)){  //自機弾と当たったとき
        isDead = true;
        b.isDead = true;
        break;
      }
    }
    for(Bullet b: mySubBullets1){
      if(isHit(b)){  //自機弾と当たったとき
        isDead = true;
        b.isDead = true;
        break;
      }
    }
    for(Bullet b: mySubBullets2){
      if(isHit(b)){  //自機弾と当たったとき
        isDead = true;
        b.isDead = true;
        break;
      }
    }
  }
  
  /* 敵が画面外にいるかどうかを返すメソッド */
  boolean isOutDisplay(){
    if(loc.y > height || loc.x+size/2 < 0) return true;
    return false;
  }
  
  /* 自機の弾と当たったかどうかを返すメソッド */
  boolean isHit(Bullet b){
    if((loc.x - hitSize <= b.loc.x && b.loc.x <= loc.x + hitSize)
         && (loc.y - hitSize <= b.loc.y && b.loc.y <= loc.y + hitSize)) return true;
    return false;
  }
}
