//
import modchart.Manager;

var manager:Manager;

function onCreatePost() {
	manager = new Manager();
	add(manager);
	manager.addModifier("transform");
	manager.setPercent("dizzySpeed", 2);
	grpNoteSplashes.visible = false;
}

function onUpdate(elapsed:Float) {
	if (curBeat < 32 || curBeat >= 144)
		manager.setPercent("dizzy", 1);
	else
		manager.setPercent("dizzy", 0);

	if (curBeat >= 96 && curBeat < 160) {
		for (lane in 0...4) {
			var intensity:Float = Math.pow(con_sin((curDecBeat / (curBeat >= 144 ? 2 : 4))), 3) * 40 * (lane % 2 ? 1 : -1);
			// strum.y = defaultY + intensity;
			manager.setPercent("y" + lane, intensity);
		}
	}
	if (curBeat >= 160 && curBeat < 164) {
		for (lane in 0...4)
			manager.setPercent("y" + lane, 0);
	}
}

var boolSwap:Bool = false;
function onBeatHit() {
	if (curBeat >= 16 && curBeat <= 32) {
		manager.set("yd", curBeat, (curBeat % 2 == 0 ? 30 : -30), 1);
		manager.set("yd", curBeat, (curBeat % 2 == 0 ? -30 : 30), 0);
		manager.ease("yd", curBeat, 1, 0, FlxEase.quadOut);
	}

	if (curBeat >= 32 && curBeat < 96) {
		if (curBeat % 4 == 0 || curBeat % 4 == 3) {
			boolSwap = !boolSwap;
			for (lane in 0...4){
				var intensityX:Float = lane * (boolSwap ? 10 : -10);
				manager.set("y"+lane, curBeat, FlxG.random.int(-25, 25, [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]) * 2);
				manager.set("x"+lane, curBeat, intensityX);
				manager.ease("y"+lane, curBeat, (curBeat % 4 == 0 ? 1.5 : 1.25), 0, FlxEase.quadOut);
				manager.ease("x"+lane, curBeat, (curBeat % 4 == 0 ? 1.5 : 1.25), 0, FlxEase.quadOut);
			}
		}
	}
}

function con_sin(x:Float):Float {
	return Math.sin((x % 1) * 2 * Math.PI);
}
