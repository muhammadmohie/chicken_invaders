// =============================================
//        Fonts 
//===============================================
PFont titleFont;
PFont bodyFont;
// =============================================
//        Images 
//===============================================
PImage background;
// =============================================
//        Shapes 
//===============================================
PShape sun;
PShape earth;
PShape moon;
PShape planet1;
PShape planet2;
PShape blueChicken;
PShape redChicken;
PShape chickenMeal;
PShape egg;
PShape crackedEgg;
PShape spaceship;
PShape gift;
PShape bullet;
PShape heart;
PShape chickensScore;
// =============================================
// Collections and variables
//===============================================
// variables of spaceShip and bullets
ArrayList < PVector > bullets = new ArrayList < PVector > ();
ArrayList < PVector > doubleBullet = new ArrayList < PVector > ();
ArrayList < PVector > doubleBullet2 = new ArrayList < PVector > ();
float bulletSpeed = 10;
int x = 0; // flage To see if the player pressed the mouse once or kept pressing it
int d = 0;
int timer = 4000;
int time = 0; // time to keep a space between the bullets 
int xd; // x-axis dimension
int yd; // y-axis dimension
int shipHeight = 100; // the height of the spaceSipe from bottom
int spaceshipHeight = 80;
int spaceshipWidth = 80;
int shipSpeed = 20;
// variables of chickens and eggs
ArrayList < PVector > eggs = new ArrayList < PVector > ();
ArrayList < ChickenVector > chicken = new ArrayList < ChickenVector > ();
ArrayList < PVector > chickenMeals = new ArrayList < PVector > ();
ArrayList < PVector > chickenMealTranslation = new ArrayList < PVector > ();
int attempts = 3;
int score = 0;
int resultScore = 0;
int frameCountEasyness = 30;
int chickenSpeed = 5;
int eggSpeed = 5;
int chickenMealSpeed = 5;
int chickenMealWidth = 80;
int chickenMealHeight = 80;
int killedChickens = 0;
// variables of gifts
ArrayList < PVector > gifts = new ArrayList < PVector > ();
ArrayList < PVector > giftTranslation = new ArrayList < PVector > ();
int giftSpeed = 5;
int giftWidth = 60;
int giftHeight = 60;
int numberOfGifts = 0;
// variables of start page and the end page
boolean gameStart = true;
boolean canLevelUp = false;
boolean gameContinue = false;
boolean gameEnd = false;
int level = 1;
int maxLevel = 2;
float sunAngle = 0.0;
float planet1Angle = 0.0;
float planet2Angle = 0.0;
float moonAngle = 0.0;
float earthAngle = 0.0;
boolean onceAtFive = false;
boolean onceAtThirteen = false;
void setup()
    {
        size(1024, 700);
        // =============== Loading Images =================
        background = loadImage("background.jpg");
        // =============== Loading Shapes =================
        sun = loadShape("sun.svg");
        earth = loadShape("earth.svg");
        moon = loadShape("moon.svg");
        planet1 = loadShape("planet1.svg");
        planet2 = loadShape("planet2.svg");
        blueChicken = loadShape("blue-chicken.svg");
        redChicken = loadShape("red-chicken.svg");
        chickenMeal = loadShape("chicken-meal.svg");
        egg = loadShape("egg.svg");
        crackedEgg = loadShape("cracked-egg.svg");
        spaceship = loadShape("spaceship.svg");
        gift = loadShape("gift.svg");
        bullet = loadShape("bullet.svg");
        heart = loadShape("heart.svg");
        chickensScore = loadShape("score.svg");
        // ============= Loading fonts ================
        titleFont = loadFont("ShowcardGothic-Reg-100.vlw");
        bodyFont = loadFont("Arial-BoldMT-36.vlw");
    }
    //===========================================================
    // function to change the level if the player finish any level
    //===========================================================
void levelUp()
    {
        level++;
        chickenSpeed += 5;
        frameCountEasyness -= 1;
        //spawnChicken(level);
    }
    //==========================================================
    // function to genertae a gift in random x and fixed y 
    //==========================================================
void generateRandomGift()
    {
        int giftX = (int)(Math.random() * (width - 100) + 200);
        int giftY = 0;
        gifts.add(new PVector(giftX, giftY));
        giftTranslation.add(new PVector(0, 0));
    }

