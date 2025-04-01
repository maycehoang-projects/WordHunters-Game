import java.util.ArrayList;


class PlayerSprite {
  PImage spriteSheet;
  PImage bulletImage;
  int spriteWidth = 100;
  int spriteHeight = 100;
  int totalFrames = 7;
  int currentFrame = 0;
  int frameDuration = 10;
  float x, y;
  float rotationAngle = 0;  // Angle to rotate the sprite
  ArrayList<Bullet> bullets;

  PlayerSprite(float x, float y, PImage spriteSheet, PImage bulletImage) {
    this.x = x;
    this.y = y;
    this.spriteSheet = spriteSheet;
    this.bulletImage = bulletImage;
    bullets = new ArrayList<Bullet>();
  }

  void update() {
        // Animate the player sprite
    if (frameCount % frameDuration == 0) {
      currentFrame = (currentFrame + 1) % totalFrames;
    }
    
    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet bullet = bullets.get(i);
      bullet.update();
      if (!bullet.active || bullet.position.y < 0 || bullet.position.x < 0 || bullet.position.x > width || bullet.position.y > height) {
        bullets.remove(i);  // Remove the bullet if it's not active or out of bounds
      } else {
        for (Enemy enemy : enemySprite.getEnemies()) {
          if (bullet.checkCollision(enemy)) {
            enemy.hitByBullet();  // Custom method to handle the enemy being hit
            break;
          }
        }
      }
    }
  }

void display() {
  // Calculate rotation based on the direction to the target
  imageMode(CENTER);
  pushMatrix();
  translate(x, y);
  rotate(rotationAngle);
  
  // Animate the player sprite
  int col = currentFrame % 3;
  int row = currentFrame / 3;
  PImage currentSprite = spriteSheet.get(col * spriteWidth, row * spriteHeight, spriteWidth, spriteHeight);
  image(currentSprite, 0, 0);
  
  popMatrix();

  // Display bullets
  for (Bullet bullet : bullets) {
    bullet.display();
  }
}


  void shootAt(float targetX, float targetY) {
    Bullet newBullet = new Bullet(x, y - spriteHeight / 2, bulletImage);  // Adjust bullet starting position
    newBullet.setTarget(targetX, targetY);
    bullets.add(newBullet);

    // Calculate angle to rotate sprite towards the target
    float dx = targetX - x;
    float dy = targetY - y;
    rotationAngle = atan2(-dy, -dx) - PI / 2;
  }
}
