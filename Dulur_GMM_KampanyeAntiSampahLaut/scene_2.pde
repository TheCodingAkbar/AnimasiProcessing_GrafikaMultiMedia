float waveOffset_2 = 0;

float[] cloudX_2 = {400, 1000, 1600, 2200}; // Skala cloudX_1
float[] cloudY_2 = {200, 300, 140, 240}; // Skala cloudY_1
float[] cloudSize_2 = {120, 160, 100, 180}; // Skala cloudSize_1
float cloudSpeed_2 = 1.5; // Skala cloudSpeed_1


float characterX_2 = -100; // Posisi awal karakter di luar layar (kiri)
float characterSpeed_2 = 0.8; // Kecepatan gerak karakter


void scene_2(){
  
   //Masukkin Audio
   if (!player_2.isPlaying()) {
    player_2.play();
  }
  background(#87CEEB); // Warna Latar 
  noStroke();
  
  //Ukuran matahari
  fill(255, 238, 0);
   ellipse(1315, 190, 200, 200);
  // Gambar awan
  for (int i = 0; i < cloudX_2.length; i++) {
    drawCloud_2(cloudX_2[i], cloudY_2[i], cloudSize_2[i]);
    cloudX_2[i] -= cloudSpeed_2;
    if (cloudX_2[i] < -200) { // Reset posisi awan ketika keluar dari sisi kiri
      cloudX_2[i] = width + 200;
    }
  }

  // Gambar laut
  fill(0, 102, 153); // Warna biru laut
  rect(0, 450, width, 540); // Laut
  float waveMovement_2 = 20 * sin(waveOffset_2 * 0.06);
  rect(0, 600 + waveMovement_2, width, 540); // Laut dengan pergerakan

  // Gambar laut dengan animasi ombak
  oceanwater_2(0.002, -0.06, 600 + waveMovement_2, 1140); // Skala gelombang
  oceanwater_2(0.001, 0, 600 + waveMovement_2, 1140); // Skala gelombang
  oceanwater_2(0.0014, 0, 600 + waveMovement_2, 1140);
  oceanwater_2(0.0006, 0.4, 600 + waveMovement_2, 1140);
  oceanwater_2(0.0018, 0.2, 600 + waveMovement_2, 1140);

  // Gambar pasir
  fill(255, 178, 102); // Warna pasir
  rect(0, 650, width, 700); // Pasir
  
  // Update waveOffset untuk animasi
  waveOffset_2 += 0.5; // Skala kecepatan pergeseran
  // Menggerakkan dan menampilkan karakter
  if (characterX_2 < 230) { // Menggerakkan karakter sampai x = 230
    characterX_2 += characterSpeed_2;
  }
  drawCharacter_2((int)characterX_2, 680);

  //Rumput
   drawGrass(900);
   
  //Batu Besar
  fill(112, 128, 114); // Warna Abu
  // Menggambar setengah lingkaran menghadap ke atas di posisi berbeda
  arc(400, 900, 150, 170, PI, TWO_PI); // Setengah lingkaran di atas pasir
  
  //Batu Kecil
   fill(112, 128, 114); // Warna Abu
  // Menggambar setengah lingkaran menghadap ke atas di posisi berbeda
   arc(510, 900, 90, 110, PI, TWO_PI); // Setengah lingkaran di atas pasir
    
      // Menggambar sampah berserakan
  fill(165, 42, 42); // Warna merah bata untuk beberapa potongan sampah
  rect(100, 800, 30, 10); // Sampah 1
  rect(200, 850, 40, 15); // Sampah 2
  rect(300, 780, 20, 8); // Sampah 3
  rect(400, 820, 25, 12); // Sampah 4

  fill(169, 169, 169); // Warna abu-abu gelap untuk sampah lainnya
  ellipse(150, 830, 15, 15); // Sampah 5
  ellipse(250, 790, 20, 20); // Sampah 6
  ellipse(350, 810, 18, 18); // Sampah 7
  ellipse(450, 850, 22, 22); // Sampah 8

  fill(255, 215, 0); // Warna emas untuk sampah lainnya
  triangle(120, 840, 130, 820, 140, 840); // Sampah 9
  triangle(220, 860, 230, 840, 240, 860); // Sampah 10
  triangle(320, 800, 330, 780, 340, 800); // Sampah 11
  triangle(420, 830, 430, 810, 440, 830); // Sampah 12
    
   
  
}
void drawGrass(int grassY) {
  fill(34, 139, 34); // Warna rumput hijau
  // Menggambar rumput secara manual di belakang batu
  triangle(250, grassY, 255, grassY - 40, 260, grassY); // Rumput 1
  triangle(260, grassY, 265, grassY - 60, 270, grassY); // Rumput 2
  triangle(270, grassY, 275, grassY - 50, 280, grassY); // Rumput 3
  triangle(280, grassY, 285, grassY - 70, 290, grassY); // Rumput 4
  triangle(290, grassY, 295, grassY - 60, 300, grassY); // Rumput 5
  triangle(300, grassY, 305, grassY - 50, 310, grassY); // Rumput 6
  triangle(310, grassY, 315, grassY - 70, 320, grassY); // Rumput 7
  triangle(320, grassY, 325, grassY - 80, 330, grassY); // Rumput 8
  triangle(330, grassY, 335, grassY - 60, 340, grassY); // Rumput 9
  triangle(340, grassY, 345, grassY - 50, 350, grassY); // Rumput 10
  
}

void oceanwater_2(float scale, float dist, float startY, float endY) {
  float x_ocean = waveOffset_2 * scale * 10; // Sesuaikan skala dengan waveOffset_1
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

void drawCloud_2(float x, float y, float size) {
  fill(255);
  noStroke();
  ellipse(x - size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x + size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x, y - size * 0.25, size * 0.75, size * 0.75);
  ellipse(x - size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x + size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x, y + size * 0.25, size * 0.5, size * 0.5); // Ellipse tambahan di bawah untuk menutupi space
}


void drawCharacter_2(int x, int y) {
  // Ubah warna wajah menjadi merah jika karakter mencapai posisi x = 200
  if (x >= 200) {
    fill(255, 0, 0); // Warna merah
  } else {
    fill(255, 224, 189); // Warna kulit
  }
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
