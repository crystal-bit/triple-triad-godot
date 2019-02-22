# Changelog

Dates are in the following format: [YYYY-MM-DD]

---

# v1.2.0 [WIP]

### Changes

- Ported to Godot v3.1
- Added main menu
- Added Autoloads:
  - SceneManager: utility functions to load nodes and scenes
  - GlobalState: keep track of global variables (number of played matches, and other stats)
- When a Battle ends, stats are shown: won, drawn and lost matches
- Splitted Battle scene in multiple scenes to improve mantainability

# v1.1.0 [2019-01-04]

### Changes

- Randomize cards on start
- Add "match_ended" signal
- Show results screen when the match ends
- Restart the game when the match ends

---

# v1.0.0 [2019-01-03]

Initial version.