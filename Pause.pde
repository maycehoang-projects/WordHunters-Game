void drawPauseScreen() {
  float buttonWidth = 120;
  float buttonHeight = 50;
  float buttonSpacing = 25; // Spacing between buttons

  float buttonX = 350;
  float buttonY = 200;

  fill(0, 150);
  rect(0, 0, width, height);

  // Draw "Game Paused" text
  fill(255);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("Game Paused", width/2, height/5);

  // Check if mouse is hovering over each button
  boolean isHoveringButton1 = mouseX >= buttonX && mouseX <= buttonX + buttonWidth &&
    mouseY >= buttonY && mouseY <= buttonY + buttonHeight;
  boolean isHoveringButton2 = mouseX >= buttonX && mouseX <= buttonX + buttonWidth &&
    mouseY >= buttonY + buttonHeight + buttonSpacing && mouseY <= buttonY + 2 * buttonHeight + buttonSpacing;
  boolean isHoveringButton3 = mouseX >= buttonX && mouseX <= buttonX + buttonWidth &&
    mouseY >= buttonY + 2 * (buttonHeight + buttonSpacing) && mouseY <= buttonY + 3 * buttonHeight + 2 * buttonSpacing;

  fill(0, 0);
  noStroke();
  rect(buttonX - 10, buttonY, buttonWidth, buttonHeight, 10);
  rect(buttonX - 10, buttonY + buttonHeight + buttonSpacing + 15, buttonWidth, buttonHeight, 10);
  rect(buttonX - 5, buttonY + 2 * (buttonHeight + buttonSpacing + 15), buttonWidth, buttonHeight, 10);

  float imageX = 400;

  float initialScale = 0.9;
  float hoverScale = 0.8;

  float scaleButton1 = isHoveringButton1 ? hoverScale : initialScale;
  float scaleButton2 = isHoveringButton2 ? hoverScale : initialScale;
  float scaleButton3 = isHoveringButton3 ? hoverScale : initialScale;

  if (isHoveringButton1) {
    tint(255, 100);
  } else {
    noTint(); // No tint when not hovering
  }

  // Draw first button
  image(restartButtonImg, imageX, 220, restartButtonImg.width * initialScale * scaleButton1, restartButtonImg.height * initialScale * scaleButton1);
  noTint();

  // Apply tint to each button on hover
  if (isHoveringButton2) {
    tint(255, 100);
  } else {
    noTint(); // No tint whe hovering
  }

  image(mainMenuButtonImg, imageX, 305, mainMenuButtonImg.width * initialScale * scaleButton2, mainMenuButtonImg.height * initialScale * scaleButton2);
  noTint();

  if (isHoveringButton3) {
    tint(255, 100);
  } else {
    noTint(); // No tint when not hovering
  }

  // Draw third button
  image(cancelButtonImg, imageX, 389, cancelButtonImg.width * initialScale * scaleButton3, cancelButtonImg.height * initialScale * scaleButton3);
  noTint();

  // Check for click on the restart button
  if (isHoveringButton1 && mousePressed && gamePaused) {
    // Reset the game
    resetGame();
    gamePaused = false;
    clickSound.play(); // Play the click sound
  }

  // Check for click on the cancel button
  if (isHoveringButton3 && mousePressed && gamePaused) {
    // Unpause the game
    gamePaused = false;
    clickSound.play();
  }
}
