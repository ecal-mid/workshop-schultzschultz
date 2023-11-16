// libs
// p5.js + p5.sound.js (docs: https://p5js.org/reference/)
// controller.js (link: https://samiare.github.io/Controller.js/ docs: https://github.com/samiare/Controller.js/wiki)

window.addEventListener('gc.controller.found', (event) => {
    console.log('controller found', event);
});
window.addEventListener('gc.analog.change', handleSlider);
window.addEventListener('gc.button.press', handleButton);
window.addEventListener('gc.button.release', handleButton);

function handleSlider(event) {
    const { name, position } = event.detail;
    console.log('slider', name, position, event);
}

function handleButton(event) {
    const { name, pressed } = event.detail;
    console.log('button', name, pressed, event.detail);
}

function setup() {
    Controller.search();
    document.title = 'GCP Gamepad boilerplate';
    createCanvas(400, 500);
}

function draw() {
    background(220);
}
