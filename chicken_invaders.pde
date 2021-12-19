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

void setup(){
  size(1280,720);
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

void draw(){
  // Draw the background for the game
  image(background, 0, 0, width, height);
  // Score details
  shape(heart,30,height-50,30,30);
  shape(chickensScore,100,height-55,40,40);
  
  // Work on these shapes
  shape(blueChicken, 400, 200);
  shape(redChicken, 600, 200);
  shape(chickenMeal, 600, 400, 80,80);
  shape(egg, 800,300, 26,26);
  shape(crackedEgg, 800,500, 40,40);

  shape(spaceship,mouseX-30,height-160,80,80);
  shape(bullet,500,500,50,50);

}
