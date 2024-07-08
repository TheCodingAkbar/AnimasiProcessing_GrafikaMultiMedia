import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

float x_1 = 1314; // Skala x1
float y_1 = 1980; // Skala y1
float kecepatanNaik_1 = 10; // Skala kecepatanNaik_1
float batasNaik_1 = 198; // Skala batasNaik_1
float waveOffset_1 = 0;

float[] cloudX_1 = {400, 1000, 1600, 2200}; // Skala cloudX_1
float[] cloudY_1 = {200, 300, 140, 240}; // Skala cloudY_1
float[] cloudSize_1 = {120, 160, 100, 180}; // Skala cloudSize_1
float cloudSpeed_1 = 1.5; // Skala cloudSpeed_1
Daun daun = new Daun(150,250);

int characterX_1 = -100; // Posisi awal karakter di luar layar (kiri)
float characterSpeed_1 = 2; // Kecepatan gerak karakter

void scene_1(){
  //Masukkin Audio
   if (!player_1.isPlaying()) {
    player_1.play();
  }
  background(#87CEEB); // Warna Latar 
  noStroke();
  // Matahari naik
  fill(255, 238, 0);
  if (y_1 > batasNaik_1) {
    y_1 -= kecepatanNaik_1;
  }
  circle(x_1, y_1, 200); // Skala ukuran matahari
  
  // Gambar awan
  for (int i = 0; i < cloudX_1.length; i++) {
    drawCloud_1(cloudX_1[i], cloudY_1[i], cloudSize_1[i]);
    cloudX_1[i] -= cloudSpeed_1;
    if (cloudX_1[i] < -200) { // Reset posisi awan ketika keluar dari sisi kiri
      cloudX_1[i] = width + 200;
    }
  }

  // Gambar laut
  fill(0, 102, 153); // Warna biru laut
  rect(0, 450, width, 540); // Laut
  float waveMovement_1 = 20 * sin(waveOffset_1 * 0.06);
  rect(0, 600 + waveMovement_1, width, 540); // Laut dengan pergerakan

  // Gambar laut dengan animasi ombak
  oceanwater_1(0.002, -0.06, 600 + waveMovement_1, 1140); // Skala gelombang
  oceanwater_1(0.001, 0, 600 + waveMovement_1, 1140); // Skala gelombang
  oceanwater_1(0.0014, 0, 600 + waveMovement_1, 1140);
  oceanwater_1(0.0006, 0.4, 600 + waveMovement_1, 1140);
  oceanwater_1(0.0018, 0.2, 600 + waveMovement_1, 1140);

  // Gambar pasir
  fill(255, 178, 102); // Warna pasir
  rect(0, 650, width, 700); // Pasir
  
  // Update waveOffset untuk animasi
  waveOffset_1 += 0.5; // Skala kecepatan pergeseran
  
    // Gerakkan dan tampilkan karakter
  characterX_1 += characterSpeed_1;
  if (characterX_1 > width) { // Mengembalikan karakter ke kiri ketika keluar dari layar
    characterX_1 = -100;
  }
  drawCharacter1((int)characterX_1, 600); // Memanggil karakter dengan posisi baru di atas pasir
  
  // Pohon kelapa
  fill(#6C3625);
  beginShape();
  vertex(0, 1080);
  bezierVertex(50, 700, 50, 300, 150, 250);
  bezierVertex(100, 200, 50, 300, 0, 500);
  endShape();
   
  // Gambar daun
  daun.move();
  daun.show(20, true, 0.1);
  daun.show(50, true, 0.2);
  daun.show(-25, true, 0.3);
  daun.show(-10, false, 0.4);
  daun.show(40, false, 0.5);
 
}

void drawLeaf(float x, float y, float offset, boolean flip, float scale) {
  pushMatrix();
  translate(x, y); // Posisi daun di pohon kelapa
  if (flip) {
    scale(-scale, scale);
  } else {
    scale(scale);
  }
  fill(#228B22);
  beginShape();
  vertex(0, 0);
  bezierVertex(-50, -50, -50, -200, 0, -240);
  bezierVertex(50, -200, 50, -50, 0, 0);
  endShape(CLOSE);
  popMatrix();
}

void oceanwater_1(float scale, float dist, float startY, float endY) {
  float x_ocean = waveOffset_1 * scale * 10; // Sesuaikan skala dengan waveOffset_1
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

void drawCloud_1(float x, float y, float size) {
  fill(255);
  noStroke();
  ellipse(x - size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x + size * 0.25, y, size * 0.5, size * 0.5);
  ellipse(x, y - size * 0.25, size * 0.75, size * 0.75);
  ellipse(x - size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x + size * 0.5, y + size * 0.1, size * 0.6, size * 0.6);
  ellipse(x, y + size * 0.25, size * 0.5, size * 0.5); // Ellipse tambahan di bawah untuk menutupi space
}

void drawCharacter1(int x, int y) {
  // Karakter 1 (mirip dengan gambar yang Anda unggah)
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
