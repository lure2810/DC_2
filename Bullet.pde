/* 弾クラス */
class Bullet{
  
  PVector loc;  //弾位置
  float sbx, sby, sb;  //sbx:敵と自機のx座標の差 sby:敵と自機のy座標の差 sb:敵と自機の直線距離
  float vel, velX, velY;  //移動速度
  float diffusion_angle = PI*2;  //拡散角
  float base_angle, change_angle, edge_angle;  //中心角度、間隔角度、端の角度
  float theta;
  boolean isMine;  //自機の弾かどうか
  boolean isNormal = false;  //まっすぐ飛ぶ弾かどうか
  boolean isDead;  //消失判定
  
  /* 自機弾の初期化 */
  Bullet(){
    loc = new PVector(player.loc.x, player.loc.y);  //自機の位置
    vel = -10;
    isMine = true;
  }
  
  /* 自機のサブ武器弾の初期化 */
  Bullet(Player weapon, boolean isRight){
    if(isRight) loc = new PVector(weapon.loc.x+weapon.size, weapon.loc.y);  //サブ武器の位置
    else loc = new PVector(weapon.loc.x-weapon.size, weapon.loc.y);  //サブ武器の位置
    //println(sin(frameCount));
    vel = -10;
    isMine = true;
  }
  
  /* 上下に移動する敵の弾の初期化 */
  Bullet(Enemy enemy, boolean _isNormal){
    isNormal = _isNormal;
    if(isNormal){
      loc = new PVector(enemy.loc.x, enemy.loc.y);  //敵の位置
      vel = 4;
    }else{
      loc = new PVector(enemy.loc.x, enemy.loc.y);
      sbx = player.loc.x - enemy.loc.x;
      sby = player.loc.y - enemy.loc.y;
      sb = sqrt(sbx*sbx+sby*sby);
      velX = sbx/sb * 6;
      velY = sby/sb * 6;
    }
    isMine = false;
  }
  
  /* 左右に移動する敵の弾の初期化 */
  Bullet(Enemy enemy, int i, int j, float angle){
    loc = new PVector(enemy.loc.x, enemy.loc.y-enemy.hitSize);
    if(j == 1){
      base_angle = atan2(player.loc.y-loc.y, player.loc.x-loc.x);  //中心角度を初期化
      change_angle = diffusion_angle / angle_split;  //wayの間隔
      edge_angle = base_angle + (angle_split-1)/2.0 * change_angle;  //弾の端の角度
      velX = cos(edge_angle-change_angle*i) * 5;  //弾のx座標速度
      velY = sin(edge_angle-change_angle*i) * 5;  //弾のy座標速度
    }else{
      theta = 137.5;
      velX = 0.9 * sqrt(i+1) * cos(i * radians(theta)+radians(angle));
      velY = 0.9 * sqrt(i+1) * sin(i * radians(theta)+radians(angle));
    }
  }
  
  /* 弾を表示 */
  void display(){
    if(isMine){
      stroke(0, 255, 0);
      line(loc.x, loc.y, loc.x, loc.y + vel);
    } else {
      image(bullet, loc.x-15, loc.y);
    }
  }
  
  /* 弾をアップデート*/
  void update(){
    if(isNormal || isMine) { //自機弾とノーマル弾のとき
      loc.y += vel;
      if((vel > 0 && loc.y > height) || (vel < 0 && loc.y < 0)){  //画面外に出たら
      isDead = true;
      }
    }
    else {
      loc.x += velX;
      loc.y += velY;
      if((loc.y > height) || (loc.x > width)){  //画面外に出たら
        isDead = true;
      }
    }
  }
}
