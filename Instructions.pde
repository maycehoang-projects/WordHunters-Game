void instructions() {
  fill(0, 150);
  rect(0, 0, width, height);
  textFont(font_flappy); 
  textAlign(CENTER, CENTER);
  fill(200); 
  textSize(50);
  text("OBJECTIVE:", width/2, 100);
  fill(255);
  textSize(30); 
  text("Clear as many enemy spaceships as possible \n before they reach the bottom of the\n screen to attain a high score.", width/2, 190);
  fill(200); 
  textSize(50);
  text("HOW TO PLAY:", width/2, 300);
  fill(255);
  textSize(30); 
  text("As the words appear across your screen,\n type the words to eliminate them.\n Do not worry if you mistype, just keep typing.\n The more words you clear, the higher your score.", width/2, 410);
  
  boolean isHovering = mouseX >= buttonX && mouseX <= buttonX + buttonWidth &&
    mouseY >= buttonY && mouseY <= buttonY + buttonHeight;
    
  if (isHovering && mousePressed && !gameStarted) {
    instructionPressed = !instructionPressed;
  }
}
