class HighScore {
  String playerName;
  int score;

  HighScore(String name, int s) {
    playerName = name;
    score = s;
  }

  void addScore(int s) {
    score = s;
  }

  void display(float x, float y) {
    textFont(font_flappy); 
    fill(255); 
    textAlign(CENTER, CENTER);
    text("Score: " + score, x, y);
  }
}
