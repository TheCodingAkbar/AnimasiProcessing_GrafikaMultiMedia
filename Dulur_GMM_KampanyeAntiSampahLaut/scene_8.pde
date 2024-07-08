float waveOffset_8 = 0;

float[] cloudX_8 = {400, 1000, 1600, 2200}; // Skala cloudX_1
float[] cloudY_8 = {200, 300, 140, 240}; // Skala cloudY_1
float[] cloudSize_8 = {120, 160, 100, 180}; // Skala cloudSize_1
float cloudSpeed_8 = 1.5; // Skala cloudSpeed_1

void scene_8() {
  background(#87CEEB); // Warna Latar 
  noStroke();
  
  // Ukuran matahari
  fill(255, 238, 0);
  ellipse(1315, 190, 200, 200);

  // Gambar awan
  for (int i = 0; i < cloudX_8.length; i++) {
    drawCloud_8(cloudX_8[i], cloudY_8[i], cloudSize_8[i]);
    cloudX_8[i] -= cloudSpeed_8;
    if (cloudX_8[i] < -200) { // Reset posisi awan ketika keluar dari sisi kiri
      cloudX_8[i] = width + 200;
    }
  }

  // Gambar laut
  fill(0, 102, 153); // Warna biru laut
  rect(0, 450, width, 540); // Laut
  float waveMovement_8 = 20 * sin(waveOffset_8 * 0.06);
  rect(0, 600 + waveMovement_8, width, 540); // Laut dengan pergerakan

  // Gambar laut dengan animasi ombak
  oceanwater_8(0.002, -0.06, 600 + waveMovement_8, 1140); // Skala gelombang
  oceanwater_8(0.001, 0, 600 + waveMovement_8, 1140); // Skala gelombang
  oceanwater_8(0.0014, 0, 600 + waveMovement_8, 1140);
  oceanwater_8(0.0006, 0.4, 600 + waveMovement_8, 1140);
  oceanwater_8(0.0018, 0.2, 600 + waveMovement_8, 1140);

  // Gambar pasir
  fill(255, 178, 102); // Warna pasir
  rect(0, 650, width, 700); // Pasir
  
  //Karakter
  drawCharacter_8(200, 800);
  
  // Gambar truk yang lebih besar dan diam di tengah
  Truk(width / 2 - 600, 400); // Posisikan truk di tengah dan sesuai dengan tinggi pasir
  
  // Update waveOffset untuk animasi
  waveOffset_8 += 0.5; // Skala kecepatan pergeseran
}

void oceanwater_8(float scale, float dist, float startY, float endY) {
  float x_ocean = waveOffset_8 * scale * 10; // Sesuaikan skala dengan waveOffset_1
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

void drawCloud_8(float x, float y, float size) {
  fill(255);
  noStroke();
  ellipse(x - size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x + size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x, y - size * 0.25, size * 0.75, size * 0.75);
  ellipse(x - size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x + size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x, y + size * 0.25, size * 0.5, size * 0.5); // Ellipse tambahan di bawah untuk menutupi space
}

void drawCharacter_8(int x, int y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 75, 150, 150); // Kepala (diperkecil 2x)

  // Rambut
  fill(0); // Mengisi warna hitam untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 75, y - 105); // Titik awal rambut di kiri bawah

  // Menyesuaikan titik kontrol untuk membuat rambut lebih tinggi
  bezierVertex(x - 90, y - 165, x + 90, y - 165, x + 75, y - 105); 
  // Membuat lengkungan dari kiri atas ke kanan atas kepala dengan titik kontrol lebih tinggi (y - 165)

  bezierVertex(x + 75, y - 105, x + 30, y - 135, x, y - 105); 
  // Menambahkan lengkungan kecil dari kanan atas ke tengah kepala

  bezierVertex(x - 30, y - 135, x - 75, y - 105, x - 75, y - 105); 
  // Membuat lengkungan kecil dari tengah kepala kembali ke kiri bawah

  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 30, y - 75, 15, 15);
  ellipse(x + 30, y - 75, 15, 15);

  // Mulut
  fill(255);
  arc(x, y - 37.5, 45, 30, 0, PI); // Mulut sedih

  // Badan
  fill(255, 165, 0); // Warna baju kuning
  rect(x - 75, y, 150, 225, 30); // Badan

  // Kerah
  fill(255);
  triangle(x - 75, y, x - 37.5, y - 37.5, x, y);
  triangle(x, y, x + 37.5, y - 37.5, x + 75, y);

  // Kancing
  fill(0);
  ellipse(x, y + 37.5, 15, 15);
  ellipse(x, y + 75, 15, 15);
  ellipse(x, y + 112.5, 15, 15);
  ellipse(x, y + 150, 15, 15);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 105, y, 30, 75, 15);
  rect(x + 75, y, 30, 75, 15);

  // Tangan
  ellipse(x - 90, y + 75, 30, 30);
  ellipse(x + 90, y + 75, 30, 30);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 45, y + 225, 30, 150);
  rect(x + 15, y + 225, 30, 150);

  // Sepatu
  fill(50);
  ellipse(x - 30, y + 375, 45, 30);
  ellipse(x + 30, y + 375, 45, 30);
}



void Truk(float truckX, float truckY) {
  // Gambar truk
  pushMatrix();
  translate(truckX, truckY);
  scale(3.0); // Memperbesar truk 3 kali

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
  rotate(PI / 4); // Roda dirotasi tetap
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
  rotate(PI / 4); // Roda dirotasi tetap
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
