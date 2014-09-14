part of dartinvaders;

class Bullet extends Sprite {
    static const int WIDTH = 15;
    static const int HEIGHT = 15;
    static const String PLAYER_BULLET = "images/bullet.png";
    static const String ALIEN_BULLET = "images/bullet_down.png";
    bool down;
    
    Bullet(int x, int y, this.down) : super(WIDTH, HEIGHT, x, y, PLAYER_BULLET);
    
    void update() {
        if (down) {
            image.src = ALIEN_BULLET; 
            move(0, 1);
        } else {
            move(0, -1);
        }
    }
    
    bool checkCollision(Sprite s) {
        if (boundingBox.intersection(s.boundingBox) != null) {
            return true;
        }
        return false;
    }
}