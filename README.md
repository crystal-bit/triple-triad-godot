# TripleTriad made with Godot 3.0

I love Final Fantasy.  
I loved FFVIII.  
I loved Triple Triad.  
I had this question: *"How difficult it is to recreate the Triple Triad card game with Godot Engine?"*

This repository is the answer to my question: the core of the game has been developed during Devember2018 (a challenge where
you have to code each day of December for at least 1 hour).


## File organization

- `GameScenes`: contains every scene of the game. Each scene is placed in its own folder (with the same name). Each folder can contain:
    - the scene file (`.tscn`)
    - local assets (files that are used only in this specific scene)
    - local scripts (scripts that are used only in this specific scene)
    - (optional) local child scenes
- `NodeScenes` (maybe better name: `GameNodes`): reusable node scenes that can be used by `GameScenes`. Each node is placed in its own folder (with the same name). Each folder can contain:
    - scene file
    - assets
    - scripts

## TODO

- Add ending screen
  - Show battle result message (Draw, You Win, You Lose)
  - Restarte the battle
- Improve AI
- Port the project to Godot 3.1

## Contributing

Contributing for me means:

- saying me what you think about this project 
- tweet about this project
- talk with your friends about this project
- download this game and try it
- report bugs
- make Pull Requests to improve it or add new features

Before working on anything, I want to make sure that no-one is working
on the same thing at the same time so please feel free to:

- open an issue on Github
- get in touch on Twitter 


**Note**: I really would like to keep improving and expanding this
project, I love TripleTriad and would love to add other features (eg: online multiplayer matches)
but I don't have much time to invest on this project.  
I already did what I wanted: give an answer to the question that I wrote at the beginning of this 
file. 

## Licensing

I'm not an expert on licensing and this project is borderline legally speaking. I would say:

- every Godot related file (that I created) is released under MIT License:
  - scripts `*.gd`
  - scene files `*.tscn`
  - etc.
- the original asstes (textures, music, ecc.) should not be reused. They are Squaresoft/SquareEnix property. I don't even know if I'm allowed to use them.

## Thanks

Assets taken from: 

- [Mcindus' Tripod mod](http://forums.qhimm.com/index.php?topic=15301.0) - improved cards texture, background, fonts and other assets
- [Mcindus' SeeD Reborn](http://forums.qhimm.com/index.php?topic=15320.0) - "hand" selection sprite
- [JStorar's gameFAQ about TripleTriad cards](https://gamefaqs.gamespot.com/pc/197342-final-fantasy-viii/faqs/4906)
- [G.o.D.'s Audio rip](http://spritedatabase.net/file/17746/Sounds)
