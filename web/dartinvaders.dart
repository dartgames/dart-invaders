library dartinvaders;

import 'dart:html';
import 'dart:async';

part 'sprite.dart';
part 'bullet.dart';

const String BACKGROUND = "images/background.png";

CanvasElement canvas;

ImageElement background;

void update(Timer t) {
    draw();
}

void init() {
    background = new ImageElement();
    background.src = BACKGROUND;
}

void draw() {
    CanvasRenderingContext2D canvasContext = canvas.context2D;
    
    canvasContext.drawImage(background, 0, 0);
}

void main() {
    canvas = querySelector("#dartInvaders");
    
    init();
    
    Timer t = new Timer.periodic(const Duration(milliseconds: 17), update);
}
