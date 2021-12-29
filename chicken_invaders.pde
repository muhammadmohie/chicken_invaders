//Fonts 
PFont titleFont;
PFont bodyFont;
// Images
PImage background;
// Shapes
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
// Collections and variables
ArrayList < PVector > bullets = new ArrayList < PVector > ();
ArrayList < PVector > eggs = new ArrayList < PVector > ();
ArrayList < ChickenVector > chicken = new ArrayList < ChickenVector > ();
ArrayList < PVector > chickenMeals = new ArrayList < PVector > ();
ArrayList < PVector > chickenMealTranslation = new ArrayList < PVector > ();
float bulletSpeed = 20;
int x = 0;
int timer = 4000;
int attempts = 5;
int score = 0;
int resultScore = 0;
int frameCountEasyness = 20;
int chickenSpeed = 10;
int eggSpeed = 20;
int chickenMealSpeed = 15;
int time = 0;
int xd;
int yd;
int shipHeight = 100;
int shipSpeed = 20;
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

void setup()
{
    size(1680, 900);
    surface.setResizable(true);
    // Loading Images
    background = loadImage("background.jpg");
    // Loading Shapes
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
    // Loading fonts
    titleFont = loadFont("ShowcardGothic-Reg-100.vlw");
    bodyFont = loadFont("Arial-BoldMT-36.vlw");
}
void levelUp()
{
    level++;
    chickenSpeed += 5;
    frameCountEasyness -= 5;
    //spawnChicken(level);
}
void levelDown()
{
    level--;
    chickenSpeed -= 5;
    frameCountEasyness += 5;
    //spawnChicken(level);
}

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
            chicken.add(new ChickenVector(x + j * xMargin, y + i * yMargin, i % 2 == 0 ? 0 : 1, i % 2 == 0 ? 1 : -1));
        }
    }
}
void resetGame()
{
    level = 1;
    chickenSpeed = 10;
    frameCountEasyness = 20;
    score = 0;
    resultScore = 0;
    attempts = 5;
    chicken.clear();
    eggs.clear();
    bullets.clear();
    chickenMeals.clear();
    chickenMealTranslation.clear();
    canLevelUp = false;
}
void resetLevel()
{
    chicken.clear();
    eggs.clear();
    bullets.clear();
    chickenMeals.clear();
    chickenMealTranslation.clear();
}
void mousePressed()
{
    if(mouseButton == LEFT)
    {
        //y = 740;
        x = 1;
        // add the start points of of each bullet in arrayList of vectors
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
        if((xd + 40) >= width && yd + 40 > height - shipHeight)
        { // to prevent show the bullet outsize the screen
            if(millis() - time >= 500)
            {
                bullets.add(new PVector(width - 40, height - shipHeight));
                time = millis();
            }
        }
    }
}
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
        //y = 740;
        // add the start points of of each bullet in arrayList of vectors
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
    }
}
void draw()
{
    System.out.println("# of chicken = " + chicken.size());
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
        shape(planet1, 2*width/3, 0, 100, 100);
        planet1Angle += 0.001;
        // planet 2 around the sun
        rotate(planet2Angle);
        shape(planet2, 0, 2*height/3, 150, 150);
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
        text("CHICKEN INVADERS", width / 2 - 458, height / 2);
        fill(240, 200, 8);
        textFont(bodyFont);
        text("Press any key to start the game!", width / 2 - 246, height / 2 + 100);
        if(keyPressed)
        {
            gameStart = false;
            gameContinue = true;
            canLevelUp = true;
        }
    }
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
        text(level, width / 2 + 141 , height / 2);
        fill(240, 200, 8);
        textFont(bodyFont);
        text("Your current score is: " + resultScore, width / 2 - 185, height / 2 + 100);
        fill(255, 255, 255);
        text("Press any key to continue", width / 2 - 222, height / 2 + 200);
        if(keyPressed)
        {
            gameContinue = false;
            spawnChicken(level);
            canLevelUp = true;
        }
    }
    else
    {
        // Draw the background for the game
        image(background, 0, 0, width, height);
        // Score details
        shape(heart, 20, 20, 30, 30);
        textSize(26);
        text(attempts, 70, 45);
        shape(chickensScore, 120, 15, 40, 40);
        text(score, 170, 45);
        fill(255, 255, 255);
        textSize(28);
        text("Level:  ", 220, 45);
        fill(240, 200, 8);
        textSize(28);
        text(level, 320, 45);
        shapeMode(CENTER);
        // Work on show bullets
        if(frameCount % 3 == 0)
        {
            if(x == 1) // if he pressed on click left much time the number of bullets incressed
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
                if((mouseX + 40) >= width && yd + 40 > height - shipHeight)
                {
                    bullets.add(new PVector(width - 40, height - shipHeight));
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
            b.y -= bulletSpeed;
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
                        chickenMeals.add(new PVector(toBeKilled.x, toBeKilled.y));
                        chickenMealTranslation.add(new PVector(0, 0));
                    }
                }
            }
        }

        // chicken meals translation
        for(int i = 0; i < chickenMeals.size(); i++)
        {
            chickenMealTranslation.get(i).y += chickenMealSpeed;
            pushMatrix();
            translate(chickenMealTranslation.get(i).x, chickenMealTranslation.get(i).y);
            shape(chickenMeal, chickenMeals.get(i).x, chickenMeals.get(i).y, 80, 80);
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
                if(xPos < xd + 80 && xPos + 50 > xd && yPos + 50 > yd && yPos < yd + 80)
                {
                    score++;
                    chickenMeals.remove(i);
                    chickenMealTranslation.remove(i);
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
        if(yd + 40 >= height && (xd + 40) >= width)
        {
            xd = width - 40;
            yd = height - shipHeight;
        }
        if(yd + 40 >= height - shipHeight && xd <= 40)
        {
            xd = 40;
            yd = height - shipHeight;
        }
        shape(spaceship, xd, yd, 80, 80);
        //=============================================================================
        // Move chicken
        //=============================================================================
        shapeMode(CORNER);
        for(int i = 0; i < chicken.size(); i++)
        {
            ChickenVector c = chicken.get(i);
            c.draw();
            // if the rocket hit the chicken.
            if(xd + 80 > c.x && xd < c.x + 80 && yd < c.y + 80 && yd + 80 > c.y)
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
                if(e.x + 26 > xd && e.x < xd + 30 && e.y + 46 > yd && e.y < yd + 80)
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
            } else {
               gameEnd = true;
            }
            resultScore = score;
        }
    }
}
