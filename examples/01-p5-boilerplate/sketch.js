// libs
// p5.js + p5.sound.js (docs: https://p5js.org/reference/)
// controller.js (link: https://samiare.github.io/Controller.js/ docs: https://github.com/samiare/Controller.js/wiki)

// window.addEventListener('gc.controller.found', (event) => {
//     console.log('controller found', event);
// });
// window.addEventListener('gc.analog.change', handleSlider);
// window.addEventListener('gc.button.press', handleButton);
// window.addEventListener('gc.button.release', handleButton);

// function handleSlider(event) {
//     const { name, position } = event.detail;
//     console.log('slider', name, position, event);
// }

// function handleButton(event) {
//     const { name, pressed } = event.detail;
//     console.log('button', name, pressed, event.detail);
// }

class Item {
    constructor() {

        // setup functions
        this.render = () => { }
    }
    setRender(render) {
        this.render = render
        return this
    }
    update() {

        push()
        this.render()
        pop()

    }
}

const items = []
function addItem(items) {
    const item = new Item()
    items.push(item)
    return item
}

function setup() {
    // Controller.search();
    document.title = 'GCP Gamepad boilerplate';
    createCanvas(windowWidth, windowHeight);

    addItem(items)
        .setRender(() => {
            rect(0, 0, 100, 100)
            rect(50, 50, 100, 100)
        })
}

function draw() {
    background(220);

    items.forEach(item => {
        item.update()
    })
}

function windowResized() {
    resizeCanvas(windowWidth, windowHeight);
}
