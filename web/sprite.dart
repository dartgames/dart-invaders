part of dartinvaders;

abstract class Sprite {
    int width;
    int height;
    int x;
    int y;
    
    ImageElement image;
    Rectangle boundingBox; // collisions
    
    Sprite(this.width, this.height, this.x, this.y, String imageName) {
        image = new ImageElement();
        image.src = imageName;
        boundingBox = new Rectangle(x, y, width, height);
    }
    
    // draw [image] in the canvas 
    void draw(CanvasRenderingContext2D canvasContext) {
        canvasContext.drawImageScaled(image, x, y, width, height);
    }
    
    // move [dx] in x direction, [dy] in y direction
    void move(int dx, int dy) {
        x += dx;
        y += dy;
        boundingBox = new Rectangle(x, y, width, height);
    }
    
    void update();
}