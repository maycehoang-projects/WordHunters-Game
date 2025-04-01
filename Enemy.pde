class Enemy {
  PVector position;
  PVector velocity;
  int numFrames;
  int currentFrame = 0;
  int frameDuration = 10;
  int spriteWidth, spriteHeight;
  PImage spriteSheet;
  String word; // Word associated with this enemy
  StringBuilder typedWord; // Tracks letters typed correctly so far
  
  int fallSpeed = 2; // Speed at which the enemy falls after being hit
  boolean bulletHit = false;
  Enemy(float x, float y, PImage spriteSheet, int numFrames, int spriteWidth, int spriteHeight, String word, PVector velocity) {
    this.position = new PVector(x, y);
    this.velocity = new PVector(0, 2);
    this.spriteSheet = spriteSheet;
    this.numFrames = numFrames;
    this.spriteWidth = spriteWidth;
    this.spriteHeight = spriteHeight;
    this.word = word;
    this.typedWord = new StringBuilder();
  }

  void update() {
    if (!bulletHit) {
      if (frameCount % frameDuration == 0) {
        currentFrame = (currentFrame + 1) % numFrames;
      }
      position.add(velocity);

      if (position.x < 0) {
        position.x = 0;
        velocity.x *= -1;
      } else if (position.x + spriteWidth > width) {
        position.x = width - spriteWidth;
        velocity.x *= -1;
      }
      if (position.y < 0) {
        position.y = 0;
      }
    } else {
      // If hit by a bullet, make the enemy fall downwards
      position.y += fallSpeed;
    }
  }
 
  void display() {
    // Assuming your sprite sheet is divided into rows and columns
    int cols = spriteSheet.width / spriteWidth; // Calculate number of columns in the sprite sheet
    int col = currentFrame % cols; // Column is determined by current frame modulo the number of columns
    int row = currentFrame / cols; // Row is determined by current frame divided by the number of columns

    imageMode(CENTER);
    PImage currentSprite = spriteSheet.get(col * spriteWidth, row * spriteHeight, spriteWidth, spriteHeight);
    image(currentSprite, position.x, position.y);
    textSize(18);
    textAlign(CENTER, CENTER);

    // Calculate the starting position for the text
    float startX = position.x - textWidth(word) / 2;

    // Iterate over each character in the word
    for (int i = 0; i < word.length(); i++) {
      if (i < typedWord.length()) {
        fill(#D6707E); // Red color for typed letters
      } else {
        fill(255); // White color for untyped letters
      }
      // Display each character
      text(word.charAt(i), startX + textWidth(word.substring(0, i)), position.y - spriteHeight / 2 - 10);
    }
  }

  boolean typeLetter(char letter) {
    if (typedWord.length() < word.length() && word.charAt(typedWord.length()) == letter) {
      typedWord.append(letter);
      return true;
    }
    return false;
  }

  boolean isWordComplete() {
    return typedWord.length() == word.length();
  }

  void hitByBullet() {
    bulletHit = true;
    velocity.y = 0; // Stop vertical movement when hit by a bullet
  }

  boolean isHitByBullet() {
    return bulletHit;
  }
}
