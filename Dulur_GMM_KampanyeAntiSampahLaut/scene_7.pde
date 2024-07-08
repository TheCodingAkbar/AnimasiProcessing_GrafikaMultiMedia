float waveOffset_7 = 0;
float truckX = -400; // Posisi awal truk di luar layar (kiri)
float truckY = 680; // Posisi vertikal truk dekat pasir
float truckSpeed = 2; // Kecepatan gerak truk
float wheelRotation = 0; // Sudut rotasi roda

float[] cloudX_7 = {400, 1000, 1600, 2200}; // Skala cloudX_1
float[] cloudY_7 = {200, 300, 140, 240}; // Skala cloudY_1
float[] cloudSize_7 = {120, 160, 100, 180}; // Skala cloudSize_1
float cloudSpeed_7 = 1.5; // Skala cloudSpeed_1

void scene_7() {
  background(#87CEEB); // Warna Latar 
  noStroke();

  // Ukuran matahari
  fill(255, 238, 0);
  ellipse(1315, 190, 200, 200);

  // Gambar awan
  for (int i = 0; i < cloudX_7.length; i++) {
    drawCloud_7(cloudX_7[i], cloudY_7[i], cloudSize_7[i]);
    cloudX_7[i] -= cloudSpeed_7;
    if (cloudX_7[i] < -200) { // Reset posisi awan ketika keluar dari sisi kiri
      cloudX_7[i] = width + 200;
    }
  }

  // Gambar laut
  fill(0, 102, 153); // Warna biru laut
  rect(0, 450, width, 540); // Laut
  float waveMovement_2 = 20 * sin(waveOffset_7 * 0.06);
  rect(0, 600 + waveMovement_2, width, 540); // Laut dengan pergerakan

  // Gambar laut dengan animasi ombak
  oceanwater_7(0.002, -0.06, 600 + waveMovement_2, 1140); // Skala gelombang
  oceanwater_7(0.001, 0, 600 + waveMovement_2, 1140); // Skala gelombang
  oceanwater_7(0.0014, 0, 600 + waveMovement_2, 1140);
  oceanwater_7(0.0006, 0.4, 600 + waveMovement_2, 1140);
  oceanwater_7(0.0018, 0.2, 600 + waveMovement_2, 1140);

  // Gambar pasir
  fill(255, 178, 102); // Warna pasir
  rect(0, 650, width, 700); // Pasir

  // Update waveOffset untuk animasi
  waveOffset_7 += 0.5; // Skala kecepatan pergeseran

  Truk();
}

void oceanwater_7(float scale, float dist, float startY, float endY) {
  float x_ocean = waveOffset_7 * scale * 10; // Sesuaikan skala dengan waveOffset_1
  color baseColor = color(0, 102, 153, 100); // Warna dasar laut dengan transparansi
  color whiteColor = color(173, 216, 230, 100); // Warna putih dengan transparansi
  beginShape();
  vertex(width, height);
  vertex(0, height);
  float ds = 200 - (10 * dist); // Skala ds
  for (float i = 0; i <= width; i += 30) { // Skala increment i
    float y2 = noise(x_ocean + (i * scale), dist / 100);
    float waveHeight = ds - (y2 * ds * 2) + 600; // Skala waveHeight, ditingkatkan agar naik ke atas pasir
    float lerpFactor = map(waveHeight, 550, 650, 0, 1); // Dominan biru, putih di puncak
    fill(lerpColor(baseColor, whiteColor, lerpFactor)); // Gradasi warna putih pada puncak gelombang
    vertex(i, waveHeight);
  }
  endShape(CLOSE);
}

void drawCloud_7(float x, float y, float size) {
  fill(255);
  noStroke();
  ellipse(x - size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x + size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x, y - size * 0.25, size * 0.75, size * 0.75);
  ellipse(x - size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x + size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x, y + size * 0.25, size * 0.5, size * 0.5); // Ellipse tambahan di bawah untuk menutupi space
}

void Truk() {
  // Update posisi truk dan rotasi roda
  truckX += truckSpeed;
  wheelRotation += truckSpeed * 0.2; // Kecepatan rotasi roda dipercepat
  if (truckX > 1280) { // Reset posisi truk ketika keluar dari layar (kanan)
    truckX = -400;
  }

  // Gambar truk
  pushMatrix();
  translate(truckX, truckY);

  fill(#0E405A); // Shadow
  rect(94, 52, 300, 200);

  fill(#1572A2);
  rect(98, 50, 300, 200);

  fill(#676767); // Exhaust Shadow
  rect(402, 125, 15, 35, 4);

  fill(#898787); // Exhaust
  rect(404, 125, 15, 35, 4);

  fill(#2F3031); // Shadow
  rect(400, 147, 100, 110);

  fill(102);
  rect(403, 145, 100, 110);

  // Gambar roda depan dengan rotasi
  pushMatrix();
  translate(450, 250);
  rotate(wheelRotation);
  fill(#4A4A4B); // Front wheel
  ellipse(0, 0, 70, 70);
  fill(#AAAAAA); // Front wheel
  ellipse(0, 0, 50, 50);
  fill(255); // Front wheel
  ellipse(0, 0, 35, 35);
  popMatrix();

  // Gambar roda belakang dengan rotasi
  pushMatrix();
  translate(175, 250);
  rotate(wheelRotation);
  fill(#4A4A4B); // Back wheel dark gray
  ellipse(0, 0, 80, 80);
  fill(#AAAAAA); // Back wheel light gray
  ellipse(0, 0, 60, 60);
  fill(255); // Back wheel white
  ellipse(0, 0, 40, 40);
  popMatrix();

  fill(#CCCDCE); // Window
  rect(425, 160, 60, 40, 12, 12, 3, 3);

  fill(#E8E8E8); // Window
  rect(428, 159, 60, 40, 12, 12, 3, 3);

  fill(255); // Smoke small
  ellipse(404, 115, 15, 10);

  fill(255); // Smoke small
  ellipse(395, 102, 19, 14);

  // Gambar sopir
  fill(#F4C27A); // Warna kulit
  ellipse(445, 180, 20, 20); // Kepala

  fill(#000000); // Warna rambut
  arc(445, 175, 20, 20, PI, TWO_PI); // Rambut

  fill(#000000); // Warna mata
  ellipse(442, 178, 3, 3); // Mata kiri
  ellipse(448, 178, 3, 3); // Mata kanan

  fill(#F4C27A); // Warna kulit
  rect(440, 185, 10, 10); // Leher

  fill(#000000); // Warna baju
  rect(435, 195, 20, 10); // Badan

  popMatrix();
}
