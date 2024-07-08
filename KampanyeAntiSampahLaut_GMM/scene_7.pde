
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
  //Masukkin Audio
   if (!player_7.isPlaying()) {
    player_7.play();
  }
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
  
   // Gambar sampah
  image(sampah, 700, 850, 100, 120); // Menggambar gambar sampah

  Truk();

  // Gambar karakter
  drawCharacter_Warga_3_7(200, 850);
  drawCharacter_Warga_2_7(350, 850);
  drawCharacter_Warga_1_7(450, 850);
  drawCharacter_7priaTua(550, 850);
  drawCharacter_7(650, 850);
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
  if (truckX < 700) { // Truk berhenti saat mencapai x = 850
    truckX += truckSpeed;
    wheelRotation += truckSpeed * 0.2; // Kecepatan rotasi roda dipercepat
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

void drawCharacter_7(float x, float y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 30, 50, 50); // Kepala

  // Rambut
  fill(0); // Mengisi warna hitam untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 25, y - 35); // Titik awal rambut di kiri bawah
  bezierVertex(x - 30, y - 75, x + 30, y - 75, x + 25, y - 40); 
  bezierVertex(x + 25, y - 35, x + 10, y - 45, x, y - 35); 
  bezierVertex(x - 10, y - 45, x - 25, y - 35, x - 25, y - 35); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 10, y - 30, 5, 5);
  ellipse(x + 10, y - 30, 5, 5);

  // Mulut
  fill(255);
  arc(x, y - 15, 15, 10, 0, PI); // Mulut tertutup

  // Badan
  fill(255, 165, 0); // Warna baju kuning
  rect(x - 25, y, 50, 75, 10); // Badan

  // Kerah
  fill(255);
  triangle(x - 25, y, x - 12, y - 12, x, y);
  triangle(x, y, x + 12, y - 12, x + 25, y);

  // Kancing
  fill(0);
  ellipse(x, y + 12, 5, 5);
  ellipse(x, y + 25, 5, 5);
  ellipse(x, y + 37, 5, 5);
  ellipse(x, y + 50, 5, 5);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 35, y, 10, 25, 5);
  rect(x + 25, y, 10, 25, 5);

  // Tangan
  ellipse(x - 30, y + 25, 10, 10);
  ellipse(x + 30, y + 25, 10, 10);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 15, y + 75, 10, 50);
  rect(x + 5, y + 75, 10, 50);

  // Sepatu
  fill(50);
  ellipse(x - 10, y + 125, 15, 10);
  ellipse(x + 10, y + 125, 15, 10);
}

void drawCharacter_7priaTua(float x, float y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 30, 50, 50); // Kepala

  // Rambut
  fill(169, 169, 169); // Mengisi warna abu-abu untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 25, y - 40); // Titik awal rambut di kiri bawah
  bezierVertex(x - 30, y - 70, x + 30, y - 70, x + 25, y - 40); 
  bezierVertex(x + 25, y - 40, x + 10, y - 55, x, y - 45); 
  bezierVertex(x - 10, y - 55, x - 25, y - 40, x - 25, y - 40); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 10, y - 30, 5, 5);
  ellipse(x + 10, y - 30, 5, 5);

  // Mulut
  fill(255);
  arc(x, y - 15, 15, 10, 0, PI); // Mulut tertutup

  // Badan
  fill(5, 132, 255); // Warna baju biru
  rect(x - 25, y, 50, 75, 10); // Badan

  // Kerah
  fill(0);
  triangle(x - 25, y, x - 12, y - 12, x, y);
  triangle(x, y, x + 12, y - 12, x + 25, y);

  // Kancing
  fill(0);
  ellipse(x, y + 12, 5, 5);
  ellipse(x, y + 25, 5, 5);
  ellipse(x, y + 37, 5, 5);
  ellipse(x, y + 50, 5, 5);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 35, y, 10, 25, 5);
  rect(x + 25, y, 10, 25, 5);

  // Tangan
  ellipse(x - 30, y + 25, 10, 10);
  ellipse(x + 30, y + 25, 10, 10);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 15, y + 75, 10, 50);
  rect(x + 5, y + 75, 10, 50);

  // Sepatu
  fill(50);
  ellipse(x - 10, y + 125, 15, 10);
  ellipse(x + 10, y + 125, 15, 10);
}

