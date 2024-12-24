function onCreate()
    makeLuaSprite("bg")
    makeGraphic("bg", screenWidth, screenHeight, '000000')
    scaleObject("bg", 5.0, 5.0)
    screenCenter("bg")
    setScrollFactor("bg", 0.0, 0.0)
    addLuaSprite("bg")

    makeLuaSprite("fuck", "a")
    scaleObject("fuck", 2.0, 2.0)
    screenCenter("fuck")
    setBlendMode("fuck", "add")
    addLuaSprite("fuck", true)
end