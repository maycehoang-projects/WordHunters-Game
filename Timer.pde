class Timer {
  int speedTimerValue;
  int speedTimer;
  boolean active;
  PVector enemyVelocity;

  Timer(int speedTimerValue, PVector enemyVelocity) {
    this.speedTimerValue = speedTimerValue;
    this.speedTimer = millis();
    this.active = false;
    this.enemyVelocity = enemyVelocity;
  }

  void update() {
    if (active && millis() - speedTimer >= speedTimerValue) {
      enemyVelocity.y += .1;
      active = false;
    }
  }

  boolean over() {
    return !active;
  }

  void restart() {
    active = true;
    speedTimer = millis();
  }

  void pause() {
    active = false;
  }

  void begin() {
    active = true;
    speedTimer = millis();
  }
}
