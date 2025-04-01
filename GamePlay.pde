void drawGameplayScreen() {
  background(0);
  drawStars();
  player.update();
  player.display();
  enemySprite.display();
  enemySprite.update();
  drawPauseButton();

  // Draw the score text
  fill(255); 
  textSize(25); 
  textAlign(CENTER); 
  text("Score: " + score, width/2, 40); 


  if (gamePaused) {
    drawPauseScreen(); // Draw pause screen if game is paused
  }
}

void drawPauseButton() {

  float buttonWidth = 40;
  float buttonHeight = 40;
  float buttonX = 732;
  float buttonY = 24;

  // Check if mouse is hovering over the button
  boolean isHovering = mouseX >= buttonX && mouseX <= buttonX + buttonWidth &&
    mouseY >= buttonY && mouseY <= buttonY + buttonHeight;

  // Apply tint to pause button on hover
  if (isHovering) {
    tint(255, 100);
  } else {
    noTint(); // No tint when not hovering
  }

  fill(color(0));
  noStroke();
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 10);

  // Pause button image
  float imageX = 755;
  float imageY = 42;
  float initialScale = 0.9;
  float hoverScale = 0.8;
  float scaleFactor = isHovering ? hoverScale : initialScale;
  image(pauseButtonImg, imageX, imageY, pauseButtonImg.width * initialScale * scaleFactor, pauseButtonImg.height * initialScale * scaleFactor);

  noTint();

  // Check for click on the pause button
  if (isHovering && mousePressed && gameStarted) {
    gamePaused = !gamePaused; // Toggle game pause state
    clickSound.play(); // Play the click sound
  }
}
