import processing.sound.*;

PImage spriteSheet;
PlayerSprite player;
PImage bulletImage;
EnemySprite enemySprite;
PImage muteButtonImg, soundButtonImg, xButtonImg, instructionsButtonImg, playButtonImg, pauseButtonImg, resumeButtonImg, restartButtonImg, mainMenuButtonImg, cancelButtonImg;
PFont font_flappy;
boolean showSettingsMenu = false, gameStarted = false, gamePaused = false, gameOver = false, instructionPressed = false;
int imageY, score = 0, highScore = 0;
PImage[] enemySpriteSheets;
boolean soundOn = true;
HighScoreList highScoreList;
HighScore playerScore;
boolean addScore = false;
String playerName = "";
boolean nameEntered = false;
char[] input = new char[200];
int nameCount = 0;
boolean transitioningToGameplay = false;
Timer speedTimer;

int numStars = 100;
float[] starX = new float[numStars];
float[] starY = new float[numStars];
float starSpeed = 1.0;
String instructionsText = "Instructions...";

SoundFile clickSound;
SoundFile typeSound;
SoundFile backgroundMusic;

void setup() {
  size(800, 600);
  clickSound = new SoundFile(this, "click.mp3"); // Load the sound file
  typeSound = new SoundFile(this, "shoot.mp3"); // Load the sound file
  backgroundMusic = new SoundFile(this, "background.mp3");
  backgroundMusic.loop();
  
  // Load high scores and initialize new player score
  highScoreList = new HighScoreList("highscores.txt");
  playerScore = new HighScore(playerName, score);

  // Load enemy sprite sheets
  enemySpriteSheets = new PImage[] { loadImage("enemysprite.png"), loadImage("enemysprite2.png") };

  // Load player sprite sheet and bullet image
  spriteSheet = loadImage("spritesheet.png");
  bulletImage = loadImage("bullet.png");

  // Initialize player and enemy sprites
  player = new PlayerSprite(width/2, 550, spriteSheet, bulletImage);
  enemySprite = new EnemySprite(enemySpriteSheets, 5, 80, 80, "words.csv");

  // Create a timer for the enemy sprites speed
  speedTimer = new Timer(5000, enemySprite.velocity);

  // Load button images
  instructionsButtonImg = loadImage("instructions.png");
  xButtonImg = loadImage("x.png");
  playButtonImg = loadImage("play.png");
  pauseButtonImg = loadImage("pause.png");
  resumeButtonImg = loadImage("resume.png");
  restartButtonImg = loadImage("restart.png");
  mainMenuButtonImg = loadImage("menu.png");
  cancelButtonImg = loadImage("cancel.png");
  soundButtonImg = loadImage("sound.png");
  muteButtonImg = loadImage("mute.png");

  // Resize button images
  instructionsButtonImg.resize(53, 60);
  xButtonImg.resize(40, 0);
  playButtonImg.resize(160, 0);
  pauseButtonImg.resize(0, 80);
  resumeButtonImg.resize(0, 80);
  restartButtonImg.resize(0, 80);
  mainMenuButtonImg.resize(0, 80);
  cancelButtonImg.resize(0, 80);
  soundButtonImg.resize(50, 55);
  muteButtonImg.resize(53, 52);

  int maxButtonWidth = max(restartButtonImg.width, cancelButtonImg.width, mainMenuButtonImg.width + 20) + 15; // Adding extra width to the menu button
  restartButtonImg.resize(maxButtonWidth, 0);
  mainMenuButtonImg.resize(maxButtonWidth, 0);
  cancelButtonImg.resize(maxButtonWidth, 0);

  // Load font
  font_flappy = createFont("flappy-font.ttf", 48);

  // Initialize player score
  playerScore = new HighScore("Player", 0);

  // Initialize stars
  for (int i = 0; i < numStars; i++) {
    starX[i] = random(width);
    starY[i] = random(height);
  }
}

void draw() {
  if (gameStarted && !gameOver) {
    if (transitionOpacity > 0) {
      // Draw a black screen with fade
      fill(0, transitionOpacity);
      rect(0, 0, width, height);
      transitionOpacity -= 5;
    } else {

      drawGameplayScreen();

      // Check if any enemy sprite has reached bottom
      for (Enemy enemy : enemySprite.getEnemies()) {
        if (enemy.position.y >= height) {
          gameOver = true;
          break;
        }
      }
      speedTimer.update();
      enemySprite.changeVelocity(speedTimer.enemyVelocity);
    }
  } else if (gameOver) {
    drawGameOverScreen();
    if (!addScore) {
      highScoreList.addHighScore(playerName, score);
      addScore = true;
    }
  } else {
    drawMenuScreen();
    textSize(30);
    text("Enter your name:", width/2, 200);
    text(String.valueOf(input).trim(), width/2, 250);
  }
  moveStars(); // Move stars
  if (!soundOn) {
    // Stop any sound playback
    backgroundMusic.stop();
    typeSound.stop();
    clickSound.stop();
  }
}