// =====================
// killing the chickens 
// =====================
void checkKillingChickens(float x, float y, int bulletIndex,int bulletIndex1 , int bulletIndex2 ){
  if(!chicken.isEmpty())
  {
    for(int j = 0; j < chicken.size(); j++)
    {
      ChickenVector toBeKilled = chicken.get(j);
      float chickenHeight = (toBeKilled.clr == 0) ? 81.7699 : 84.7788;
      if(x + 40 > toBeKilled.x && x < toBeKilled.x + 80 && y < toBeKilled.y + chickenHeight / 2 && y > toBeKilled.y)
      {
        chicken.remove(j);
        chickenMeals.add(new PVector(toBeKilled.x, toBeKilled.y));
        chickenMealTranslation.add(new PVector(0, 0));
        killedChickens++;
        if(bulletIndex >=0){
        bullets.remove(bulletIndex);
        }
        if(bulletIndex1 >=0){
        doubleBullet.remove(bulletIndex1);
        doubleBullet2.remove(bulletIndex2);
        }
        
      }
    }
  }
}
//============================================================
// class to draw the chickens
//============================================================

class ChickenVector extends PVector
{
    // c = 0 => blueChicken
    // c = 1 => redChicken
    public int clr;
    public int dir;
    public ChickenVector(int x, int y, int c, int d)
    {
        super(x, y);
        this.clr = c;
        this.dir = d;
    }
    void draw()
    {
        if(this.x >= width - 110 || this.x < 0) this.dir = -this.dir;
        this.x += chickenSpeed * this.dir;
        if(this.clr == 0) shape(blueChicken, this.x, this.y);
        else if(this.clr == 1) shape(redChicken, this.x, this.y);
        if(frameCount % frameCountEasyness == 0)
        {
            int layEgg = Math.round(random(0, 1));
            if(layEgg == 1) eggs.add(new PVector(this.dir == 1 ? this.x + 20 : this.x, this.y + 50));
        }
    }
}
//========================================================
//  function to draw the chickens on the screen
//========================================================
void spawnChicken(int row)
    {
        int col = 4;
        int xMargin = 200;
        int yMargin = 100;
        int x = 100;
        int y = 50;
        // rows
        for(int i = 0; i < row; i++)
        {
            for(int j = 0; j < col; j++)
            {
                chicken.add(new ChickenVector(x + j * xMargin, y + i * yMargin, i % 2 == 0 ? 0 : 1, i % 2 == 0 ? 1 : -1));
            }
        }
    }
    //==========================================================================
    // function to reset the game if the levels ended
    //===========================================================================
void resetGame()
    {
        level = 1;
        chickenSpeed = 5;
        frameCountEasyness = 30;
        bulletSpeed = 10;
        score = 0;
        resultScore = 0;
        attempts = 3;
        chicken.clear();
        eggs.clear();
        bullets.clear();
        doubleBullet.clear();
        doubleBullet2.clear();
        chickenMeals.clear();
        chickenMealTranslation.clear();
        canLevelUp = false;
        onceAtFive = false;
        onceAtThirteen = false;
        killedChickens = 0;
        numberOfGifts = 0;
    }
    //===========================================================
    // function to reset the widow after each level
    //===========================================================
void resetLevel()
    {
        chicken.clear();
        eggs.clear();
        bullets.clear();
        doubleBullet.clear();
        doubleBullet2.clear();
        chickenMeals.clear();
        chickenMealTranslation.clear();
    }
    //==================================================================
    // built in function called if the player clicked on the mouse
    //==================================================================
