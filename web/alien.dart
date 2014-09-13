part of dartinvaders;

class Alien extends Sprite {
    static const WIDTH = 80;
    static const HEIGHT = 80;
    static const String IMAGE_NAME = "images/alien.png";
    int frameCount = 0;
    
    Alien(int x, int y) : super(WIDTH, HEIGHT, x, y, IMAGE_NAME);
    
    // move every 60 frames/s
    void update() {
        frameCount++;
        if (frameCount % 60 == 0) {
            move(0, 1); // move down, 1 tile
        }
    }
}