class Bullet {
  PVector position;
  PVector velocity;
  float speed = 20;
  PImage bulletImage;
  boolean active = true; // Flag to track if the bullet is still active

  Bullet(float x, float y, PImage bulletImage) {
    position = new PVector(x+5, y+35);
    velocity = new PVector(0, -speed);  // Default upwards
    this.bulletImage = bulletImage;
  }

  void setTarget(float targetX, float targetY) {
    float dx = targetX - position.x;
    float dy = targetY - position.y;
    float distance = sqrt(dx*dx + dy*dy);
    velocity = new PVector(dx / distance * speed, dy / distance * speed);
  }

  void update() {
    if (active) {
      position.add(velocity);
    }
  }

  void display() {
    if (active) {
      imageMode(CENTER);
      // Set a smaller size for the bullet image. Adjust the width and height as needed.
      int bulletWidth = 220;  // Reduced size for the bullet width
      int bulletHeight = 220; // Reduced size for the bullet height
      image(bulletImage, position.x, position.y, bulletWidth, bulletHeight);
    }
  }

  boolean checkCollision(Enemy enemy) {
    float distX = abs(position.x - enemy.position.x);
    float distY = abs(position.y - enemy.position.y);
    if (distX < enemy.spriteWidth / 2 && distY < enemy.spriteHeight / 2) {
      active = false; // Deactivate the bullet
      return true;
    }
    return false;
  }
}
