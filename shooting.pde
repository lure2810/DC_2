PImage bullet;

Player player;  //自機クラス
ArrayList<Enemy> enemies;  //敵クラス
ArrayList<Bullet> myBullets, mySubBullets1, mySubBullets2;  //自機弾クラス
ArrayList<Bullet> eneBullets;  //敵弾クラス
KeyState keyState;

boolean gameStart = false;
boolean clicked = false;
int support = 1;
float eneSize = 25;

void setup(){
  size(640, 1000);
  rectMode(CENTER);
  player = new Player();
  enemies = new ArrayList<Enemy>();
  myBullets = new ArrayList<Bullet>();
  mySubBullets1 = new ArrayList<Bullet>();
  mySubBullets2 = new ArrayList<Bullet>();
  eneBullets = new ArrayList<Bullet>(); 
  keyState.initialize();
  bullet = loadImage("bullet3.png");
}

/* メインの関数 */
void draw(){
  background(0);
  if(gameStart) game();   //ゲーム画面
  else startG();  //スタート画面
}

/* キーが押されたときに呼び出される関数 */
void keyPressed() {
  KeyState.putState(keyCode, true);
}

/* キーが離されたときに呼び出される関数 */
void keyReleased() {
  KeyState.putState(keyCode, false);
}

/* マウスがクリックされたときに呼び出される関数 */
void mouseClicked(){
  clicked = true;
}

void startG(){
  if(clicked) gameStart = true;
}

/* ゲームの進行管理 */
void game(){
  displayObject();
  updateObject();
}

/* ゲーム内のオブジェクトを描画する */
void displayObject(){
  player.display();    //自機表示
  
  for(Enemy enemy: enemies){
    enemy.display();    //敵表示
  }
  
  for(Bullet bullet: eneBullets){
    bullet.display();  //敵弾表示
  }
  
  for(Bullet bullet: myBullets){
    bullet.display();  //自機弾表示
  }
  
  if(support >= 1 && support < 3){
    for(Bullet bullet: mySubBullets1){
      bullet.display();  //自機サブ武器弾表示
    }
    if(support < 2){
      for(Bullet bullet: mySubBullets2){
        bullet.display();  //自機サブ武器弾表示
      }
    }
  }else  support = 0;
}

/* ゲーム内のオブジェクトを更新する */
void updateObject(){
  player.update();    //自機アップデート
  
  ArrayList<Enemy> nextEnemies = new ArrayList<Enemy>();
  for(Enemy enemy: enemies){
    enemy.update();    //敵アップデート
    if(!enemy.isDead){
      nextEnemies.add(enemy);    //やられていなかったら次の敵に
    }
  }
  enemies = nextEnemies;    //次の敵を補充
  
  ArrayList<Bullet> nextMyBullets = new ArrayList<Bullet>();
  for(Bullet bullet: myBullets){
    bullet.update();     //自弾をアップデート
    if(!bullet.isDead){
      nextMyBullets.add(bullet);    //当たっていなかったら次の弾に
    }
  }
  myBullets = nextMyBullets;
  
  ArrayList<Bullet> nextMySubBullets = new ArrayList<Bullet>();
  for(Bullet bullet: mySubBullets1){
    bullet.update();     //自弾（サブ）をアップデート
    if(!bullet.isDead){
      nextMySubBullets.add(bullet);    //当たっていなかったら次の弾に
    }
  }
  myBullets = nextMyBullets;
  
  ArrayList<Bullet> nextMySubBullets2 = new ArrayList<Bullet>();
  for(Bullet bullet: mySubBullets2){
    bullet.update();     //自弾（サブ）をアップデート
    if(!bullet.isDead){
      nextMySubBullets2.add(bullet);    //当たっていなかったら次の弾に
    }
  }
  myBullets = nextMyBullets;
  
  ArrayList<Bullet> nextEneBullets = new ArrayList<Bullet>();
  for(Bullet bullet: eneBullets){
    bullet.update();    //敵弾をアップデート
    if(!bullet.isDead){
      nextEneBullets.add(bullet);    //当たっていなかったら次の弾に
    }
  }
  eneBullets = nextEneBullets;
  
  addRandomEnemies();  //ランダムで敵の追加
}

/* 特定の確率を超えると敵を追加する */
void addRandomEnemies(){
  if(random(1) > 0.9){
    if(random(1) < 0.09) enemies.add(new Enemy(width + eneSize, random(height/2-eneSize), -3.0, 0.0)); //特定の確率で左右に動く敵に
    else enemies.add(new Enemy(random(eneSize/2, width - eneSize/2), -eneSize/2, 0, 3));
  }
}

static class KeyState {
  static HashMap<Integer, Boolean> key;

  // 入力状態の初期化
  static void initialize() {
    key = new HashMap<Integer, Boolean>();

    key.put(RIGHT, false);
    key.put(LEFT,  false);
    key.put(SHIFT, false);
    key.put(DOWN,  false);
    key.put(UP,  false);
    key.put(int('Z'),  false);
  }

  // keyCodeとその入力状態を受け取り、更新する
  static void putState(int code, boolean state) {
    key.put(code, state);
  }

  // keyCodeを受け取り、その入力状態を返す
  static boolean getState(int code) {
    return key.get(code);
  }
}
