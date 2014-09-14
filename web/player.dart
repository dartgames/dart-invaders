part of dartinvaders;

class Player extends Sprite {
    static const int WIDTH = 35;
    static const int HEIGHT = 35;
    static const String IMAGE_NAME = "images/player.png";
    
    Player(int x, int y) : super(WIDTH, HEIGHT, x, y, IMAGE_NAME);
    
    void update() {
        return;
    }
}