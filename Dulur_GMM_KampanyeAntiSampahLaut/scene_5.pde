// Variabel untuk mengatur posisi dan pergerakan awan di scene 5
float[] cloudX_5 = {400, 1000, 1600, 2200}; // Posisi awan
float[] cloudY_5 = {200, 300, 140, 240}; // Posisi awan
float[] cloudSize_5 = {120, 160, 100, 180}; // Ukuran awan
float cloudSpeed_5 = 1.5; // Kecepatan gerak awan

int mouthState_5 = 0; // Status mulut (0: tertutup, 1: setengah terbuka, 2: terbuka)
int mouthFrameCount_5 = 0; // Penghitung frame untuk mengatur kecepatan perubahan mulut

boolean conversationFinished = false; // Status apakah percakapan telah selesai
float priaTuaX = 1020; // Posisi awal pria tua
float priaTuaSpeed = 2; // Kecepatan pria tua

boolean isCharacterTalking = true; // Menentukan karakter awal yang berbicara

void scene_5() {
  background(135, 206, 235); // Warna langit biru
  noStroke();

  // Gambar awan
  for (int i = 0; i < cloudX_5.length; i++) {
    drawCloud_5(cloudX_5[i], cloudY_5[i], cloudSize_5[i]);
    cloudX_5[i] -= cloudSpeed_5;
    if (cloudX_5[i] < -200) { // Reset posisi awan ketika keluar dari sisi kiri
      cloudX_5[i] = width + 200;
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

  // Mengatur audio dan gerakan mulut
  if (currentAudioIndex < scene5Audios.length && !scene5Audios[currentAudioIndex].isPlaying() && !audioPlayed[currentAudioIndex]) {
    scene5Audios[currentAudioIndex].play();
    audioPlayed[currentAudioIndex] = true;
  }

  if (currentAudioIndex < scene5Audios.length && !scene5Audios[currentAudioIndex].isPlaying() && audioPlayed[currentAudioIndex]) {
    currentAudioIndex++;
    isCharacterTalking = !isCharacterTalking; // Bergantian antara karakter kuning dan pria tua
  }

  // Update status mulut setiap 10 frame untuk memperlambat gerakan mulut
  if (mouthFrameCount_5 % 10 == 0) {
    mouthState_5 = (mouthState_5 + 1) % 3;
  }
  mouthFrameCount_5++;

  // Gambar kedua karakter, tetapi hanya karakter yang berbicara yang mulutnya bergerak
  drawCharacter_5(700, 800, isCharacterTalking ? mouthState_5 : 0); // Karakter kuning
  drawCharacter_5priaTua(priaTuaX, 800, !isCharacterTalking ? mouthState_5 : 0); // Pria tua

  // Reset status mulut setelah karakter selesai berbicara
  if (currentAudioIndex >= scene5Audios.length) {
    mouthState_5 = 0;
    conversationFinished = true; // Tandai bahwa percakapan telah selesai
  }

  // Gerakkan pria tua ke kanan setelah percakapan selesai
  if (conversationFinished && priaTuaX < 2000) {
    priaTuaX += priaTuaSpeed;
  }
}

void drawCloud_5(float x, float y, float size) {
  fill(255);
  noStroke();
  ellipse(x - size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x + size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x, y - size * 0.25, size * 0.75, size * 0.75);
  ellipse(x - size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x + size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x, y + size * 0.25, size * 0.5, size * 0.5); // Ellipse tambahan di bawah untuk menutupi space
}

void drawCharacter_5(int x, int y, int mouthState) {
  // Kepala
  fill(255, 224, 189); // Warna kulit
  noStroke();
  ellipse(x, y - 50, 100, 100); // Kepala

  // Rambut
  fill(0); // Mengisi warna hitam untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 50, y - 70); // Titik awal rambut di kiri bawah

  // Menyesuaikan titik kontrol untuk membuat rambut lebih tinggi
  bezierVertex(x - 60, y - 110, x + 60, y - 110, x + 50, y - 70); 
  // Membuat lengkungan dari kiri atas ke kanan atas kepala dengan titik kontrol lebih tinggi (y - 110)

  bezierVertex(x + 50, y - 70, x + 20, y - 90, x, y - 70); 
  // Menambahkan lengkungan kecil dari kanan atas ke tengah kepala

  bezierVertex(x - 20, y - 90, x - 50, y - 70, x - 50, y - 70); 
  // Membuat lengkungan kecil dari tengah kepala kembali ke kiri bawah

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
  ellipse(x - 20, y + 250, 40, 20);
  ellipse(x + 20, y + 250, 40, 20);
}

void drawCharacter_5priaTua(float x, float y, int mouthState) {
  // Rambut
  fill(169, 169, 169); // Mengisi warna abu-abu untuk rambut
  beginShape(); // Memulai bentuk baru
  vertex(x - 50, y - 70); // Titik awal rambut di kiri bawah

  // Menyesuaikan titik kontrol untuk membuat rambut lebih tinggi
  bezierVertex(x - 60, y - 110, x + 60, y - 110, x + 50, y - 70); 
  // Membuat lengkungan dari kiri atas ke kanan atas kepala dengan titik kontrol lebih tinggi (y - 110)

  bezierVertex(x + 50, y - 70, x + 20, y - 90, x, y - 70); 
  // Menambahkan lengkungan kecil dari kanan atas ke tengah kepala

  bezierVertex(x - 20, y - 90, x - 50, y - 70, x - 50, y - 70); 
  // Membuat lengkungan kecil dari tengah kepala kembali ke kiri bawah

  endShape(CLOSE); // Mengakhiri dan menutup bentuk rambut

  // Kepala
  fill(139, 69, 19); // Warna kulit
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
