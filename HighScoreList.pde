class HighScoreList {
  ArrayList<HighScore> highScores;
  String filename;
  
  HighScoreList(String filename) {
    this.filename = filename;
    highScores = loadHighScores();
  }
  
  ArrayList<HighScore> loadHighScores() {
    ArrayList<HighScore> scores = new ArrayList<HighScore>();
    String[] lines = loadStrings(filename);
    if (lines != null) {
      for (String line : lines) {
        String[] parts = line.split(",");
        String playerName = parts[0];
        int score = Integer.parseInt(parts[1]);
        scores.add(new HighScore(playerName, score));
      }
    }
    return scores;
  }
  
  void saveHighScores() {
    try {
      PrintWriter writer = new PrintWriter("highscores.txt");
      for (HighScore hs : highScores) {
        writer.print(hs.playerName + "," + hs.score);
      }
      writer.flush();
      writer.close();
    } catch (IOException e) {
      println("Error saving high scores: " + e.getMessage());
    }
  }
  
  void addHighScore(String playerName, int score) {
      HighScore newHighScore = new HighScore(playerName, score);
      if (highScores.contains(newHighScore)) {
          return;
      }
      highScores.add(newHighScore);
      highScores.sort((a, b) -> Integer.compare(b.score, a.score));
      if (highScores.size() > 10) {
          highScores.remove(highScores.size() - 1); 
      }
      saveHighScores();
  }

  
  void displayHighScores(float x, float y, float lineHeight) {
    textFont(font_flappy); 
    textSize(35);
    textAlign(CENTER, CENTER);
    fill(255); 
    text("High Score:", x + 10, y - 50);
    for (int i = 0; i < highScores.size(); i++) {
      HighScore hs = highScores.get(i);
      text(hs.playerName + ": " + hs.score, x, y + i * lineHeight);
    }
  }
}
