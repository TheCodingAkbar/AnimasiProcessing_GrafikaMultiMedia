float[] cloudX_3 = {400, 1000, 1600, 2200}; // Skala cloudX_3
float[] cloudY_3 = {200, 300, 140, 240}; // Skala cloudY_3
float[] cloudSize_3 = {120, 160, 100, 180}; // Skala cloudSize_3
float cloudSpeed_3 = 1.5; // Skala cloudSpeed_3
float waveOffset_3 = 0;

int characterY_3 = 1015; // Posisi awal karakter di luar layar (bawah)
float characterSpeed_3 = 1; // Kecepatan gerak karakter

void scene_3() {
  //Masukkin Audio
   if (!player_3.isPlaying()) {
    player_3.play();
  }
  background(135, 206, 235); // Warna langit biru
  noStroke();
  
  // Gambar awan
  for (int i = 0; i < cloudX_3.length; i++) {
    drawCloud_3(cloudX_3[i], cloudY_3[i], cloudSize_3[i]);
    cloudX_3[i] -= cloudSpeed_3;
    if (cloudX_3[i] < -200) { // Reset posisi awan ketika keluar dari sisi kiri
      cloudX_3[i] = width + 200;
    }
  }
  
  // Update waveOffset untuk animasi
  waveOffset_3 += 0.5; // Skala kecepatan pergeseran
  
  // Gambar pasir
  fill(255, 178, 102); // Warna pasir
  rect(0, 265, width, 815); // Pasir
  
  // Gambar rumah 1
  fill(139, 0, 0); // Warna rumah merah
  rect(1096, 284, 279, 222); // Badan rumah
  fill(139, 69, 19); // Warna atap coklat
  triangle(1040, 293, 1236, 133, 1432, 293); // Atap rumah
  fill(255); // Warna Jendela
  rect(1134, 324, 49, 139);
  fill(0);
  rect(1250, 376, 93, 130);
 
  // Gambar rumah 2
  fill(82, 157, 72);
  rect(1538, 508, 279, 214); // Warna rumah hijau
  fill(139, 69, 19); // Warna atap coklat
  triangle(1485, 508, 1680, 351, 1877, 508);
  fill(255); // Warna Jendela
  rect(1725, 546, 49, 139);
  fill(112, 128, 144);
  rect(1587, 592, 93, 130);
  
  // Gambar rumah 3
  fill(11, 59, 94);
  rect(1737, 176, 279, 214); // Warna rumah biru
  fill(139, 69, 19); // Warna atap coklat
  triangle(1680, 184, 1877, 26, 2073, 184); // Atap rumah
  fill(255, 233, 174);
  rect(1774, 260, 93, 130);
  
  // Menggerakkan dan menampilkan karakter
  if (characterY_3 > 670) { // Menggerakkan karakter sampai y = 670
    characterY_3 -= characterSpeed_3;
  }
  drawCharacter_3(220, characterY_3);
}

void drawCloud_3(float x, float y, float size) {
  fill(255);
  noStroke();
  ellipse(x - size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x + size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x, y - size * 0.25, size * 0.75, size * 0.75);
  ellipse(x - size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x + size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x, y + size * 0.25, size * 0.5, size * 0.5); // Ellipse tambahan di bawah untuk menutupi space
}

void drawCharacter_3(int x, int y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 30, 50, 50); // Kepala

  // Rambut
  fill(0); // Mengisi warna hitam untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 25, y - 35); // Titik awal rambut di kiri bawah

  // Menyesuaikan titik kontrol untuk membuat rambut lebih tinggi
  bezierVertex(x - 30, y - 75, x + 30, y - 75, x + 25, y - 40); 
  // Membuat lengkungan dari kiri atas ke kanan atas kepala dengan titik kontrol lebih tinggi (y - 75)

  bezierVertex(x + 25, y - 35, x + 10, y - 45, x, y - 35); 
  // Menambahkan lengkungan kecil dari kanan atas ke tengah kepala

  bezierVertex(x - 10, y - 45, x - 25, y - 35, x - 25, y - 35); 
  // Membuat lengkungan kecil dari tengah kepala kembali ke kiri bawah

  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

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
