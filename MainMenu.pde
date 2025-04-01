boolean showInstructions = false;
boolean closeButtonHovered = false;
String[] instructionsContent = {
  "                  Objective:",
  "",
  "Clear as many enemy spaceships as",
  "possible before they reach the bottom",
  " of the screen to attain a high score.",
  "",
  "                How to Play:",
  "",
  "Type the words as they appear on the",
  "screen. Do not worry if you mistype, ",
  "just keep typing. The more words you",
  "clear, the higher your score.",
};

void drawMenuScreen() {
  background(0);
  drawStars();

  player.update();
  player.display();

  drawInstructionsButton();
  drawPlayButton();
  drawSoundButton();

  textFont(font_flappy);
  fill(255);
  textAlign(CENTER, CENTER);
  int fadeDuration = 60; // Fading
  int fade = frameCount % (2 * fadeDuration);
  float alpha = map(fade, 0, fadeDuration, 0, 255);
  if (fade >= fadeDuration) {
    alpha = map(fade, fadeDuration, 2 * fadeDuration, 255, 0);
  }
  fill(255, alpha);
  textSize(65);
  text("Word Hunter", width/2, 100);

  // Draw instructions window if it's toggled on
  if (showInstructions) {
    drawInstructionsWindow();
  }
}

void drawPlayButton() {
  float buttonWidth = 130;
  float buttonHeight = 55;
  float buttonX = width / 2;
  float buttonY = height / 2 + 49;

  // Check if mouse is hovering over the button
  boolean isHovering = mouseX >= buttonX - buttonWidth / 2 && mouseX <= buttonX + buttonWidth / 2 &&
    mouseY >= buttonY - buttonHeight / 2 && mouseY <= buttonY + buttonHeight / 2;

  // Apply tint to play button on hover
  if (isHovering) {
    tint(255, 100);
    image(playButtonImg, width / 2 + 80 - playButtonImg.width / 2, height / 2 + 50, playButtonImg.width * 0.9, playButtonImg.height * 0.9); // Scaled down
  } else {
    noTint(); // No tint when not hovering
    image(playButtonImg, width / 2 + 80 - playButtonImg.width / 2, height / 2 + 50); // Normal size
  }

  noTint();

  if (isHovering && mousePressed && !gameStarted) {
    gameStarted = true;
    clickSound.play();
  }
}

void drawInstructionsButton() {

  float buttonWidth = 40;
  float buttonHeight = 40;
  float buttonX = 17;
  float buttonY = 19;

  boolean isHovering = mouseX >= buttonX && mouseX <= buttonX + buttonWidth &&
    mouseY >= buttonY && mouseY <= buttonY + buttonHeight;

  noFill();
  noStroke();
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 10); // Draw button rectangle

  float scaleFactor = isHovering ? 0.9 : 1.0;
  tint(255, isHovering ? 100 : 255); // Tint when hovering

  image(instructionsButtonImg, 35, 40, instructionsButtonImg.width * scaleFactor, instructionsButtonImg.height * scaleFactor);

  noTint();
}

void drawSoundButton() {
  float buttonWidth = 40;
  float buttonHeight = 40;
  float buttonX = 70;
  float buttonY = 19;

  // Check if mouse is hovering over the button
  boolean isHovering = mouseX >= buttonX && mouseX <= buttonX + buttonWidth &&
    mouseY >= buttonY && mouseY <= buttonY + buttonHeight;

  noFill();
  noStroke();
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 10);

  float scaleFactor = isHovering ? 0.9 : 1.0;
  tint(255, isHovering ? 100 : 255);

  // Sound state
  if (soundOn) {
    image(soundButtonImg, 85, 38, soundButtonImg.width * scaleFactor, soundButtonImg.height * scaleFactor);
  } else {
    image(muteButtonImg, 85, 39, muteButtonImg.width * scaleFactor, muteButtonImg.height * scaleFactor);
  }

  noTint();
}

void drawInstructionsWindow() {
  float windowWidth = 630; // Keep window width
  float windowHeight = 450; // Keep window height
  float windowX = (width - windowWidth) / 2;
  float windowY = (height - windowHeight) / 2;
  float padding = 30; // Increase padding
  int windowOpacity = 245; // Decrease window opacity
  
  // Draw window background with less transparency
  fill(50, windowOpacity); // Decrease opacity
  rect(windowX, windowY, windowWidth, windowHeight, 10);
  
  // Draw instructions content
  fill(255);
  textSize(25); // Keep text size
  textAlign(LEFT, TOP);
  float textX = windowX + padding;
  float textY = windowY + padding;
  float letterSpacing = 2; // Adjust the spacing between letters
  
  for (String line : instructionsContent) {
    for (int i = 0; i < line.length(); i++) {
      char letter = line.charAt(i);
      text(letter, textX, textY);
      textX += textWidth(letter) + letterSpacing; // Add letter width and spacing
    }
    textY += textAscent() + textDescent() + 10; // Add extra space between lines
    textX = windowX + padding; // Reset textX for the next line
  }
  
  // Draw close button
  drawCloseButton(windowX + windowWidth - 40, windowY + 10, 30, 30);
}

void drawCloseButton(float x, float y, float w, float h) {
  // Check if mouse is hovering over the close button
  closeButtonHovered = mouseX >= x && mouseX <= x + w &&
    mouseY >= y && mouseY <= y + h;

  // Draw close button
  fill(closeButtonHovered ? color(200) : color(255));
  rect(x, y, w, h, 5);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("X", x + w / 2, y + h / 2);
}
