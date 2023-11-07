// libs
// p5.js + p5.sound.js (docs: https://p5js.org/reference/)
// controller.js (link: https://samiare.github.io/Controller.js/ docs: https://github.com/samiare/Controller.js/wiki)

// sketch
let eyeRad = 80, eyeSize = eyeRad * 2;
let browSize = eyeSize * 1.2, browFactor;
let irisRad = 42, irisSize = irisRad * 2;
let pupilPosX = 0, pupilPosY = 0, pupilSize;
let lidPos, restLid = Math.PI * 0.3, minLid = restLid / 1.5, maxLid = Math.PI * 0.92;

// rough controls
let buttonX;
let stickRightY = 0;
let stickLeftY = 0;
let stickLeftX = 0;

// video
let cam

// audio
let sound

window.addEventListener('gc.controller.found', (event) => {
    sound.loop();
});
window.addEventListener('gc.analog.change', handleSlide);
window.addEventListener('gc.button.press', handleButton);
window.addEventListener('gc.button.release', handleButton);

function handleSlide(event) {
    const { name, position } = event.detail;
    switch (name) {
        case 'RIGHT_ANALOG_STICK':
            stickRightY = position.y;
            break;
        case 'LEFT_ANALOG_STICK':
            stickLeftY = position.y;
            stickLeftX = position.x;
            break;
    }
}

function handleButton(event) {
    const { name, pressed } = event.detail;
    switch (name) {
        case 'FACE_1':
            buttonX = pressed;
            break;
    }
}


function setup() {
    Controller.search();
    document.title = 'GCP Gamepad example';
    createCanvas(400, 500);

    cam = createCapture(VIDEO);
    cam.hide();

    sound = createAudio('assets/sound.mp3');
}

function draw() {
    background(255, 200, 255);

    pupilSize = buttonX ? irisSize * 0.6 : irisSize * 0.45;
    pupilPosX = 0.9 * map(stickLeftX, -1, 1, -(eyeRad - irisRad), eyeRad - irisRad);
    pupilPosY = 0.9 * map(stickLeftY, -1, 1, -(eyeRad - irisRad), eyeRad - irisRad);
    lidPos = stickRightY;
    browFactor = (lidPos >= 0) ? 1 : map(lidPos, 0, -1, 1.1, 1.3);
    lidPos = map(lidPos, -0.12, 1, restLid, maxLid);
    lidPos = constrain(lidPos, minLid, maxLid);

    image(cam, 0, 250, 400, 250);
    drawEye(100, 125);
    drawEye(300, 125);
}

function drawEye(x, y) {
    push();
    translate(x, y);
    stroke(0, 96, 0);
    strokeWeight(3);
    fill(255);
    ellipse(0, 0, eyeSize, eyeSize);
    noStroke();
    fill(120, 100, 220);
    ellipse(pupilPosX, pupilPosY, irisSize, irisSize);
    fill(32);
    ellipse(pupilPosX, pupilPosY, pupilSize, pupilSize);
    stroke(0, 96, 0);
    strokeWeight(4);
    fill(220, 160, 220);
    arc(0, 0, eyeSize, eyeSize, 1.5 * PI - lidPos, 1.5 * PI + lidPos, CHORD);
    stroke(100, 100, 10);
    strokeWeight(10);
    noFill();
    arc(0, 0, browSize, browSize * browFactor, 1.2 * PI, 1.8 * PI);
    pop();
}