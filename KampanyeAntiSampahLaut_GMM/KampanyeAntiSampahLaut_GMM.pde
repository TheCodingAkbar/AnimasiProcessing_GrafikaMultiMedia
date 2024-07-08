import processing.svg.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//int t = 1;
//PFont f;

Minim minim;
AudioPlayer player_1;
AudioPlayer player_2;
AudioPlayer player_3;
AudioPlayer player_4_1;
AudioPlayer player_4_2;
AudioPlayer[] scene5Audios = new AudioPlayer[12];
AudioPlayer player_6;
AudioPlayer player_6_1;
AudioPlayer player_6_2;
AudioPlayer player_7;
AudioPlayer player_8;


boolean scene_4_1_played = false; // Status apakah audio scene_4_1 sudah diputar
boolean scene_4_2_played = false; // Status apakah audio scene_4_2 sudah diputar
boolean[] audioPlayed = new boolean[12]; // Status apakah audio sudah diputar
int currentAudioIndex = 0; // Index audio yang sedang diputar

PImage sampah; // Deklarasi variabel untuk gambar sampah


void setup() {
  size(1920, 1080);
  sampah = loadImage("sampah.png"); // Memuat gambar sampah
  minim = new Minim(this);
  player_1 = minim.loadFile("Scene_1.mp3");
  player_2 = minim.loadFile("Scene_2.mp3");
  player_3 = minim.loadFile("Scene_3.mp3");
  player_4_1 = minim.loadFile("Scene_4_1.mp3");
  player_4_2 = minim.loadFile("Scene_4_2.mp3");
  for (int i = 0; i < 12; i++) {
    scene5Audios[i] = minim.loadFile("Scene_5_" + (i + 2) + ".mp3");
    audioPlayed[i] = false;
  }
  player_6 = minim.loadFile("Scene_6.mp3");
  player_6_1 = minim.loadFile("Scene_6_1.mp3");
  player_6_2 = minim.loadFile("Scene_6_2.mp3");
  player_7 = minim.loadFile("Scene_7.mp3");
  player_8 = minim.loadFile("Scene_8.mp3");
  //f = createFont("Arial Bold", 1, true);
}

void draw() {
  int t = millis() / 1000; // Menghitung waktu dalam detik
  
  // Time 0-20 detik tampilkan scene 1
  if (t >= 0 && t < 20) {
    scene_1();
  }
  // Time 20-37 detik tampilkan scene 2
  else if (t >= 20 && t < 37) {
    scene_2();
  }
  // Time 37-48 detik tampilkan scene 3
  else if (t >= 37 && t < 48) {
    scene_3();
  }
  // Time 45-83 detik tampilkan scene 4
  else if (t >= 48 && t < 83) {
    scene_4();
  }
  // Time 83-165 detik tampilkan scene 5
  else if (t >= 83 && t < 165) {
    scene_5();
  }
  // Time 165-202 detik tampilkan scene 6
  else if (t >= 165 && t < 202) {
    scene_6();
  }
  // Time 202-223 detik tampilkan scene 7
  else if (t >= 202 && t < 223) {
    scene_7();
  }
  // Time 223-247 detik tampilkan scene 8
  else if (t >= 223 && t < 247) {
    scene_8();
  }

  //fill(0);
  //textFont(f, 50);
  //text(t, width / 2.2, height / 6);

  if (t >= 247) {
    exit();
  }
}
