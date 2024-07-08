float[] cloudX_6 = {400, 1000, 1600, 2200}; // Posisi awan
float[] cloudY_6 = {200, 300, 140, 240}; // Posisi awan
float[] cloudSize_6 = {120, 160, 100, 180}; // Ukuran awan
float cloudSpeed_6 = 1.5; // Kecepatan gerak awan

float karakterU = 700;
float priaTuaX_6 = 2000; // Mulai dari kanan
float warga1X = 2200;
float warga2X = 2400;
float warga3X = 2600;
float speed = 1.5; // Kecepatan gerak karakter

boolean player6Finished = false; // Untuk melacak apakah player_6 sudah selesai diputar
boolean player6_1Started = false; // Untuk melacak apakah player_6_1 sudah mulai diputar
boolean player6_1Finished = false; // Untuk melacak apakah player_6_1 sudah selesai diputar
boolean player6_2Started = false; // Untuk melacak apakah player_6_2 sudah mulai diputar
boolean player6_2Finished = false; // Untuk melacak apakah player_6_2 sudah selesai diputar
boolean allAudioFinished = false; // Untuk melacak apakah semua audio sudah selesai diputar

int mouthState_6 = 0; // Status mulut (0: tertutup, 1: setengah terbuka, 2: terbuka)
int mouthFrameCount_6 = 0; // Penghitung frame untuk mengatur kecepatan perubahan mulut
boolean isCharacterTalking_6 = false; // Menentukan karakter yang sedang berbicara
int mouthToggleTime = 300; // Waktu toggle buka-tutup mulut dalam milidetik
int lastMouthToggleTime = 0; // Waktu terakhir toggle mulut

void scene_6() {
  // Putar audio utama jika belum diputar
  if (!player_6.isPlaying() && !player6Finished) {
    player_6.play();
  }
  
  // Periksa apakah audio utama telah selesai diputar
  if (!player_6.isPlaying() && !player6Finished) {
    player6Finished = true;
  }

  background(135, 206, 235); // Warna langit biru
  noStroke();
  
  // Gambar awan
  for (int i = 0; i < cloudX_6.length; i++) {
    drawCloud_6(cloudX_6[i], cloudY_6[i], cloudSize_6[i]);
    cloudX_6[i] -= cloudSpeed_6;
    if (cloudX_6[i] < -200) { // Reset posisi awan ketika keluar dari sisi kiri
      cloudX_6[i] = width + 200;
    }
  }
  
  // Gambar pasir
  fill(255, 178, 102); // Warna pasir
  rect(0, 265, width, 815); // Pasir
  
  // Gambar rumah merah
  fill(139, 0, 0); // Warna rumah merah
  rect(1003, 347, 725, 532); // Badan rumah
  fill(139, 69, 19); // Warna atap coklat
  triangle(902, 347, 1365, -106, 1831, 347); // Atap rumah
  fill(255); // Warna Jendela
  rect(1120, 465, 164, 294);
  fill(0);
  rect(1441, 586, 180, 293);
  
  // Animasi buka-tutup mulut saat audio diputar
  if (player6_1Started && !player6_1Finished) {
    if (millis() - lastMouthToggleTime > mouthToggleTime) {
      mouthState_6 = (mouthState_6 + 1) % 3;
      lastMouthToggleTime = millis();
    }
  } else {
    mouthState_6 = 0; // Mulut tertutup jika tidak ada audio yang diputar
  }

  // Gambar karakter pria tua dan animasinya
  drawCharacter_6priaTua(priaTuaX_6, 800, mouthState_6);
  if (priaTuaX_6 > 1020) {
    priaTuaX_6 -= speed;
  } else if (priaTuaX_6 <= 1020 && !player6_1Started) {
    player_6_1.play();
    player6_1Started = true;
  }
  
  // Gambar karakter utama dan animasinya saat audio 6_2 diputar
  if (player6_2Started && !player6_2Finished) {
    if (millis() - lastMouthToggleTime > mouthToggleTime) {
      mouthState_6 = (mouthState_6 + 1) % 3;
      lastMouthToggleTime = millis();
    }
  } else {
    mouthState_6 = 0; // Mulut tertutup jika tidak ada audio yang diputar
  }
  
  drawCharacter_6(karakterU, 800, mouthState_6);
  
  // Periksa apakah audio utama telah selesai diputar
  if (!player_6.isPlaying() && !player6_1Finished) {
    player6Finished = true;
  }
  
  if (player6_1Started && !player6_2Started && !player_6_1.isPlaying()) {
    player6_1Finished = true;
    mouthState_6 = 0; // Mulut diam setelah audio selesai
    player_6_2.play();
    player6_2Started = true;
  }

  if (player6_2Started && !player6_2Finished && !player_6_2.isPlaying()) {
    player6_2Finished = true;
  }

  // Gambar karakter warga 1 dan animasinya
  drawCharacter_Warga_1(warga1X, 800);
  if (warga1X > 1200) {
    warga1X -= speed;
  } 

  // Gambar karakter warga 2 dan animasinya
  drawCharacter_Warga_2(warga2X, 800);
  if (warga2X > 1400) {
    warga2X -= speed;
  }
  
  // Gambar karakter warga 3 dan animasinya
  drawCharacter_Warga_3(warga3X, 800);
  if (warga3X > 1600) {
    warga3X -= speed;
  }

  // Setelah semua audio selesai, gerakkan semua karakter ke kiri
  if (player6_1Started && player6_2Started && player6_2Finished) {
    allAudioFinished = true;
  }

  if (allAudioFinished) {
    karakterU -= speed;
    priaTuaX_6 -= speed;
    warga1X -= speed;
    warga2X -= speed;
    warga3X -= speed;
  }

}
void drawCloud_6(float x, float y, float size) {
  fill(255);
  noStroke();
  ellipse(x - size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x + size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x, y - size * 0.25, size * 0.75, size * 0.75);
  ellipse(x - size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x + size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x, y + size * 0.25, size * 0.5, size * 0.5); // Ellipse tambahan di bawah untuk menutupi space
}

