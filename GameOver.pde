// Variables for animation
float gameOverTextOpacity = 0;
float scoreTextSize = 0;
float highScoreTextSize = 0;
float buttonScale = 1.0;
float transitionOpacity = 0;

// Button variables
float buttonWidth = 120;
float buttonHeight = 50;
float buttonSpacing = 25; // Spacing between buttons

float buttonX = 350;
float buttonY = 200;

void drawGameOverScreen() {
  if (transitionOpacity < 255) {
    transitionOpacity += 5;
  }

  fill(0, transitionOpacity);
  noStroke();
  rect(0, 0, width, height);

  fill(255, 0, 0, transitionOpacity);
  textSize(72);
  textAlign(CENTER, CENTER);
  // Draw the text without a stroke
  noStroke(); // Disable stroke
  textFont(font_flappy); // Use the custom font
  text("Game Over", width/2, height/3 - 50);

  // Draw static score and high score text with transition opacity
  fill(255, transitionOpacity); // Set text color to white with transition opacity
  textSize(36); // Set text size
  textAlign(CENTER, CENTER); // Set text alignment
  text("Score: " + score, width/2, height/2 - 50); // Display score
  highScoreList.displayHighScores(120, 150, 40);
  highScoreList.displayHighScores(width - 120, 150, 40);

  // Check if mouse is hovering over each button
  boolean isHoveringButton1 = mouseX >= buttonX - 90 && mouseX <= buttonX - 90 + buttonWidth &&
    mouseY >= buttonY + 180 && mouseY <= buttonY + 180 + buttonHeight;
  boolean isHoveringButton2 = mouseX >= buttonX + 98 && mouseX <= buttonX + 100 + buttonWidth &&
    mouseY >= buttonY + 90 + buttonHeight + buttonSpacing && mouseY <= buttonY + 90 + 2 * buttonHeight + buttonSpacing;


  // Draw the three button rectangles with transparent fill
  fill(0); // Semi-transparent white fill
  noStroke(); // Remove border stroke
  rect(buttonX - 100, buttonY +180, buttonWidth, buttonHeight, 10); // Draw first button rectangle
  rect(buttonX + 80, buttonY +85 + buttonHeight + buttonSpacing + 15, buttonWidth, buttonHeight, 10); // Draw second button rectangle


  float imageX = 400;

  float initialScaleFactor = 0.9; // Initial scaling factor
  float hoverScaleFactor = 0.8; // Scale factor when hovering

  // Define scaleFactor variables
  float scaleFactorButton1 = isHoveringButton1 ? hoverScaleFactor : initialScaleFactor;
  float scaleFactorButton2 = isHoveringButton2 ? hoverScaleFactor : initialScaleFactor;

  // Apply tint to each button image based on hover state
  if (isHoveringButton1) {
    tint(255, 100); // Semi-transparent white tint when hovering
  } else {
    noTint(); // No tint when not hovering
  }

  // Draw first button
  image(restartButtonImg, imageX -100, 400, restartButtonImg.width * initialScaleFactor * scaleFactorButton1, restartButtonImg.height * initialScaleFactor * scaleFactorButton1);

  // Reset tint after drawing the button
  noTint();

  // Apply tint to each button image based on hover state
  if (isHoveringButton2) {
    tint(255, 100); // Semi-transparent white tint when hovering
  } else {
    noTint(); // No tint when not hovering
  }

  // Draw second button
  image(mainMenuButtonImg, imageX + 100, 400, mainMenuButtonImg.width * initialScaleFactor * scaleFactorButton2, mainMenuButtonImg.height * initialScaleFactor * scaleFactorButton2);

  // Reset tint after drawing the button
  noTint();

  // Check for click on the restart button
  if (isHoveringButton1 && mousePressed) {
    // Start the transition
    transitionOpacity = 0; // Reset transition opacity
    resetGame(); // Reset the game
    gameStarted = true; // Set gameStarted flag to true
    gameOver = false; // Set gameOver flag to false
    clickSound.play(); // Play the click sound
  }

  // Check for click on the main menu button
  if (isHoveringButton2 && mousePressed) {
    mainMenu();
    clickSound.play(); // Play the click sound
  }
}
