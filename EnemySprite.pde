import processing.core.PImage;
import processing.core.PVector;
import processing.data.Table;
import java.util.ArrayList;
import java.util.Random;

class EnemySprite {
  PImage[] spriteSheets;
  int numFrames;
  boolean bossSpawned = false;
  int bossSpawnTime = 30 * 60; // 30 seconds in frames
  int spriteWidth, spriteHeight;
  int totalEnemies = 5;
  private Enemy activeEnemy = null;
  public void setActiveEnemy(Enemy enemy) {
    this.activeEnemy = enemy;
  }
  public Enemy getActiveEnemy() {
    return activeEnemy;
  }
  public void clearActiveEnemy() {
    this.activeEnemy = null;
  }
  String[] wordList; // Array to hold words for enemies
  private ArrayList<Enemy> enemies;
  public ArrayList<Enemy> getEnemies() {
    return enemies;
  }
  EnemySprite(PImage[] spriteSheets, int numFrames, int spriteWidth, int spriteHeight, String csvFilePath) {
    this.spriteSheets = spriteSheets;
    this.numFrames = numFrames;
    this.spriteWidth = spriteWidth;
    this.spriteHeight = spriteHeight;
    enemies = new ArrayList<>();
    loadWords(csvFilePath);  // Load words from CSV
  }

  void loadWords(String filePath) {
    Table wordsTable = loadTable(filePath, "header");  // Assuming there's a header
    wordList = new String[wordsTable.getRowCount()];
    for (int i = 0; i < wordsTable.getRowCount(); i++) {
      wordList[i] = wordsTable.getString(i, 0);  // Assume words are in the first column
    }
  }

  void update() {
    if (!gamePaused && frameCount % 60 == 0 && enemies.size() < totalEnemies) {
      PImage spriteSheet = spriteSheets[new Random().nextInt(spriteSheets.length)];
      float randomX = random(width-50);
      int wordIndex = new Random().nextInt(wordList.length); // Randomly pick a word for the enemy
      Enemy newEnemy = new Enemy(randomX, -spriteHeight, spriteSheet, numFrames, spriteWidth, spriteHeight, wordList[wordIndex]);
      enemies.add(newEnemy);
    }

    if (!gamePaused) {
      for (int i = enemies.size() - 1; i >= 0; i--) {
        Enemy enemy = enemies.get(i);
        enemy.update();
        if (enemy.position.y > height || enemy.isWordComplete()) {
          enemies.remove(i);
        }
      }
    }
  }

  void display() {
    for (Enemy enemy : enemies) {
      enemy.display();
    }
  }
}