void drawCharacter_6(float x, float y, int mouthState) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 50, 100, 100); // Kepala

  // Rambut
  fill(0); // Mengisi warna hitam untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 50, y - 70); // Titik awal rambut di kiri bawah
  bezierVertex(x - 60, y - 110, x + 60, y - 110, x + 50, y - 70); 
  bezierVertex(x + 50, y - 70, x + 20, y - 90, x, y - 70); 
  bezierVertex(x - 20, y - 90, x - 50, y - 70, x - 50, y - 70); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 20, y - 50, 10, 10);
  ellipse(x + 20, y - 50, 10, 10);

  // Mulut
  fill(255);
  if (mouthState == 0) {
    arc(x, y - 25, 30, 20, 0, PI); // Mulut tertutup
  } else if (mouthState == 1) {
    arc(x, y - 25, 30, 30, 0, PI); // Mulut setengah terbuka
  } else {
    arc(x, y - 25, 30, 40, 0, PI); // Mulut terbuka
  }

  // Badan
  fill(255, 165, 0); // Warna baju kuning
  rect(x - 50, y, 100, 150, 20); // Badan

  // Kerah
  fill(255);
  triangle(x - 50, y, x - 25, y - 25, x, y);
  triangle(x, y, x + 25, y - 25, x + 50, y);

  // Kancing
  fill(0);
  ellipse(x, y + 25, 10, 10);
  ellipse(x, y + 50, 10, 10);
  ellipse(x, y + 75, 10, 10);
  ellipse(x, y + 100, 10, 10);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 70, y, 20, 50, 10);
  rect(x + 50, y, 20, 50, 10);

  // Tangan
  ellipse(x - 60, y + 50, 20, 20);
  ellipse(x + 60, y + 50, 20, 20);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 30, y + 150, 20, 100);
  rect(x + 10, y + 150, 20, 100);

  // Sepatu
  fill(50);
  ellipse(x - 20, y + 250, 30, 20);
  ellipse(x + 20, y + 250, 30, 20);
}

