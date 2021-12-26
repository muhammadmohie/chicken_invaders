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
int resultScore = 0;
int frameCountEasyness = 20;
int chickenSpeed = 10;
int eggSpeed = 20;
int chickenMealSpeed = 30;

int time = 0;
int xd;
boolean gameStart = true;
boolean gameEnd = false;
boolean drawOnce = true;
int level = 1;
int maxLevel = 2;

void levelUp() {
    level++;
    chickenSpeed += 5;
    frameCountEasyness -= 5;
    //spawnChicken(level);
}

void levelDown() {
    level--;
    chickenSpeed -= 5;
    frameCountEasyness += 5;
    //spawnChicken(level);
}

ArrayList < PVector > chickenMeals = new ArrayList < PVector > ();
ArrayList < PVector > chickenMealTranslation = new ArrayList < PVector > ();

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
            if (layEgg == 1) eggs.add(new PVector(this.dir == 1 ? this.x + 20 : this.x, this.y + 50));
            else System.out.println("Chicken deceided not to lay an egg");
        }
    }
}
void spawnChicken(int row)
{
    int col = 5;
    int xMargin = 300;
    int yMargin = 100;
    int x = 100;
    int y = 50;
    // rows
    for(int i = 0; i < row; i++)
    {
        for(int j = 0; j < col; j++)
        {
            chicken.add(new ChickenVector(x + j * xMargin, y + i * yMargin, i % 2 == 0 ? 0 : 1 , i % 2 == 0 ? 1 : -1));
        }
    }
}
void reset()
{
    score = 0;
    attempts = 5;
    chicken.clear();
    eggs.clear();
    bullets.clear();
    chickenMeals.clear();
    chickenMealTranslation.clear();
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
        if((mouseX + 80) <= width)
        {
            if(millis() - time >= 500)
            {
                bullets.add(new PVector(mouseX + 12, y));
            }
            time = millis();
        }
        else if(mouseX <= 80)
        {
            bullets.add(new PVector(40, y));
        }
        else
        { // to prevent show the bullet outsize the screen
            if(millis() - time >= 500)
            {
                bullets.add(new PVector(width - 67, y));
                time = millis();
            }
        }
    }
}
void keyPressed()
{
    //if(key == CODED){
    if(key == 'A' || key == 'a')
    {
        xd = xd - 20;
        mouseX = xd;
    }
    else if(key == 'D' || key == 'd')
    {
        xd = xd + 20;
        mouseX = xd;
    }
    else if(key == ' ')
    {
        y = 740;
        // add the start points of of each bullet in arrayList of vectors
        if(millis() - time >= 150)
        {
            if((xd + 80) <= width && xd > 0)
            {
                bullets.add(new PVector(xd + 12, y));
            }
            if(xd <= 0)
            {
                bullets.add(new PVector(17, y));
            }
            if((xd + 80) >= width)
            { // to prevent show the bullet outsize the screen
                bullets.add(new PVector(width - 67, y));
            }

            time = millis();
        }
    }
}
void draw()
{
    System.out.println("# of chicken = " + chicken.size());
    if(gameStart)
    {
        // Draw the background for the game start
        image(background, 0, 0, width, height);
        fill(255, 255, 255);
        stroke(151, 223, 252);
        textFont(titleFont);
        text(title, width / 2 - 458, height / 2);
        fill(240, 200, 8);
        textFont(bodyFont);
        text("Press any key to start the game!", width / 2 - 246, height / 2 + 100);
        if(keyPressed || mousePressed)
        {
            gameStart = false;
        }
    }
    else if(gameEnd)
    {
        //reset();
        // Draw the background for the game end
        image(background, 0, 0, width, height);
        fill(255, 255, 255);
        stroke(151, 223, 252);
        textFont(titleFont);
        text(title, width / 2 - 458, height / 2);
        fill(240, 200, 8);
        textFont(bodyFont);
        text("Your score is: " + resultScore, width / 2 - 114, height / 2 + 100);
        fill(255, 255, 255);
        text("Press any key to play again", width / 2 - 246, height / 2 + 200);
        if (level > maxLevel) {
            text("You have reached the end of the game",width / 2 - 144, 200);
            System.out.println("Reached max level here");
        }
        if(keyPressed || mousePressed)
        {
            int tempScore = score;
            System.out.println("Level = " + level);
            System.out.println("attempts = " + attempts);
            gameEnd = false;
            if (level <= maxLevel) {
                
                // Try same level
                if (attempts <= 0) {
                    System.out.println("Retrying level");
                    //spawnChicken(level);
                }
                // Level up
                else {
                    System.out.println("Level up");
                    levelUp();
                }
                reset();
                score = tempScore;
            }
            else {
                level = 1;
                chickenSpeed = 10;
                frameCountEasyness = 20;
                reset();
            }

            spawnChicken(level);
        }
    }
    else
    {
        if(drawOnce)
        {
            spawnChicken(level);
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
        text("Level   " + (level), 20, 100);
        // Work on show bullets
        if(frameCount % 3 == 0)
        {
            if(x == 1) // if he pressed on click left much time the number of bullets incressed
            {
                if((mouseX + 80) <= width && xd > 0)
                {
                    bullets.add(new PVector(xd + 12, y));
                }
                if(mouseX <= 0)
                {
                    bullets.add(new PVector(17, y));
                }
                if((mouseX + 80) >= width)
                {
                    bullets.add(new PVector(width - 67, y));
                }
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
                        chickenMeals.add(new PVector(toBeKilled.x , toBeKilled.y));
                        chickenMealTranslation.add(new PVector(0, 0));
                        //score++;
                    }
                }
          }
        }
        if(chicken.isEmpty() && chickenMeals.isEmpty())
        {
          gameEnd = true;
          resultScore = score;
        }
          
        // chicken meals translation
        for(int i=0;i<chickenMeals.size();i++){
          chickenMealTranslation.get(i).y += chickenMealSpeed;
          pushMatrix();
          translate(chickenMealTranslation.get(i).x ,chickenMealTranslation.get(i).y );
          shape(chickenMeal, chickenMeals.get(i).x , chickenMeals.get(i).y);
          // if the rocket catched the meal increase the score
          float xPos = chickenMeals.get(i).x;
          float yPos = chickenMeals.get(i).y + chickenMealTranslation.get(i).y;
          if(yPos > height){
            chickenMeals.remove(i);
            chickenMealTranslation.remove(i);
          }
          if((mouseX + 80) <= width)
          {
            if(xPos + 80 > mouseX && xPos < mouseX + 80 && yPos + 80 > height - 160 && yPos < height - 80)
            {
              chickenMeals.remove(i);
              chickenMealTranslation.remove(i);
              score++;
            }
          }
          else
          {
            if(xPos + 80 > width - 80 && xPos < width + 80 && yPos + 80 > height - 160 && yPos < height - 80)
            {
              chickenMeals.remove(i);
              chickenMealTranslation.remove(i);
              score++;
            }
          }

          popMatrix();
        }
        // Work on spaceship
        xd = mouseX;
        if((xd + 80) <= width && xd > 0)
        {
            shape(spaceship, xd, height - 160, 80, 80);
        }
        if(xd <= 0)
        {
            shape(spaceship, 0, height - 160, 80, 80);
        }
        if(xd + 80 >= width)
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
                        eggs.remove(i);
                        if(attempts != 0) attempts--;
                        else
                        {
                            gameEnd = true;
                            resultScore = score;
                            break;
                        }
                    }
                }
                else
                {
                    if(e.x + 26 > width - 80 && e.x < width + 80 && e.y + 26 > height - 160 && e.y < height - 80)
                    {
                        shape(crackedEgg, e.x, e.y, 40, 40);
                        eggs.remove(i);
                        if(attempts != 0) attempts--;
                        else {
                            gameEnd = true;
                            resultScore = score;
                            break;
                        }
                    }
                }
            }
        }
    }
}
