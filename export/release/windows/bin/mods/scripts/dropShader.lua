function onCreatePost()
    addHaxeLibrary("DropShadowShader")

    runHaxeCode([[
        // BF shader setup
        var bfRim = new DropShadowShader();
        bfRim.setAdjustColor(-20, 0, 0, 5);
        bfRim.color = 0xFF5F5F00;
        bfRim.attachedSprite = game.boyfriend;
        bfRim.angle = 100;
        game.boyfriend.shader = bfRim;
        game.boyfriend.animation.callback = function(name, frameNum, frameIndex) {
            bfRim.updateFrameInfo(game.boyfriend.frame);
        };

        // Dad shader setup
        var dadRim = new DropShadowShader();
        dadRim.setAdjustColor(-20, 0, 0, 5);
        dadRim.color = 0xFF5F5F00;
        dadRim.attachedSprite = game.dad;
        dadRim.angle = 50;
        game.dad.shader = dadRim;
        game.dad.animation.callback = function(name, frameNum, frameIndex) {
            dadRim.updateFrameInfo(game.dad.frame);
        };

        // GF shader setup
        var gfRim = new DropShadowShader();
        gfRim.setAdjustColor(-20, 0, 0, 5);
        gfRim.color = 0xFF5F5F00;
        gfRim.attachedSprite = game.gf;
        gfRim.angle = 90;
        game.gf.shader = gfRim;
        game.gf.animation.callback = function(name, frameNum, frameIndex) {
            gfRim.updateFrameInfo(game.gf.frame);
        };
    ]])
end
