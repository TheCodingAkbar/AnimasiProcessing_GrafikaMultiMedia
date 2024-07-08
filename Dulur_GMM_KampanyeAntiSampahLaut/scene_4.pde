// Variabel untuk mengatur posisi dan pergerakan karakter dan sampah
float characterX_4 = 1950; // Posisi awal karakter di luar layar (kanan)
float characterSpeed_4 = 1; // Kecepatan gerak karakter
boolean isHoldingTrash = true; // Status apakah karakter sedang memegang sampah
float trashX_4 = 1300; // Posisi sampah mengikuti karakter
float trashY_4 = 580; // Posisi vertikal sampah (disesuaikan dengan posisi tangan)
float trashDropSpeed = 3; // Kecepatan jatuh sampah

float waveOffset_4 = 0;
float[] cloudX_4 = {400, 1000, 1600, 2200}; // Skala cloudX_4
float[] cloudY_4 = {200, 300, 140, 240}; // Skala cloudY_4
float[] cloudSize_4 = {120, 160, 100, 180}; // Skala cloudSize_4
float cloudSpeed_4 = 1.5; // Skala cloudSpeed_4

float characterY_4 = 1015; // Posisi awal karakter di luar layar (bawah)
float characterX_4_1 = 220; // Posisi awal karakter 4
float characterSpeed_4_vertical = 1; // Kecepatan gerak karakter vertikal
float characterSpeed_4_horizontal = 1; // Kecepatan gerak karakter horizontal

boolean character4Approaching = false; // Status apakah karakter 4 sedang mendekati pria tua

void scene_4() {
  // Memutar audio scene 4_1 jika belum diputar
  if (!scene_4_1_played) {
    player_4_1.play();
    scene_4_1_played = true;
  }

  // Cek jika audio pertama selesai dan audio kedua belum diputar
  if (!player_4_1.isPlaying() && !scene_4_2_played) {
    player_4_2.play();
    scene_4_2_played = true;
  }
  
  background(135, 206, 235); // Warna langit biru
  noStroke();

  // Gambar awan
  for (int i = 0; i < cloudX_4.length; i++) {
    drawCloud_4(cloudX_4[i], cloudY_4[i], cloudSize_4[i]);
    cloudX_4[i] -= cloudSpeed_4;
    if (cloudX_4[i] < -200) { // Reset posisi awan ketika keluar dari sisi kiri
      cloudX_4[i] = width + 200;
    }
  }

  // Gambar pasir
  fill(255, 178, 102); // Warna pasir
  rect(0, 265, width, 815); // Pasir

  // Gambar rumah merah
  fill(139, 0, 0); // Warna rumah merah
  rect(1039, 334, 378, 316); // Badan rumah
  fill(139, 69, 19); // Warna atap coklat
  triangle(930, 340, 1234, 150, 1529, 340); // Atap rumah
  fill(255); // Warna Jendela
  rect(1112, 402, 78, 160);
  fill(0);
  rect(1253, 479, 112, 171);

  // Menggerakkan dan menampilkan pria tua
  if (characterX_4 > 1090) { // Menggerakkan karakter sampai x = 1090
    characterX_4 -= characterSpeed_4;
    trashX_4 = characterX_4; // Menggerakkan sampah bersama karakter
  } else if (isHoldingTrash) {
    isHoldingTrash = false; // Pria tua membuang sampah saat mencapai x = 1090
    character4Approaching = true; // Karakter 4 mulai mendekati pria tua
  }

  drawCharacter_4priaTua(characterX_4, 650);
  if (isHoldingTrash) {
    drawTrash(trashX_4, trashY_4); // Gambar sampah di tangan pria tua
  } else {
    if (trashY_4 < 800) { // Menggerakkan sampah jatuh ke bawah
      trashY_4 += trashDropSpeed;
    }
    drawTrash(1080, trashY_4); // Gambar sampah dibuang di tanah pada posisi yang sama dengan kaki
  }

  // Menggerakkan dan menampilkan karakter 4
  if (character4Approaching) {
    if (characterY_4 > 650) { // Menggerakkan karakter 4 ke atas sampai y = 650
      characterY_4 -= characterSpeed_4_vertical;
    } else if (characterX_4_1 < 950) { // Menggerakkan karakter 4 ke kanan sampai x = 950
      characterX_4_1 += characterSpeed_4_horizontal;
    }
  }
  drawCharacter_4_1(characterX_4_1, characterY_4);

  // Gambar rumah hijau
  fill(82, 157, 72);
  rect(1544, 766, 378, 316); // warna rumah hijau
  fill(139, 69, 19); // Warna atap coklat
  triangle(1458, 766, 1759, 577, 2059, 766);
  fill(255); // Warna Jendela
  rect(1813, 819, 78, 160);
  fill(112, 128, 144);
  rect(1620, 897, 112, 181);
}

void drawCharacter_4priaTua(float x, float y) {
  fill(169, 169, 169); // Mengisi warna abu-abu untuk rambut
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

  fill(139, 69, 19);
  ellipse(x, y - 30, 50, 50); // Kepala

  // Mata
  fill(0);
  ellipse(x - 10, y - 25, 5, 5);
  ellipse(x + 10, y - 25, 5, 5);

  // Mulut
  fill(255);
  arc(x, y - 12, 15, 10, 0, PI); // Mulut sedih

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
  fill(139, 69, 19); // Warna kulit
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

void drawTrash(float x, float y) {
  fill(165, 42, 42); // Warna merah bata untuk sampah
  ellipse(x, y, 30, 30); // Gambar sampah berbentuk lingkaran
}

void drawCharacter_4_1(float x, float y) {
  // Karakter 4 (mirip dengan gambar yang Anda unggah)
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
  // Mata
  fill(0);
  ellipse(x - 10, y - 25, 5, 5);
  ellipse(x + 10, y - 25, 5, 5);

  // Mulut
  fill(255);
  arc(x, y - 12, 15, 10, 0, PI); // Mulut sedih

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

void drawCloud_4(float x, float y, float size) {
  fill(255);
  noStroke();
  ellipse(x - size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x + size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x, y - size * 0.25, size * 0.75, size * 0.75);
  ellipse(x - size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x + size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x, y + size * 0.25, size * 0.5, size * 0.5); // Ellipse tambahan di bawah untuk menutupi space
}
