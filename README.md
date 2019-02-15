# Triple Triad re-made with Godot 3.1

![Triple Triad in Godot screenshot](https://imgur.com/RwKigsz.jpg)

> *"How difficult it is to recreate the Triple Triad card game with the Godot Engine?"*

This repository is the answer to my question: the core of the game has been developed during [my Devember 2018 challenge](https://davcri.github.io/posts/devember2018-retrospective/) (a challenge where
you have to code each day of December for at least 1 hour).

## Tutorials

If you speak Italian, you can find a list of video tutorials
about this project in the [tutorials/README.md file](./tutorials/README.md).

---

## What is implemented

- Basic game mechanics:
   - Turns
   - Cards placement
   - "Capture" mechanic
- Data driven design for the `Card` node (all the data is taken from a JSON file)
- Simple AI

## How to run the game

### From an executable

You can download a prebuilt executable for Windows/OSX/Linux from the [release page](https://github.com/crystal-bit/triple-triad-godot/releases/latest).

### From source (using Godot)

1. [Download Godot Engine](https://godotengine.org/download/) (the game was developer with v3.0.6)
2. Download this project
3. Launch Godot Engine
4. Import the project into Godot
   1. Select `Scan`
   2. Select the project folder
   3. Double click on Triple Triad
5. Run the game by clicking on the *Play* button (or use the <kbd>F5</kbd> key for a shortcut)!


## Input Controls

- `Arrow keys` to move the cursor
- `Space/Enter` to confirm
- `Backspace` to cancel

## Contributing

You can contribute in different ways:

- download this game and try it
- talk with your friends about this project
- tell me your opinions about this project
- [tweet](https://twitter.com/dav__cri) about this project
- report bugs
- make Pull Requests to improve it or add new features

### Code contributions

Before working on anything, I want to make sure that no-one is working
on the same thing at the same time so please feel free to:

- [open an issue](https://github.com/crystal-bit/triple-triad-godot/issues/new)
- get in touch [on Twitter](https://twitter.com/dav__cri) 

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