void mousePressed()
    {
        if(mouseButton == LEFT)
        {
            x = 1;
            // add the start points of of each bullet in arrayList of vectors
            // if the number of the gifts equal 0 or 1
            if(numberOfGifts == 0 || numberOfGifts == 1)
            {
                if((mouseX + 40) <= width && mouseX >= 40 && yd + 40 <= height - shipHeight)
                {
                    if(millis() - time >= 500)
                    {
                        bullets.add(new PVector(mouseX, mouseY));
                    }
                    time = millis();
                }
                if(mouseX <= 40 && yd + 40 <= height - shipHeight)
                {
                    if(millis() - time >= 500)
                    {
                        bullets.add(new PVector(40, mouseY));
                    }
                    time = millis();
                }
                if((xd + 40) >= width && yd + 40 <= height - shipHeight)
                { // to prevent show the bullet outsize the screen
                    if(millis() - time >= 500)
                    {
                        bullets.add(new PVector(width - 40, mouseY));
                        time = millis();
                    }
                }
                if((mouseX + 40) <= width && mouseX >= 40 && yd + 40 > height - shipHeight)
                {
                    if(millis() - time >= 500)
                    {
                        bullets.add(new PVector(mouseX, height - shipHeight));
                    }
                    time = millis();
                }
                if(mouseX <= 40 && yd + 40 > height - shipHeight)
                {
                    if(millis() - time >= 500)
                    {
                        bullets.add(new PVector(40, height - shipHeight));
                    }
                    time = millis();
                }
                if((xd + 40) >= width && yd + 40 >= height - shipHeight)
                { // to prevent show the bullet outsize the screen
                    if(millis() - time >= 500)
                    {
                        bullets.add(new PVector(width - 40, height - shipHeight));
                        time = millis();
                    }
                }
            }
            // increase the speed if numberOfGifts equal one
            if(numberOfGifts == 1)
            {
                bulletSpeed = 15;
            }
            // add the start points of of each bullet in arrayList of vectors
            // if the number of the gifts equal 2 double the bullet and increase the speed
            if(numberOfGifts == 2)
            {
                bulletSpeed = 20;
                // add the start points of of each bullet in arrayList of vectors
                if((mouseX + 40) <= width && mouseX >= 40 && yd + 40 <= height - shipHeight)
                {
                    if(millis() - time >= 500)
                    {
                        doubleBullet2.add(new PVector(mouseX - 10, mouseY));
                        doubleBullet.add(new PVector(mouseX + 10, mouseY));
                    }
                    time = millis();
                }
                if(mouseX <= 40 && yd + 40 <= height - shipHeight)
                {
                    if(millis() - time >= 500)
                    {
                        doubleBullet2.add(new PVector(50, mouseY));
                        doubleBullet.add(new PVector(30, mouseY));
                    }
                    time = millis();
                }
                if((xd + 40) >= width && yd + 40 <= height - shipHeight)
                { // to prevent show the bullet outsize the screen
                    if(millis() - time >= 500)
                    {
                        doubleBullet2.add(new PVector(width - 30, mouseY));
                        doubleBullet.add(new PVector(width - 50, mouseY));
                        time = millis();
                    }
                }
                if((mouseX + 40) <= width && mouseX >= 40 && yd + 40 > height - shipHeight)
                {
                    if(millis() - time >= 500)
                    {
                        doubleBullet2.add(new PVector(mouseX - 10, height - shipHeight));
                        doubleBullet.add(new PVector(mouseX + 10, height - shipHeight));
                    }
                    time = millis();
                }
                if(mouseX <= 40 && yd + 40 > height - shipHeight)
                {
                    if(millis() - time >= 500)
                    {
                        doubleBullet2.add(new PVector(30, height - shipHeight));
                        doubleBullet.add(new PVector(50, height - shipHeight));
                    }
                    time = millis();
                }
                if((xd + 40) >= width && yd + 40 > height - shipHeight)
                {
                    // to prevent show the bullet outsize the screen
                    if(millis() - time >= 500)
                    {
                        doubleBullet2.add(new PVector(width - 30, height - shipHeight));
                        doubleBullet.add(new PVector(width - 50, height - shipHeight));
                        time = millis();
                    }
                }
            }
        }
    }
    //==================================================================
    // built in function called if the player clicked on the keyboard
    //==================================================================
