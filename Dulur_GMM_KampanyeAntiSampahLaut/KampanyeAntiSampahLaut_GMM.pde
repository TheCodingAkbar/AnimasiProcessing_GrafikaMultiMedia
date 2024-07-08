import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int t = 1;
PFont f;

Minim minim; 
AudioPlayer player_1;
AudioPlayer player_2;
AudioPlayer player_3;
AudioPlayer player_4_1;
AudioPlayer player_4_2;
//AudioPlayer player_5_2;
//AudioPlayer player_5_3;
//AudioPlayer player_5_4;
//AudioPlayer player_5_5;
//AudioPlayer player_5_6;
//AudioPlayer player_5_7;
//AudioPlayer player_5_8;
//AudioPlayer player_5_9;
//AudioPlayer player_5_10;
//AudioPlayer player_5_11;
//AudioPlayer player_5_12;
//AudioPlayer player_5_13;
AudioPlayer[] scene5Audios = new AudioPlayer[12] ;
AudioPlayer player_6;
AudioPlayer player_6_1;
AudioPlayer player_6_2;


boolean scene_4_1_played = false; // Status apakah audio scene_4_1 sudah diputar
boolean scene_4_2_played = false; // Status apakah audio scene_4_2 sudah diputar

boolean[] audioPlayed = new boolean[12]; // Status apakah audio sudah diputar

int currentAudioIndex = 0; // Index audio yang sedang diputar
boolean player6Finished = false; // Untuk melacak apakah player_6 sudah selesai diputar
boolean player6_1Started = false; // Untuk melacak apakah player_6_1 sudah mulai diputar
boolean player6_2Started = false; // Untuk melacak apakah player_6_2 sudah mulai diputar

void setup() {
  size(1920, 1080);
  minim = new Minim(this);
  player_1 = minim.loadFile("Scene_1.mp3");
  player_2 = minim.loadFile("Scene_2.mp3");
  player_3 = minim.loadFile("Scene_3.mp3");
  player_4_1 = minim.loadFile("Scene_4_1.mp3");
  player_4_2 = minim.loadFile("Scene_4_2.mp3");
  //player_5_2 = minim.loadFile("Scene_5_2.mp3");
  //player_5_3 = minim.loadFile("Scene_5_3.mp3");
  //player_5_4 = minim.loadFile("Scene_5_4.mp3"); 
  //player_5_5 = minim.loadFile("Scene_5_5.mp3"); 
  //player_5_6 = minim.loadFile("Scene_5_6.mp3"); 
  //player_5_7 = minim.loadFile("Scene_5_7.mp3"); 
  //player_5_8 = minim.loadFile("Scene_5_8.mp3"); 
  //player_5_9 = minim.loadFile("Scene_5_9.mp3"); 
  //player_5_10 = minim.loadFile("Scene_5_10.mp3"); 
  //player_5_11 = minim.loadFile("Scene_5_11.mp3"); 
  //player_5_12 = minim.loadFile("Scene_5_12.mp3"); 
  //player_5_13 = minim.loadFile("Scene_5_13.mp3"); 
   for (int i = 0; i < 12; i++) {
    scene5Audios[i] = minim.loadFile("Scene_5_" + (i + 2) + ".mp3");
    audioPlayed[i] = false;
  }
   player_6 = minim.loadFile("Scene_6.mp3");
   player_6_1 = minim.loadFile("Scene_6_1.mp3");
   player_6_2 = minim.loadFile("Scene_6_2.mp3");
 

  f = createFont("Arial Bold", 1, true);
}

void draw() {
  int t = millis() / 1000; // Menghitung waktu dalam detik
  
   //Scene_1 20
   //Scene_2 17
   //Scene_3 11
   //Scene_4 35
   //Scene_5 82
   //Scene_6
  
  // Time 0-20 detik tampilkan scene 1
  if (t >= 0 && t < 90) {
    scene_6();
  }
  // Time 20-33 detik tampilkan scene 2
  else if (t >= 40 && t < 53) {
    scene_2();
  }
  // Time 33-45 detik tampilkan scene 3
  else if (t >= 63 && t < 75) {
    scene_3();
  }
  // Time 45-61 detik tampilkan scene 4
  else if (t >= 75 && t < 81) {
    scene_4 ();
  }
  // Time 61-65 detik tampilkan scene 5
  else if (t >= 91 && t < 95) {
    scene_5();
  }
  // Time 65-90 detik tampilkan scene 6
  else if (t >= 95 && t < 100) {
    scene_6();
  }
  // Time 90-110 detik tampilkan scene 7
  else if (t >= 100 && t < 110) {
    scene_7();
  }
  // Time 110-140 detik tampilkan scene 8
  else if (t >= 110 && t < 140) {
    scene_8();
  }

  fill(0);
  textFont(f, 50);
  text(t, width / 2.2, height / 6);

  if (t >= 140) {
    exit();
  }
}
