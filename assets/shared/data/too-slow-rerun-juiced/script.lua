exeMode = false
cinematicsMode = false

function onCreate()
    setProperty("skipCountdown", true)
    setProperty("showRating", false)
    setProperty("showComboNum", false)

    if shadersEnabled then
        initLuaShader("hotlineVHS")
        initLuaShader("brutalGlitch")

        makeLuaSprite("camShader1")
        makeLuaSprite("camShader2")

        setSpriteShader("hotlineVHS", "hotlineVHS")
        setSpriteShader("camShader2", "brutalGlitch")

        runHaxeCode([[
            FlxG.camera.setFilters([new ShaderFilter(game.getLuaObject('hotlineVHS').shader)]);
        ]])
    end
end

function onCreatePost()
    makeLuaText("lyrics", "", screenWidth, 0.0, screenHeight - 200)
    setTextAlignment("lyrics", "center")
    setTextSize("lyrics", 24)
    setTextColor("lyrics", "FF0000")
    setTextFont("lyrics", "hyakki.ttf")
    setObjectCamera("lyrics", "other")
    screenCenter("lyrics", "x")
    addLuaText("lyrics")

    makeLuaSprite("iamgod", "iamgod")
    setObjectCamera("iamgod", "other")
    screenCenter("iamgod")
    addLuaSprite("iamgod")
    setProperty("iamgod.visible", false)

    makeLuaSprite("vignette", "vignette")
    setObjectCamera("vignette", "other")
    screenCenter("vignette")
    setBlendMode("vignette", "overlay")
    addLuaSprite("vignette")
    setProperty("vignette.alpha", .1)

    setProperty("iconP1.alpha", .0)
    setProperty("iconP2.alpha", .0)
    setProperty("scoreTxt.alpha", .0)
    for i = 0, getProperty("strumLineNotes.members.length") do
        setPropertyFromGroup("strumLineNotes.members", i, "alpha", .0)
    end

    triggerEvent("Blackout", 0, 0.01)
end

---
--- @param elapsed float
---
function onUpdatePost(elapsed)
    if curBeat < 32 or cinematicsMode then
        setProperty("scoreTxt.alpha", .0)
        setProperty("timeBar.alpha", .0)
        setProperty("timeTxt.alpha", .0)
    end
    setProperty("timeBar.alpha", .0)
    setProperty("timeTxt.alpha", .0)
    setProperty("healthBar.alpha", .0)

    if exeMode then
        cameraShake("game", 0.003, 0.1)
        cameraShake("hud", 0.001, 0.1)
    end

    if shadersEnabled then
        setShaderFloat("hotlineVHS", "iTime", os.clock())
    end

    if keyboardJustPressed("R") then
        restartSong(true)
    end

    setProperty("iconP1.scale.x", 1.0)
    setProperty("iconP1.scale.y", 1.0)
    setProperty("iconP2.scale.x", 1.0)
    setProperty("iconP2.scale.y", 1.0)
end

function onBeatHit()
    if curBeat == 32 then
        doTweenAlpha("ewfwefefdew", "iconP1", 1.0, 3.0 / playbackRate, "linear")
        doTweenAlpha("dqdqdqw", "iconP2", 1.0, 3.0 / playbackRate, "linear")
        doTweenAlpha("cwdervre", "scoreTxt", 1.0, 3.0 / playbackRate, "linear")
        doTweenAlpha("fwefwefe", "timeBar", 1.0, 3.0 / playbackRate, "linear")
        doTweenAlpha("fewfwefew", "timeTxt", 1.0, 3.0 / playbackRate, "linear")
        for i = 0, getProperty("strumLineNotes.members.length") do
            doTweenAlpha("fwfrwrg" .. i, "strumLineNotes.members[" .. i .. "]", 1.0, 3.0, "linear")
        end
    elseif curBeat == 464 then
        if shadersEnabled then
            runHaxeCode("game.camOther.setFilters([new ShaderFilter(game.getLuaObject('camShader2').shader)]);")
        end
        vignette(1)
    elseif curBeat == 526 then
        setProperty("iamgod.visible", true)
    elseif curBeat == 536 then
        cameraFade("other", "000000", 0.01, true)
    end
end

function onStepHit()
    if curStep == 1206 then
        lyrics('魂')
    elseif curStep == 1212 then
        lyrics('と')
    elseif curStep == 1214 then
        lyrics('遊ぶ')
    elseif curStep == 1216 then
        lyrics('時間が')
    elseif curStep == 1224 then
        lyrics('と', true)
        setTextSize("lyrics", 32)
    elseif curStep == 1226 then
        lyrics('て')
    elseif curStep == 1228 then
        lyrics('も')
    elseif curStep == 1232 then
        lyrics('少な')
    elseif curStep == 1234 then
        lyrics('い。')
    elseif curStep == 1240 then
        lyrics('', true)
        setTextSize('lyrics', 24)
    elseif curStep == 1244 then
        lyrics('そう')
    elseif curStep == 1250 then
        lyrics('思わ')
    elseif curStep == 1252 then
        lyrics('ない')
    elseif curStep == 1254 then
        lyrics('か？')
    elseif curStep == 1296 then
        lyrics('HA ')
    elseif curStep == 1300 then
        lyrics('HA ')
    elseif curStep == 1306 then
        lyrics('HA')
    elseif curStep == 1314 then
        lyrics('I', true)
    elseif curStep == 1316 then
        lyrics(' AM ...')
    elseif curStep == 1320 then
        lyrics('GOD!!!', true)
        setTextSize("lyrics", 36)
    elseif curStep == 1328 then
        removeLuaText("lyrics")
    end
    if curStep >= 1264 and curStep <= 1292 and curStep % 2 ~= 0 then
        lyrics('HA ')
    end
end

---
--- @param membersIndex int
--- @param noteData int
--- @param noteType string
--- @param isSustainNote bool
---
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    cameraShake("game", 0.005, 0.1)
    cameraShake("hud", 0.001, 0.1)
    if getHealth() > 0.1 then
        addHealth(-0.005)
    end
end

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2, strumTime)
    if eventName == 'Cinematics' then
        if value1 == '1' then
            cinematicsMode = true
        else
            cinematicsMode = false
        end
    end
end

---
--- @param tag string
---
function onTweenCompleted(tag)
    if tag == "uibkbfidofwe" then
        vignette(2)
    elseif tag == "gwrgwrfew" then
        vignette(1)
    end
end

a = ''
function lyrics(str, isNew)
    if isNew then
        a = ''
    end
    setTextString("lyrics", a .. str)

    if not isNew then
        a = a .. str
    end
end

function vignette(i)
    if i == 1 then
        doTweenAlpha("uibkbfidofwe", "vignette", 1.0, 1.0 / playbackRate, "linear")
    elseif i == 2 then
        doTweenAlpha("gwrgwrfew", "vignette", .0, 1.0 / playbackRate, "linear")
    end
end