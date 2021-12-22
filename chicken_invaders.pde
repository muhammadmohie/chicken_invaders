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
ArrayList < PVector > eggs = new ArrayList < PVector > ();
ArrayList < ChickenVector > chicken = new ArrayList < ChickenVector > ();
float speed = 30;
float y = 740;
int x = 0;
int timer = 4000;
int attempts = 5;
int Scor = 0;
int frameCountEasyness = 15;
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
}
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
    chicken.add(new ChickenVector(100, 50, 0, 1));
    chicken.add(new ChickenVector(400, 150, 1, -1));
    chicken.add(new ChickenVector(700, 300, 1, 1));
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
                    Scor++;
                }
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
    //shape(blueChicken, blueChickenX, blueChickenY);
    // shape(redChicken, redChickenX, redChickenY);
    // shape(chickenMeal, 600, 400, 80, 80);
    // shape(egg, 800, 300, 26, 26);
    // shape(crackedEgg, 800, 500, 40, 40);
    // Move chicken
    for(int i = 0; i < chicken.size(); i++)
    {
        ChickenVector c = chicken.get(i);
        if(c.x >= width - 110 || c.x < 0) c.dir = -c.dir;
        c.x += speed * c.dir;
        if(c.clr == 0) shape(blueChicken, c.x, c.y);
        else if(c.clr == 1) shape(redChicken, c.x, c.y);
        if(frameCount % frameCountEasyness == 0)
        {
            eggs.add(new PVector(c.dir == 1 ? c.x + 20 : c.x, c.y + 50));
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
            e.y += speed;
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
                }
            }
        }
    }
}