void mouseClicked() {
  // Toggle sound state when sound button is clicked
  if (mouseX >= 70 && mouseX <= 110 && mouseY >= 19 && mouseY <= 59) {
    soundOn = !soundOn; // Toggle sound state
    if (!soundOn) {
      // Stop all sounds if sound is turned off
      backgroundMusic.stop(); // Stop background music
      typeSound.stop(); // Stop typing sound
      clickSound.play(); // Play click sound
    } else {
      // Play background music if sound is turned on
      backgroundMusic.loop();
      clickSound.play(); // Play click sound
    }
  }

  // Open the instructions page
  /*
    if (mouseX >= 17 && mouseX <= 57 && mouseY >= 19 && mouseY <= 59) {
      instructions();
    }*/

  // Restart the game when restart button is clicked during game pause
  if (gamePaused && mouseX >= width/2 - mainMenuButtonImg.width / 2 - 2 && mouseX <= width/2 + mainMenuButtonImg.width / 2 + 2 && mouseY >= height/2 - restartButtonImg.height / 2 - 52 && mouseY <= height/2 + restartButtonImg.height / 2 + 48) {
    mainMenu(); // Restart the game
    clickSound.play(); // Play click sound
  }
}


void mainMenu() {
  // Reset
  showSettingsMenu = false;
  gameStarted = false;
  gamePaused = false;
  gameOver = false;
  score = 0;
  highScore = 0;

  player = new PlayerSprite(width/2, 550, spriteSheet, bulletImage);
  enemySprite = new EnemySprite(enemySpriteSheets, 5, 80, 80, "words.csv");

  println("Game Reset!"); // Added statement to check

  // Reset stars
  for (int i = 0; i < numStars; i++) {
    starX[i] = random(width);
    starY[i] = random(height);
  }
}

void resetGame() {
  player = new PlayerSprite(width/2, 550, spriteSheet, bulletImage);
  enemySprite = new EnemySprite(enemySpriteSheets, 5, 80, 80, "words.csv");
  score = 0;
}

void keyPressed() {
  if (!gameStarted && !nameEntered) {
    if (key != ENTER) {
      input[nameCount] = key;
      nameCount++;
      playerName += key;
    }
    else {
      nameEntered = true;
      print(playerName);
    }
  }

  boolean letterTyped = false;
  if (soundOn) {
    typeSound.amp(0.5);
    typeSound.play();
  }

  // Check if there is an active enemy
  if (enemySprite.getActiveEnemy() != null) {
    // Interact only with the active enemy
    Enemy activeEnemy = enemySprite.getActiveEnemy();
    if (activeEnemy.typeLetter(key)) {
      player.shootAt(activeEnemy.position.x, activeEnemy.position.y);
      letterTyped = true;
      if (activeEnemy.isWordComplete()) {
        enemySprite.getEnemies().remove(enemySprite.getEnemies().indexOf(activeEnemy)); // Remove the enemy
        enemySprite.clearActiveEnemy(); // Clear active enemy since the word is completed
        score += 10;
        playerScore.addScore(score);
      }
    }
  } else {
    // If no active enemy, find the first match and set it as active
    for (int i = 0; i < enemySprite.getEnemies().size(); i++) {
      Enemy enemy = enemySprite.getEnemies().get(i);
      if (enemy.typeLetter(key)) {
        enemySprite.setActiveEnemy(enemy); // Set this enemy as the active one
        player.shootAt(enemy.position.x, enemy.position.y);
        letterTyped = true;
        if (enemy.isWordComplete()) {
          enemySprite.getEnemies().remove(i); // Remove the enemy
          enemySprite.clearActiveEnemy(); // Reset active enemy since the word is completed
          score += 10;
          playerScore.addScore(score);
        }
        break; // Stop after the first match
      }
    }
  }

  if (!letterTyped && gameStarted) {
    // Handle other keys if no enemy word was matched and the game has started
  }
}

void drawStars() {
  fill(0);
  rect(0, 0, width, height); // Clear the screen
  fill(255, 150);
  noStroke();
  for (int i = 0; i < numStars; i++) {
    ellipse(starX[i], starY[i], 3, 3);
  }
}

void moveStars() {
  for (int i = 0; i < numStars; i++) {
    starY[i] += starSpeed;
    if (starY[i] > height) {
      starY[i] = random(-height, 0);
      starX[i] = random(width);
    }
  }
}
