void setup()
{
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
  pinMode(6, INPUT);
  pinMode(7, INPUT);
  Serial.begin(9600);
}

void loop()
{
  Serial.print(digitalRead(2));
  Serial.print('a');
  Serial.print(digitalRead(3));
  Serial.print('b');
  Serial.print(digitalRead(4));
  Serial.print('c');
  Serial.print(digitalRead(5));
  Serial.print('d');
  Serial.print(digitalRead(6));
  Serial.print('e');
  Serial.print(digitalRead(7));
  Serial.print('f');
  delay(1);
}
