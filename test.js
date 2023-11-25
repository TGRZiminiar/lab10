let btnL = false;
let btnR = true;
let pos = 1;

if (btnL) {
    if (pos !== 4) {
        pos = pos + 1;
    } else {
        pos = 1;
    }
} else if (btnR) {
    if (pos !== 1) {
        pos = pos - 1;
    } else {
        pos = 4;
    }
}

console.log(pos);