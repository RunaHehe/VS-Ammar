//
import modchart.Manager;

var manager:Manager;

function onCreatePost() {
	manager = new Manager();
	add(manager);
	grpNoteSplashes.visible = false;

	defineMods();
	initModSetup();
	initmod();
}

function defineMods() {
	manager.addModifier("transform");
	manager.addModifier("fieldRotate");
	manager.addModifier("opponentSwap");
}

function initModSetup() {
	manager.setPercent("x", -320, 1);
	manager.setPercent("y", -720, 1);
	manager.setPercent("x", 320, 0);
	manager.setPercent("alpha", 0.5, 0);
}

var boolSwap = false;

function initmod() {
	for (mod in ["x", "y"])
		manager.ease(mod, 14, 4, 0, FlxEase.quadInOut);
	manager.ease("alpha", 14, 4, 1);

	manager.ease("y2", 32, 0.5, -40, FlxEase.quadOut, 0);
	manager.ease("y2", 32 + 0.5, 0.5, 0, FlxEase.quadIn, 0);

	manager.ease("fieldRotateX", 40, 0.5, -30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 40 + 0.5, 0.5, 0, FlxEase.quadOut);
	manager.ease("fieldRotateX", 41, 0.5, 30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 41 + 0.5, 0.5, 0, FlxEase.quadOut);

	manager.ease("fieldRotateX", 42, 0.5, -30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 42 + 0.5, 0.5, 0, FlxEase.quadOut);
	manager.ease("fieldRotateY", 43, 0.5, 75, FlxEase.quadOut);
	manager.ease("fieldRotateY", 43 + 0.5, 0.5, 0, FlxEase.quadOut);

	manager.ease("fieldRotateX", 44, 0.5, -30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 44 + 0.5, 0.5, 0, FlxEase.quadOut);
	manager.ease("fieldRotateY", 45, 0.5, -75, FlxEase.quadOut);
	manager.ease("fieldRotateY", 45 + 0.5, 0.5, 0, FlxEase.quadOut);

	manager.ease("fieldRotateX", 46, 0.5, -30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 46 + 0.5, 0.5, 0, FlxEase.quadOut);
	manager.ease("fieldRotateX", 47, 0.5, 30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 47 + 0.5, 0.5, 0, FlxEase.quadOut);

	manager.ease("y2", 48, 0.5, -40, FlxEase.quadOut, 1);
	manager.ease("y2", 48 + 0.5, 0.5, 0, FlxEase.quadIn, 1);

	manager.ease("fieldRotateX", 56, 0.5, -30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 56 + 0.5, 0.5, 0, FlxEase.quadOut);
	manager.ease("fieldRotateX", 57, 0.5, 30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 57 + 0.5, 0.5, 0, FlxEase.quadOut);

	manager.ease("fieldRotateX", 58, 0.5, -30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 58 + 0.5, 0.5, 0, FlxEase.quadOut);
	manager.ease("fieldRotateY", 59, 0.5, 75, FlxEase.quadOut);
	manager.ease("fieldRotateY", 59 + 0.5, 0.5, 0, FlxEase.quadOut);

	manager.ease("fieldRotateX", 60, 0.5, -30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 60 + 0.5, 0.5, 0, FlxEase.quadOut);
	manager.ease("fieldRotateY", 61, 0.5, -75, FlxEase.quadOut);
	manager.ease("fieldRotateY", 61 + 0.5, 0.5, 0, FlxEase.quadOut);

	manager.ease("fieldRotateX", 62, 0.5, -30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 62 + 0.5, 0.5, 0, FlxEase.quadOut);
	manager.ease("fieldRotateX", 63, 0.5, 30, FlxEase.quadOut);
	manager.ease("fieldRotateX", 63 + 0.5, 0.5, 0, FlxEase.quadOut);

    manager.set("alpha", 192, 0.5, 0);
    manager.set("opponentSwap", 192, 0.5);

    manager.ease("fieldRotateZ", 256, 4, 0, FlxEase.sineInOut);
    manager.ease("alpha", 256, 4, 0, FlxEase.sineInOut);
    manager.ease("x", 256, 4, 0, FlxEase.sineInOut);
    manager.ease("z", 256, 4, 0, FlxEase.sineInOut);
    manager.ease("opponentSwap", 256, 4, 0, FlxEase.sineInOut);
}

function onBeatHit() {
	if (curBeat >= 64 && curBeat < 192) {
		if (curBeat % 2 == 0) {
			boolSwap = !boolSwap;
			manager.ease("fieldRotateZ", curBeat, 1, (boolSwap ? 30 : -30), FlxEase.quadOut);
		}
	}
    if (curBeat >= 192 && curBeat < 256) {
		if (curBeat % 2 == 0) {
			boolSwap = !boolSwap;
			manager.ease("fieldRotateZ", curBeat, 1, (boolSwap ? 30 : -30), FlxEase.quadOut,1);
			manager.ease("fieldRotateZ", curBeat, 1, (boolSwap ? -30 : 30), FlxEase.quadOut,0);
		}
	}
}

function onUpdate(elapsed){
    if (curBeat >= 192 && curBeat < 256){
        manager.setPercent("x", continuous_sin(curDecBeat / 8) * 300, 1);
        manager.setPercent("x", continuous_sin((curDecBeat) / 8 + 0.5) * 300, 0);
        manager.setPercent("z", -100 + continuous_cos(curDecBeat / 8) * 200, 1);
        manager.setPercent("z", -(100 + continuous_cos((curDecBeat) / 8 + 500) * 200), 0);
    }
}

function continuous_sin(x)
    return Math.sin((x % 1) * 2 * Math.PI);
function continuous_cos(x)
    return Math.cos((x % 1) * 2 * Math.PI);
