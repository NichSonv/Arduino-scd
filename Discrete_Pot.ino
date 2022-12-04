int p = A3;
int pv;
int ppv = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  pv = analogRead(p);
  if (pv < (ppv-2) || pv > (ppv+2)) {
    Serial.print("p0:");
    Serial.println(pv);
  }
  ppv = pv;
  delay(15);
}