void drawCharacter_6priaTua(float x, float y, int mouthState) {
  // Rambut
  fill(169, 169, 169); // Mengisi warna abu-abu untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 50, y - 70); // Titik awal rambut di kiri bawah
  bezierVertex(x - 60, y - 110, x + 60, y - 110, x + 50, y - 70); 
  bezierVertex(x + 50, y - 70, x + 20, y - 90, x, y - 70); 
  bezierVertex(x - 20, y - 90, x - 50, y - 70, x - 50, y - 70); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  fill(139, 69, 19);
  ellipse(x, y - 50, 100, 100); // Kepala

  // Mata
  fill(0);
  ellipse(x - 20, y - 50, 10, 10);
  ellipse(x + 20, y - 50, 10, 10);

  // Mulut
  fill(255);
  if (mouthState == 0) {
    arc(x, y - 25, 30, 20, 0, PI); // Mulut tertutup
  } else if (mouthState == 1) {
    arc(x, y - 25, 30, 30, 0, PI); // Mulut setengah terbuka
  } else {
    arc(x, y - 25, 30, 40, 0, PI); // Mulut terbuka
  }

  // Badan
  fill(5, 132, 255); // Warna baju biru
  rect(x - 50, y, 100, 150, 20); // Badan

  // Kerah
  fill(0);
  triangle(x - 50, y, x - 25, y - 25, x, y);
  triangle(x, y, x + 25, y - 25, x + 50, y);

  // Kancing
  fill(0);
  ellipse(x, y + 25, 10, 10);
  ellipse(x, y + 50, 10, 10);
  ellipse(x, y + 75, 10, 10);
  ellipse(x, y + 100, 10, 10);

  // Lengan
  fill(139, 69, 19); // Warna kulit
  rect(x - 70, y, 20, 50, 10);
  rect(x + 50, y, 20, 50, 10);

  // Tangan
  ellipse(x - 60, y + 50, 20, 20);
  ellipse(x + 60, y + 50, 20, 20);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 30, y + 150, 20, 100);
  rect(x + 10, y + 150, 20, 100);

  // Sepatu
  fill(50);
  ellipse(x - 20, y + 250, 30, 20);
  ellipse(x + 20, y + 250, 30, 20);
}

void drawCharacter_Warga_1(float x, int y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 50, 100, 100); // Kepala

  // Rambut
  fill(139, 69, 19); // Mengisi warna coklat untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 50, y - 70); // Titik awal rambut di kiri bawah
  bezierVertex(x - 60, y - 110, x + 60, y - 110, x + 50, y - 70); 
  bezierVertex(x + 50, y - 70, x + 20, y - 90, x, y - 70); 
  bezierVertex(x - 20, y - 90, x - 50, y - 70, x - 50, y - 70); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 20, y - 50, 10, 10);
  ellipse(x + 20, y - 50, 10, 10);

  // Mulut
  fill(255);
  arc(x, y - 25, 30, 20, 0, PI); // Mulut sedih

  // Badan
  fill(0, 128, 0); // Warna baju hijau
  rect(x - 50, y, 100, 150, 20); // Badan

  // Kerah
  fill(255);
  triangle(x - 50, y, x - 25, y - 25, x, y);
  triangle(x, y, x + 25, y - 25, x + 50, y);

  // Kancing
  fill(0);
  ellipse(x, y + 25, 10, 10);
  ellipse(x, y + 50, 10, 10);
  ellipse(x, y + 75, 10, 10);
  ellipse(x, y + 100, 10, 10);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 70, y, 20, 50, 10);
  rect(x + 50, y, 20, 50, 10);

  // Tangan
  ellipse(x - 60, y + 50, 20, 20);
  ellipse(x + 60, y + 50, 20, 20);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 30, y + 150, 20, 100);
  rect(x + 10, y + 150, 20, 100);

  // Sepatu
  fill(50);
  ellipse(x - 20, y + 250, 30, 20);
  ellipse(x + 20, y + 250, 30, 20);
}