void keyPressed()
{
    if(key == 'A' || key == 'a' && xd >= 40)
    {
        xd = xd - shipSpeed;
        mouseX = xd;
    }
    else if(key == 'D' || key == 'd' && xd <= width - 40)
    {
        xd = xd + shipSpeed;
        mouseX = xd;
    }
    else if(key == 'W' || key == 'w' && yd >= 40)
    {
        yd = yd - shipSpeed;
        mouseY = yd;
    }
    else if(key == 'S' || key == 's' && yd <= height - shipHeight)
    {
        yd = yd + shipSpeed;
        mouseY = yd;
    }
    else if(key == ' ')
    {
        // add the start points of of each bullet in arrayList of vectors
        // if the number of the gifts equal 0 or 1
        if(numberOfGifts == 0 || numberOfGifts == 1)
        {
            if(millis() - time >= 150)
            {
                if((xd + 40) <= width && xd >= 40 && yd + 40 <= height - shipHeight)
                {
                    bullets.add(new PVector(xd, mouseY));
                }
                if(xd <= 40 && yd + 40 <= height - shipHeight)
                {
                    bullets.add(new PVector(40, mouseY));
                }
                if((xd + 40) >= width && yd + 40 <= height - shipHeight)
                { // to prevent show the bullet outsize the screen
                    bullets.add(new PVector(width - 40, mouseY));
                }
                if((mouseX + 40) <= width && xd >= 40 && yd + 40 > height - shipHeight)
                {
                    bullets.add(new PVector(xd, height - shipHeight));
                }
                if(mouseX <= 40 && yd + 40 > height - shipHeight)
                {
                    bullets.add(new PVector(40, height - shipHeight));
                }
                if((mouseX + 40) >= width && yd + 40 > height - shipHeight)
                {
                    bullets.add(new PVector(width - 40, height - shipHeight));
                }
                time = millis();
            }
            // increase the speed of the bullet if numberOfGifts equal one
            if(numberOfGifts == 1)
            {
                bulletSpeed = 15;
            }
        }
        // add the start points of of each bullet in arrayList of vectors
        // if the number of the gifts equal 2 double the bullet and increase the speed
        if(numberOfGifts == 2)
        {
            bulletSpeed = 20;
            if(millis() - time >= 150)
            {
                if((xd + 40) <= width && xd >= 40 && yd + 40 <= height - shipHeight)
                {
                    doubleBullet2.add(new PVector(xd - 10, mouseY));
                    doubleBullet.add(new PVector(xd + 10, mouseY));
                }
                if(xd <= 40 && yd + 40 <= height - shipHeight)
                {
                    doubleBullet2.add(new PVector(30, mouseY));
                    doubleBullet.add(new PVector(50, mouseY));
                }
                if((xd + 40) >= width && yd + 40 <= height - shipHeight)
                { // to prevent show the bullet outsize the screen
                    doubleBullet2.add(new PVector(width - 30, mouseY));
                    doubleBullet.add(new PVector(width - 50, mouseY));
                }
                if((mouseX + 40) <= width && xd >= 40 && yd + 40 > height - shipHeight)
                {
                    doubleBullet2.add(new PVector(xd - 10, height - shipHeight));
                    doubleBullet.add(new PVector(xd + 10, height - shipHeight));
                }
                if(mouseX <= 40 && yd + 40 > height - shipHeight)
                {
                    doubleBullet2.add(new PVector(30, height - shipHeight));
                    doubleBullet.add(new PVector(50, height - shipHeight));
                }
                if((mouseX + 40) >= width && yd + 40 >= height - shipHeight)
                {
                    doubleBullet2.add(new PVector(width - 30, height - shipHeight));
                    doubleBullet.add(new PVector(width - 50, height - shipHeight));
                }
                time = millis();
            }
        }
    }
}
void draw()
{
    //=================================================================================
    // if the game started draw a start page that inculed the instruction of the game
    //=================================================================================
    if(gameStart)
    {
        // Draw the background for the game start
        image(background, 0, 0, width, height);
        // sun
        pushMatrix();
        shapeMode(CENTER);
        translate(width, 0);
        rotate(sunAngle);
        shape(sun, 0, 0);
        sunAngle += 0.009;
        // planet 1 around the sun
        rotate(planet1Angle);
        shape(planet1, 2 * width / 3, 0, 100, 100);
        planet1Angle += 0.001;
        // planet 2 around the sun
        rotate(planet2Angle);
        shape(planet2, 0, 2 * height / 3, 150, 150);
        planet2Angle += 0.001;
        popMatrix();
        // earth
        pushMatrix();
        shapeMode(CENTER);
        translate(0, height);
        rotate(earthAngle);
        shape(earth, 0, 0);
        earthAngle += 0.01;
        // moon around the earth
        rotate(moonAngle);
        shape(moon, 0, -450);
        moonAngle += 0.01;
        popMatrix();
        fill(255, 255, 255);
        stroke(151, 223, 252);
        textFont(titleFont);
        textSize(64);
        text("CHICKEN INVADERS", width / 2 - 300, height / 2 -100);
        fill(240, 200, 8);
        textFont(bodyFont);
        textSize(24);
        text("Game controls: You can move the spaceship with mouse, and fire bullets"
        + "\nwith left click. Or use the keyboard to move up with \"W\" key, down with \"S\""
        + "\nkey, left with \"A\" key, right with \"D\" key, and fire bullets with space key \" \"."
        + "\nTo exit the game press backspace key at any time.", width / 2 - 420, height / 2);
        fill(255, 255, 255);
        text("Press any key to start the game!", width / 2 - 180, height / 2 + 200);
        // =======================================================
        // if the player pressed any key lead him to start playing
        //========================================================
        if(keyPressed)
        {
            resetGame();
            gameStart = false;
            gameContinue = true;
            canLevelUp = true;
        }
    }
    //=============================================================
    // if the player finished all levels lead him to the end page
    //=============================================================
    else if(gameEnd)
    {
        // Draw the background for the game end
        image(background, 0, 0, width, height);
        fill(255, 255, 255);
        stroke(151, 223, 252);
        textFont(titleFont);
        text("GAME END", width / 2 - 239, height / 2);
        fill(240, 200, 8);
        textFont(bodyFont);
        text("Your final score is: " + resultScore, width / 2 - 160, height / 2 + 100);
        fill(255, 255, 255);
        textSize(36);
        text("Press any key to go to start", width / 2 - 235, height / 2 + 200);
        if(keyPressed)
        {
            resetGame();
            gameEnd = false;
            gameStart = true;
        }
    }
    else if(gameContinue)
    {
        resetLevel();
        // Draw the background for the game end
        image(background, 0, 0, width, height);
        fill(255, 255, 255);
        stroke(151, 223, 252);
        textFont(titleFont);
        text("level", width / 2 - 191, height / 2);
        fill(240, 200, 8);
        text(level, width / 2 + 141, height / 2);
        fill(240, 200, 8);
        textFont(bodyFont);
        text("Your current score is: " + resultScore, width / 2 - 185, height / 2 + 100);
        fill(255, 255, 255);
        text("Press any key to continue", width / 2 - 222, height / 2 + 200);
        if(keyPressed)
        {
            if (key == BACKSPACE) {
                gameStart = true;
            } else {
                gameContinue = false;
                spawnChicken(level);
                canLevelUp = true;
            }
        }
    }
    //=============================================
    // if the user start play
    //=============================================
    else
    {
        // Draw the background for the game
        image(background, 0, 0, width, height);
        // Score details
        shape(heart, 20, 20, 30, 30);
        textSize(26);
        text(attempts+1, 70, 45);
        shape(chickensScore, 120, 15, 40, 40);
        text(score, 170, 45);
        fill(255, 255, 255);
        textSize(28);
        text("Level:  ", 220, 45);
        fill(240, 200, 8);
        textSize(28);
        text(level, 320, 45);
        shapeMode(CENTER);
        //=======================================================
        // Work on show bullets
        // ======================================================
        if(frameCount % 5 == 0)
        {
            if(x == 1) // if he pressed on click left much time the number of bullets incressed
            {
                // add the start points of of each bullet in arrayList of vectors
                // if the number of the gifts equal 0 or 1
                if(numberOfGifts == 0 || numberOfGifts == 1)
                {
                    if((mouseX + 40) <= width && xd >= 40 && yd + 40 <= height - shipHeight)
                    {
                        bullets.add(new PVector(xd, mouseY));
                    }
                    if(mouseX <= 40 && yd + 40 <= height - shipHeight)
                    {
                        bullets.add(new PVector(40, mouseY));
                    }
                    if((mouseX + 40) >= width && yd + 40 <= height - shipHeight)
                    {
                        bullets.add(new PVector(width - 40, mouseY));
                    }
                    if((mouseX + 40) <= width && xd >= 40 && yd + 40 > height - shipHeight)
                    {
                        bullets.add(new PVector(xd, height - shipHeight));
                    }
                    if(mouseX <= 40 && yd + 40 > height - shipHeight)
                    {
                        bullets.add(new PVector(40, height - shipHeight));
                    }
                    if((mouseX + 40) >= width && yd + 40 >= height - shipHeight)
                    {
                        bullets.add(new PVector(width - 40, height - shipHeight));
                    }
                }
                // increase the speed of the bullet if the numberOfGifts equal one
                if(numberOfGifts == 1)
                {
                    bulletSpeed = 15;
                }
                // add the start points of of each bullet in arrayList of vectors
                // if the number of the gifts equal 2 double the bullet and increase the speed
                if(numberOfGifts == 2)
                {
                    bulletSpeed = 20;
                    if((mouseX + 40) <= width && xd >= 40 && yd + 40 <= height - shipHeight)
                    {
                        doubleBullet2.add(new PVector(xd - 10, mouseY));
                        doubleBullet.add(new PVector(xd + 10, mouseY));
                    }
                    if(mouseX <= 40 && yd + 40 <= height - shipHeight)
                    {
                        doubleBullet2.add(new PVector(30, mouseY));
                        doubleBullet.add(new PVector(50, mouseY));
                    }
                    if((mouseX + 40) >= width && yd + 40 <= height - shipHeight)
                    {
                        doubleBullet2.add(new PVector(width - 30, mouseY));
                        doubleBullet.add(new PVector(width - 50, mouseY));
                    }
                    if((mouseX + 40) <= width && xd >= 40 && yd + 40 > height - shipHeight)
                    {
                        doubleBullet2.add(new PVector(xd - 10, height - shipHeight));
                        doubleBullet.add(new PVector(xd + 10, height - shipHeight));
                    }
                    if(mouseX <= 40 && yd + 40 > height - shipHeight)
                    {
                        doubleBullet2.add(new PVector(30, height - shipHeight));
                        doubleBullet.add(new PVector(50, height - shipHeight));
                    }
                    if((mouseX + 40) >= width && yd + 40 >= height - shipHeight)
                    {
                        doubleBullet2.add(new PVector(width - 30, height - shipHeight));
                        doubleBullet.add(new PVector(width - 50, height - shipHeight));
                    }
                }
            }
        }
        // reset the flage x if no pressing on the mouse
        if(mousePressed == false)
        {
            x = 0;
        }
        // drawing the bullets that sorted in the bullets array list 
        for(int i = 0; i < bullets.size(); i++)
        {
            // get start points of each bullet
            PVector b = bullets.get(i);
            // move and show  bullets
            b.y -= bulletSpeed;
            shape(bullet, b.x, b.y, 50, 50);
            // remove the bullet if reach to the end of the screen
            if(!bullets.isEmpty())
            {
                if(b.y < 1)
                {
                    bullets.remove(i);
                }
            }
            checkKillingChickens(b.x,b.y,i,-1,-1);
        }
        // drawing double bullet if the gift equal 2
        if(numberOfGifts == 2)
        {
            for(int i = 0; i < doubleBullet.size(); i++)
            {
                // get start points of each bullet
                PVector b = doubleBullet2.get(i);
                PVector b1 = doubleBullet.get(i);
                // move and show  bullets
                b.y -= bulletSpeed;
                b1.y -= bulletSpeed;
                shape(bullet, b.x, b.y, 50, 50);
                shape(bullet, b1.x, b1.y, 50, 50);
                // remove the bullet if reach to the end of the screen
                if(!doubleBullet.isEmpty())
                {
                    if(b.y < 1)
                    {
                        doubleBullet2.remove(i);
                        doubleBullet.remove(i);
                    }
                }
                checkKillingChickens(b.x,b.y,-1,i,i);
            }
        }
        // ==============================================
        // chicken meals translation
        // ==============================================
        for(int i = 0; i < chickenMeals.size(); i++)
        {
            chickenMealTranslation.get(i).y += chickenMealSpeed;
            pushMatrix();
            translate(chickenMealTranslation.get(i).x, chickenMealTranslation.get(i).y);
            shape(chickenMeal, chickenMeals.get(i).x, chickenMeals.get(i).y, chickenMealWidth, chickenMealHeight);
            // if the rocket catched the meal, increase the score
            float xPos = chickenMeals.get(i).x;
            float yPos = chickenMeals.get(i).y + chickenMealTranslation.get(i).y;
            if(yPos >= height - 70)
            {
                chickenMeals.remove(i);
                chickenMealTranslation.remove(i);
            }
            else
            {
                if(xPos < xd + spaceshipHeight - 10 && xPos + chickenMealWidth - 10 > xd && yPos + chickenMealHeight - 10 > yd && yPos < yd + spaceshipHeight - 10)
                {
                    score++;
                    chickenMeals.remove(i);
                    chickenMealTranslation.remove(i);
                }
            }
            popMatrix();
        }
        // ==============================================
        // gifts workflow
        // ==============================================
        if(killedChickens == 5 && !onceAtFive)
        {
            generateRandomGift();
            onceAtFive = true;
        }
        if(killedChickens == 13 && !onceAtThirteen)
        {
            generateRandomGift();
            onceAtThirteen = true;
        }
        for(int i = 0; i < gifts.size(); i++)
        {
            giftTranslation.get(i).y += giftSpeed;
            pushMatrix();
            translate(giftTranslation.get(i).x, giftTranslation.get(i).y);
            shape(gift, gifts.get(i).x, gifts.get(i).y, giftWidth, giftHeight);
            // if the rocket catched the meal, increase the score
            float xPos = gifts.get(i).x;
            float yPos = gifts.get(i).y + giftTranslation.get(i).y;
            if(yPos >= height - 70)
            {
                gifts.remove(i);
                giftTranslation.remove(i);
            }
            else
            {
                if(xPos < xd + spaceshipHeight - 10 && xPos + giftWidth - 10 > xd && yPos + giftHeight - 10 > yd && yPos < yd + spaceshipHeight - 10)
                {
                    numberOfGifts++;
                    gifts.remove(i);
                    giftTranslation.remove(i);
                }
            }
            popMatrix();
        }
        //==================================================================================
        // Work on spaceship
        //==================================================================================
        xd = mouseX;
        yd = mouseY;
        shapeMode(CENTER);
        //if((xd + 80) <= width && xd > 0 && yd>0 && yd+80 <=height)
        //{
        //    shape(spaceship, xd, yd, 80, 80);
        //}
        if(xd <= 40 && yd + 40 <= height - shipHeight)
        {
            xd = 40;
        }
        if(yd <= 40 && (xd + 40) <= width)
        {
            yd = 40;
        }
        if(xd + 40 >= width && yd + 40 <= height - shipHeight && yd >= 40)
        { // to prevent show the spaceship outsize the screen
            xd = width - 40;
        }
        if(yd + 40 >= height - shipHeight && (xd + 40) <= width)
        {
            yd = height - shipHeight;
        }
        if(yd < 40 && (xd + 40) >= width)
        {
            xd = width - 40;
            yd = 40;
        }
        if(yd <= 40 && xd <= 40)
        {
            xd = 40;
            yd = 40;
        }
        if(yd + 40 >= height - shipHeight && (xd + 40) >= width)
        {
            xd = width - 40;
            yd = height - shipHeight;
        }
        if(yd + 40 >= height - shipHeight && xd <= 40)
        {
            xd = 40;
            yd = height - shipHeight;
        }
        shape(spaceship, xd, yd, spaceshipWidth, spaceshipHeight);
        //=============================================================================
        // Move chicken
        //=============================================================================
        shapeMode(CORNER);
        for(int i = 0; i < chicken.size(); i++)
        {
            ChickenVector c = chicken.get(i);
            c.draw();
            // if the rocket hit the chicken.
            if(xd + 20 > c.x && xd < c.x + 120 && yd < c.y + 120 && yd + 20 > c.y)
            {
                chicken.remove(i);
                if(attempts > 0) attempts--;
                else
                {
                    gameEnd = true;
                    resultScore = score;
                    break;
                }
            }
        }
        // Egg spawning
        for(int i = 0; i < eggs.size(); i++)
        {
            PVector e = eggs.get(i);
            if(e.y >= height - 70)
            {
                shape(crackedEgg, e.x, e.y, 40, 40);
                if(millis() - timer >= 500)
                {
                    eggs.remove(i);
                    timer = millis();
                }
            }
            else
            {
                e.y += eggSpeed;
                shape(egg, e.x, e.y, 26, 26);
                // losing attempts
                if(e.x + 46 > xd && e.x < xd + 20 && e.y + 46 > yd && e.y < yd + 20)
                {
                    shape(crackedEgg, e.x, e.y, 40, 40);
                    eggs.remove(i);
                    if(attempts > 0) attempts--;
                    else
                    {
                        gameEnd = true;
                        resultScore = score;
                        break;
                    }
                }
            }
        }
        // end the level
        if(chicken.isEmpty() && chickenMeals.isEmpty() && canLevelUp)
        {
            if(level <= maxLevel)
            {
                levelUp();
                gameContinue = true;
            }
            else
            {
                gameEnd = true;
            }
            resultScore = score;
        }
        if (keyPressed) {
          if (key == BACKSPACE) {
            gameStart = true;
          }
        }
    }
}
