# whoop whoop cuz its the brainrot police 🚓🚓🚓

To suggest games, report bugs, etc. Join https://discord.gg/vaehz

## Last update 02/07/2026 {DD/MM/YYYY}

This is an open source little project I made for a bunch of shitty brainrot games. Don't take it too serious lads

https://wearentdevs.net/

loadstring(game:HttpGet("https://raw.githubusercontent.com/Sunny-son-sahur/BrainrotPolice/main/src/init.lua"))()

## Adding Custom Games

1. Put `getgenv().FileScripts = true` before the loadstring.
2. In your executors workspace folder, open the BrainrotPolice folder and make a new .lua file.
3. Name it the place id of the game it supports, for example: `12345678910.lua`
4. Enjoy!

## Custom Game Template

```lua
-- game name

return function(section)
    local elements = loadstring(game:HttpGet(getgitpath("src").."elements.lua"))()

    elements:Label("This is a Label", section)

    elements:Toggle("This is a Toggle", section, false, function(bool)
        if bool then
            print("Enabled!")
        else
            print("Disabled.")
        end
    end)

    elements:Button("This is a Button", section, function()
        print("Clicked!")
    end)

    elements:Textbox("This is a TextBox", section, "", function(str)
        print("Typed: "..str)
    end)
end
```

## Supported Games

- Cross road for brainrots
- Survive flood for brainrots
- Reel for brainrots
- Rizz tower
- Nuke for brainrots
- Hack vault for brainrots
- Fly for brainrots
- Sail for Brainrots
- Scream for Brainrots
- Parkour run for Brainrots
- Pole obby for Brainrots
- Dream for brainrots
- +1 Wings for Brainrots
- Bike Obby for Brainrots
- DUMP
- Chicken Farm
- Swing obby for Brainrots
- Become a Brainrot
- Fake a Brainrot
- +1 Health for Brainrots
- +1 Speed Evolve
- +1 Speed Keyboard Escape
- Smash crate for Brainrot
- Paper Plane for Brainrots
- Cross rivers for Brainrots
- +1 Dash for Brainrots
- Obby as a Brainrot
- +1 Jetpack for Brainrot
- Lick a Brainrot
- Skate for Brainrots
- **Escape Police For Brainrots** (NEW!)

## About

No description, website, or topics provided.