void drawCharacter_Warga_2(float x, int y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 50, 100, 100); // Kepala

  // Rambut
  fill(255, 69, 0); // Mengisi warna merah untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 50, y - 70); // Titik awal rambut di kiri bawah
  bezierVertex(x - 60, y - 110, x + 60, y - 110, x + 50, y - 70); 
  bezierVertex(x + 50, y - 70, x + 20, y - 90, x, y - 70); 
  bezierVertex(x - 20, y - 90, x - 50, y - 70, x - 50, y - 70); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 20, y - 50, 10, 10);
  ellipse(x + 20, y - 50, 10, 10);

  // Mulut
  fill(255);
  arc(x, y - 25, 30, 20, 0, PI); // Mulut sedih

  // Badan
  fill(0, 0, 255); // Warna baju biru
  rect(x - 50, y, 100, 150, 20); // Badan

  // Kerah
  fill(255);
  triangle(x - 50, y, x - 25, y - 25, x, y);
  triangle(x, y, x + 25, y - 25, x + 50, y);

  // Kancing
  fill(0);
  ellipse(x, y + 25, 10, 10);
  ellipse(x, y + 50, 10, 10);
  ellipse(x, y + 75, 10, 10);
  ellipse(x, y + 100, 10, 10);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 70, y, 20, 50, 10);
  rect(x + 50, y, 20, 50, 10);

  // Tangan
  ellipse(x - 60, y + 50, 20, 20);
  ellipse(x + 60, y + 50, 20, 20);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 30, y + 150, 20, 100);
  rect(x + 10, y + 150, 20, 100);

  // Sepatu
  fill(50);
  ellipse(x - 20, y + 250, 30, 20);
  ellipse(x + 20, y + 250, 30, 20);
}

void drawCharacter_Warga_3(float x, int y) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 50, 100, 100); // Kepala

  // Rambut
  fill(0); // Mengisi warna hitam untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 50, y - 70); // Titik awal rambut di kiri bawah
  bezierVertex(x - 60, y - 110, x + 60, y - 110, x + 50, y - 70); 
  bezierVertex(x + 50, y - 70, x + 20, y - 90, x, y - 70); 
  bezierVertex(x - 20, y - 90, x - 50, y - 70, x - 50, y - 70); 
  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Mata
  fill(0);
  ellipse(x - 20, y - 50, 10, 10);
  ellipse(x + 20, y - 50, 10, 10);

  // Mulut
  fill(255);
  arc(x, y - 25, 30, 20, 0, PI); // Mulut sedih

  // Badan
  fill(255, 0, 0); // Warna baju merah
  rect(x - 50, y, 100, 150, 20); // Badan

  // Kerah
  fill(255);
  triangle(x - 50, y, x - 25, y - 25, x, y);
  triangle(x, y, x + 25, y - 25, x + 50, y);

  // Kancing
  fill(0);
  ellipse(x, y + 25, 10, 10);
  ellipse(x, y + 50, 10, 10);
  ellipse(x, y + 75, 10, 10);
  ellipse(x, y + 100, 10, 10);

  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(x - 70, y, 20, 50, 10);
  rect(x + 50, y, 20, 50, 10);

  // Tangan
  ellipse(x - 60, y + 50, 20, 20);
  ellipse(x + 60, y + 50, 20, 20);

  // Kaki
  fill(0); // Warna celana hitam
  rect(x - 30, y + 150, 20, 100);
  rect(x + 10, y + 150, 20, 100);

  // Sepatu
  fill(50);
  ellipse(x - 20, y + 250, 30, 20);
  ellipse(x + 20, y + 250, 30, 20);
}
