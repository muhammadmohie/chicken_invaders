
//Fonts 
String title = "CHICKEN INVADERS";
PFont titleFont;
PFont bodyFont;

// Images
PImage background;

// Shapes
PShape blueChicken;
PShape redChicken;
PShape chickenMeal;
PShape egg;
PShape crackedEgg;
PShape spaceship;
PShape bullet;
PShape heart;
PShape chickensScore;

// Collections and variables
ArrayList < PVector > bullets = new ArrayList < PVector > ();
ArrayList < PVector > eggs = new ArrayList < PVector > ();
ArrayList < ChickenVector > chicken = new ArrayList < ChickenVector > ();
float speed = 30;
float y = 740;
int x = 0;
int timer = 4000;
int attempts = 5;
int score = 0;
int frameCountEasyness = 15;
int chickenSpeed = 20;
int eggSpeed = 20;
boolean gameStart = true;
boolean gameEnd = false;
boolean drawOnce = true;

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

    void draw() {
        if(this.x >= width - 110 || this.x < 0) this.dir = -this.dir;
        this.x += chickenSpeed * this.dir;
        if(this.clr == 0) shape(blueChicken, this.x, this.y);
        else if(this.clr == 1) shape(redChicken, this.x, this.y);
        if(frameCount % frameCountEasyness == 0)
        {
            eggs.add(new PVector(this.dir == 1 ? this.x + 20 : this.x, this.y + 50));
        }
    }
}

void spawnLevel1Chicken() {
    int xMargin = 400;
    int yMargin = 150;
    int x = 100;
    int y = 50;
    // rows
    for(int i = 0; i < 2; i++) {
        for(int j = 0; j < 2; j++) {
            chicken.add(new ChickenVector(x + j * xMargin, y + i * yMargin, 1, 1));
        }
    }
}

void reset(){
  score = 0;
  attempts = 5;
  chicken.clear();
  eggs.clear();
  bullets.clear();
}

void setup()
{
    size(1680, 900);
    surface.setResizable(true);
    
    // Loading Images
    background = loadImage("background.jpg");
    
    // Loading Shapes
    blueChicken = loadShape("blue-chicken.svg");
    redChicken = loadShape("red-chicken.svg");
    chickenMeal = loadShape("chicken-meal.svg");
    egg = loadShape("egg.svg");
    crackedEgg = loadShape("cracked-egg.svg");
    spaceship = loadShape("spaceship.svg");
    bullet = loadShape("bullet.svg");
    heart = loadShape("heart.svg");
    chickensScore = loadShape("score.svg");

    // Loading fonts
    titleFont = loadFont("ShowcardGothic-Reg-100.vlw");
    bodyFont = loadFont("SakkalMajalla-Bold-48.vlw");

}

void mousePressed()
{
    if(mouseButton == LEFT)
    {
        y = 740;
        x = 1;
        // add the start points of of each bullet in arrayList of vectors
        if((mouseX + 80) <= width && (mouseY + 80) <= height)
        {
            bullets.add(new PVector(mouseX + 12, y));
        }
        else
        { // to prevent show the bullet outsize the screen
            bullets.add(new PVector(width - 67, y));
        }
    }
}

void draw()
{
  if(gameStart) {
    
    // Draw the background for the game start
    image(background, 0, 0, width, height);
    
    fill(255,255,255);
    stroke(151, 223, 252);
    textFont(titleFont);
    text(title, width/2-458,height/2);

    fill(240, 200, 8);
    textFont(bodyFont);
    text("Press any key to start the game!", width/2-246,height/2+100);
    
    if(keyPressed || mousePressed){
      gameStart = false;
    }
  } else if(gameEnd) {
    
    // Draw the background for the game end
    image(background, 0, 0, width, height);
    fill(255,255,255);
    stroke(151, 223, 252);
    textFont(titleFont);
    text(title, width/2-458,height/2);

    fill(240, 200, 8);
    textFont(bodyFont);
    text("Your score is: " + score, width/2-114,height/2+100);
    
    fill(255, 255, 255);
    text("Press any key to play again", width/2-246,height/2+200);
    
    if(keyPressed || mousePressed){
      gameStart = false;
      gameEnd = false;
      attempts = 5;
      score = 0;
    }
    
  } else {
    if(drawOnce){
      spawnLevel1Chicken();
      drawOnce = false;
    }
    // Draw the background for the game
    image(background, 0, 0, width, height);
    
    // Score details
    shape(heart, 20, 20, 30, 30);
    textSize(36);
    text(attempts, 70, 45);
    shape(chickensScore, 120, 15, 40, 40);
    text(score, 170, 45);
    
    // Work on show bullets
    if(frameCount % 3 == 0)
    {
        if(x == 1) // if he pressed on click left much time the number of bullets incressed
        {
            bullets.add(new PVector(mouseX + 12, y));
        }
    }
    if(mousePressed == false)
    {
        x = 0;
    }
    
    for(int i = 0; i < bullets.size(); i++)
    {
        // get start points of each bullet
        PVector b = bullets.get(i);
        // move and show  bullets
        b.y -= speed;
        shape(bullet, b.x, b.y, 50, 50);
        // remove the bullet if reach to the end of the screen
        if(!bullets.isEmpty())
        {
            if(b.y < 1)
            {
                bullets.remove(0);
            }
        }
        // killing the chickens
        if(!chicken.isEmpty())
        {
            for(int j = 0; j < chicken.size(); j++)
            {
                ChickenVector toBeKilled = chicken.get(j);
                float chickenHeight = (toBeKilled.clr == 0) ? 81.7699 : 84.7788;
                if(b.x + 40 > toBeKilled.x && b.x < toBeKilled.x + 80 && b.y < toBeKilled.y + chickenHeight / 2 && b.y > toBeKilled.y)
                {
                    chicken.remove(j);
                    score++;
                }
            }
            if(chicken.isEmpty()){
              reset();
            }
            
        }
    }
    // Work on spaceship
    if((mouseX + 80) <= width)
    {
        shape(spaceship, mouseX, height - 160, 80, 80);
    }
    else
    { // to prevent show the spaceship outsize the screen
        shape(spaceship, width - 80, height - 160, 80, 80);
    }

    // Move chicken
    for(int i = 0; i < chicken.size(); i++)
    {
        ChickenVector c = chicken.get(i);
        c.draw();
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
            if((mouseX + 80) <= width)
            {
                if(e.x + 26 > mouseX && e.x < mouseX + 80 && e.y + 26 > height - 160 && e.y < height - 80)
                {
                    shape(crackedEgg, e.x, e.y, 40, 40);
                    if(millis() - timer >= 500)
                    {
                        eggs.remove(i);
                        timer = millis();
                    }
                    if(attempts != 0) attempts--;
                    else{
                      reset();
                    }
                }
            }
            else
            {
                if(e.x + 26 > width - 80 && e.x < width + 80 && e.y + 26 > height - 160 && e.y < height - 80)
                {
                    shape(crackedEgg, e.x, e.y, 40, 40);
                    if(millis() - timer >= 500)
                    {
                        eggs.remove(i);
                        timer = millis();
                    }
                    if(attempts != 0) attempts--;
                    else reset();
                }
            }
        }
    }
    }
}
