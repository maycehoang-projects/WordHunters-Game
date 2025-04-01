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
  
  if(instructionPressed) {
    instructions();
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

  if (isHovering && mousePressed && !gameStarted) {
    instructionPressed = !instructionPressed;
  }
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
