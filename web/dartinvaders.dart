library dartinvaders;

import 'dart:html';
import 'dart:math';
import 'dart:async';

part 'sprite.dart';
part 'bullet.dart';
part 'alien.dart';
part 'player.dart';

const String BACKGROUND = "images/background.png";
const int CANVAS_WIDTH = 500;
const int CANVAS_HEIGHT = 500;

CanvasElement canvas;

Player player;

int score = 0;

List<Alien> aliens;
List<Bullet> alienBullets;
List<Bullet> playerBullets;

ImageElement background;

Timer t;

void update(Timer t) {
    player.update();
    
    for (Alien alien in aliens) {
        alien.update();
        // random alien bullets
        Random r = new Random();
        int randomNumber = r.nextInt(2000);
        
        if (randomNumber == 100) {
            alienBullets.add(new Bullet(alien.x + Alien.WIDTH ~/ 2 - Bullet.WIDTH ~/ 2, alien.y + Alien.HEIGHT, true));
        }
    }
    
    List deletedBullets = new List();
    
    for (Bullet bullet in alienBullets) {
        bullet.update();
        if (bullet.y > CANVAS_HEIGHT) {
            deletedBullets.add(bullet);
            continue;
        }
        
        if (bullet.checkCollision(player)) {
            t.cancel(); // stop the game
            window.alert("Game over! Final score: $score");
            deletedBullets.add(bullet);
            window.location.reload();
        }
    }
    
    for (Bullet bullet in deletedBullets) {
        alienBullets.remove(bullet);
    }
    
    deletedBullets.clear();
    
    List deletedAliens = new List();
    
    for (Bullet bullet in playerBullets) {
        bullet.update();
        
        if (bullet.y < 0) {
            deletedBullets.add(bullet);
            continue;
        }
        
        for (Alien alien in aliens) {
            if (bullet.checkCollision(alien)) {
                deletedBullets.add(bullet);
                deletedAliens.add(alien);
                score++;
            }
        }
    }
    
    for (Bullet bullet in deletedBullets) {
        playerBullets.remove(bullet);
    }
    
    for (Alien alien in deletedAliens) {
        aliens.remove(alien);
        
        if (aliens.isEmpty) {
            t.cancel(); // end game
            window.alert("You win! Final score: $score");
            window.location.reload();
        }
    }

    draw();
}

void draw() {
    CanvasRenderingContext2D canvasContext = canvas.context2D;
    
    canvasContext.drawImage(background, 0, 0);
    
    String scoreText = "Score: $score";
    canvasContext.setFillColorRgb(255, 255, 255);
    canvasContext.fillText(scoreText, canvas.width - 50, canvas.height - 10);

    player.draw(canvasContext);
    
    for (Alien alien in aliens) {
        alien.draw(canvasContext);
    }
    
    for (Bullet bullet in alienBullets) {
        bullet.draw(canvasContext);
    }
    
    for (Bullet bullet in playerBullets) {
        bullet.draw(canvasContext);
    }
}

void init() {
    player = new Player(CANVAS_WIDTH ~/ 2, CANVAS_HEIGHT - Player.HEIGHT - 10);
    playerBullets = new List();

    aliens = new List();
    alienBullets = new List();
    
    const int NUM_ROWS = 3;
    const int NUM_COLUMNS = 4;
    
    for (int i = 0; i < NUM_ROWS; i++) {
        int y = i * (Alien.HEIGHT + 35);
        
        for (int j = 0; j < NUM_COLUMNS; j++) {
            int x = (CANVAS_WIDTH ~/ NUM_COLUMNS) * j + 35;
            aliens.add(new Alien(x, y));
        }
    }

    background = new ImageElement();
    background.src = BACKGROUND;
}

void main() {
    canvas = querySelector("#dartInvaders");
    
    window.onKeyPress.listen((KeyboardEvent e) {
       String lastPressed = new String.fromCharCodes([e.charCode]);
       
       switch (lastPressed) {
           case 'a':
               if (player.x > 0) {
                   player.move(-5, 0);
               }
               break;
           case 'd':
               if (player.x < CANVAS_WIDTH - Player.WIDTH) {
                   player.move(5, 0);
               }
               break;
           case ' ':
               playerBullets.add(new Bullet(player.x + Player.WIDTH ~/ 2 - Bullet.WIDTH ~/ 2, player.y - Bullet.HEIGHT, false));
       }
    });
    
    init();
    
    t = new Timer.periodic(const Duration(milliseconds: 17), update);
}
