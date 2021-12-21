PImage background;
PShape blueChicken;
PShape redChicken;
PShape chickenMeal;
PShape egg;
PShape crackedEgg;
PShape spaceship;
PShape bullet;
PShape heart;
PShape chickensScore;
ArrayList < PVector > bullets = new ArrayList < PVector > ();
ArrayList < PVector > eggs = new ArrayList < PVector> (); 
float speed = 30;
float y = 740;
int x = 0;
int attempts = 5;
int Scor = 0;
int blueChickenX = 200;
int blueChickenY = 50;
int redChickenX = 1000;
int redChickenY = 50;
int blueChickenEggY = blueChickenY + 100;
int redChickenEggY = redChickenY + 100;

void setup()
{
    size(1680, 900);
    surface.setResizable(true);
    background = loadImage("background-image-02.jpg");
    blueChicken = loadShape("blue-chicken.svg");
    redChicken = loadShape("red-chicken.svg");
    chickenMeal = loadShape("chicken-meal.svg");
    egg = loadShape("egg.svg");
    crackedEgg = loadShape("cracked-egg.svg");
    spaceship = loadShape("spaceship.svg");
    bullet = loadShape("bullet.svg");
    heart = loadShape("heart.svg");
    chickensScore = loadShape("chickens-score.svg");
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
    // Draw the background for the game
    image(background, 0, 0, width, height);
    // Score details
    shape(heart, 30, height - 50, 30, 30);
    textSize(25);
    text(attempts, 80, height - 25);
    shape(chickensScore, 120, height - 55, 40, 40);
    text(Scor, 180, height - 25);
    
    // Work on show bullets
    if(x == 1) // if he pressed on click left much time the number of bullets incressed
    {
        bullets.add(new PVector(mouseX + 12, y));
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
    // Work on these shapes
    shape(blueChicken, blueChickenX, blueChickenY);
    shape(redChicken, redChickenX, redChickenY);
    shape(chickenMeal, 600, 400, 80, 80);
    shape(egg, 800, 300, 26, 26);
    shape(crackedEgg, 800, 500, 40, 40);

    // blue chicken egg
    if (blueChickenEggY >= height) blueChickenEggY = blueChickenY + 100;
    else blueChickenEggY += speed;
    shape(egg, blueChickenX+35, blueChickenEggY, 26, 26);

    // red chicken egg
    if (redChickenEggY >= height) redChickenEggY = redChickenY + 100;
    else redChickenEggY += speed;
    shape(egg, redChickenX+35, redChickenEggY, 26, 26);


}