void drawCharacter_Warga_1_7(float x, int y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 30, 50, 50); // Kepala

  // Rambut
  fill(139, 69, 19); // Mengisi warna coklat untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 25, y - 35); // Titik awal rambut di kiri bawah
  bezierVertex(x - 30, y - 75, x + 30, y - 75, x + 25, y - 40); 
  bezierVertex(x + 25, y - 35, x + 10, y - 45, x, y - 35); 
  bezierVertex(x - 10, y - 45, x - 25, y - 35, x - 25, y - 35); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 10, y - 30, 5, 5);
  ellipse(x + 10, y - 30, 5, 5);

  // Mulut
  fill(255);
  arc(x, y - 15, 15, 10, 0, PI); // Mulut tertutup

  // Badan
  fill(0, 128, 0); // Warna baju hijau
  rect(x - 25, y, 50, 75, 10); // Badan

  // Kerah
  fill(255);
  triangle(x - 25, y, x - 12, y - 12, x, y);
  triangle(x, y, x + 12, y - 12, x + 25, y);

  // Kancing
  fill(0);
  ellipse(x, y + 12, 5, 5);
  ellipse(x, y + 25, 5, 5);
  ellipse(x, y + 37, 5, 5);
  ellipse(x, y + 50, 5, 5);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 35, y, 10, 25, 5);
  rect(x + 25, y, 10, 25, 5);

  // Tangan
  ellipse(x - 30, y + 25, 10, 10);
  ellipse(x + 30, y + 25, 10, 10);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 15, y + 75, 10, 50);
  rect(x + 5, y + 75, 10, 50);

  // Sepatu
  fill(50);
  ellipse(x - 10, y + 125, 15, 10);
  ellipse(x + 10, y + 125, 15, 10);
}

void drawCharacter_Warga_2_7(float x, int y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 30, 50, 50); // Kepala

  // Rambut
  fill(255, 69, 0); // Mengisi warna merah untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 25, y - 35); // Titik awal rambut di kiri bawah
  bezierVertex(x - 30, y - 75, x + 30, y - 75, x + 25, y - 40); 
  bezierVertex(x + 25, y - 35, x + 10, y - 45, x, y - 35); 
  bezierVertex(x - 10, y - 45, x - 25, y - 35, x - 25, y - 35); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 10, y - 30, 5, 5);
  ellipse(x + 10, y - 30, 5, 5);

  // Mulut
  fill(255);
  arc(x, y - 15, 15, 10, 0, PI); // Mulut tertutup

  // Badan
  fill(0, 0, 255); // Warna baju biru
  rect(x - 25, y, 50, 75, 10); // Badan

  // Kerah
  fill(255);
  triangle(x - 25, y, x - 12, y - 12, x, y);
  triangle(x, y, x + 12, y - 12, x + 25, y);

  // Kancing
  fill(0);
  ellipse(x, y + 12, 5, 5);
  ellipse(x, y + 25, 5, 5);
  ellipse(x, y + 37, 5, 5);
  ellipse(x, y + 50, 5, 5);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 35, y, 10, 25, 5);
  rect(x + 25, y, 10, 25, 5);

  // Tangan
  ellipse(x - 30, y + 25, 10, 10);
  ellipse(x + 30, y + 25, 10, 10);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 15, y + 75, 10, 50);
  rect(x + 5, y + 75, 10, 50);

  // Sepatu
  fill(50);
  ellipse(x - 10, y + 125, 15, 10);
  ellipse(x + 10, y + 125, 15, 10);
}

void drawCharacter_Warga_3_7(float x, int y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 30, 50, 50); // Kepala

  // Rambut
  fill(0); // Mengisi warna hitam untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 25, y - 35); // Titik awal rambut di kiri bawah
  bezierVertex(x - 30, y - 75, x + 30, y - 75, x + 25, y - 40); 
  bezierVertex(x + 25, y - 35, x + 10, y - 45, x, y - 35); 
  bezierVertex(x - 10, y - 45, x - 25, y - 35, x - 25, y - 35); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 10, y - 30, 5, 5);
  ellipse(x + 10, y - 30, 5, 5);

  // Mulut
  fill(255);
  arc(x, y - 15, 15, 10, 0, PI); // Mulut tertutup

  // Badan
  fill(255, 0, 0); // Warna baju merah
  rect(x - 25, y, 50, 75, 10); // Badan

  // Kerah
  fill(255);
  triangle(x - 25, y, x - 12, y - 12, x, y);
  triangle(x, y, x + 12, y - 12, x + 25, y);

  // Kancing
  fill(0);
  ellipse(x, y + 12, 5, 5);
  ellipse(x, y + 25, 5, 5);
  ellipse(x, y + 37, 5, 5);
  ellipse(x, y + 50, 5, 5);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 35, y, 10, 25, 5);
  rect(x + 25, y, 10, 25, 5);

  // Tangan
  ellipse(x - 30, y + 25, 10, 10);
  ellipse(x + 30, y + 25, 10, 10);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 15, y + 75, 10, 50);
  rect(x + 5, y + 75, 10, 50);

  // Sepatu
  fill(50);
  ellipse(x - 10, y + 125, 15, 10);
  ellipse(x + 10, y + 125, 15, 10);
}
