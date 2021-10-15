# Roadmap

* Movement rules confirmed with command line (100%)
* Changeable turn time (via game config)
* precise turn time (correcting interval)
* Use Gosu for display
* Gosu interface: arrows for direction
* Render smaller window on gosu
* Scroll window around
* Sinatra server (game_state, new_player, issue_command) - parallel game there
* Scoring for players
* scoreboard

nice to have:
* Gravity-style movement
* Target-style movement
* elements option (spawn or all walkers?)
* observer-type players (add a stone?)
* Mutliple game configs

Controls?
* Arrow - change direction
* G + arrow - set gravity direction
* P, S, R, N - set element
* Right click


### to test

- `Grid#in_range`
- City spawning towards edge, no error
- Cities healing?!?
- `Token#fight`?
_ two opposing walkers face off