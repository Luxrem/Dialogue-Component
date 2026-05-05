# Dialogue-Component
A lightweight, flexible dialogue system for games built with the Godot Engine, using JSON-based dialogue trees.

Example of the component during run time:
<img width="1101" height="620" alt="Godot_v4 6 2-stable_win64_0ZG0YZtAMU" src="https://github.com/user-attachments/assets/8c2e0a2e-2e7c-4864-9d9e-34705d20cf27" />

## Features
- JSON-based dialogue system
- Branching dialogue with choices
- BBCode support for styled text
- Easy integration with buttons/events
- Lightweight and easy to extend

<!-- Old quick start
## Quick Start
1. Add `Dialogue.tscn` and `dialogue.gd` to your project
2. Instance the dialogue scene in your main scene
3. Reference it:
 ``` gdscript
 @onready var dialogue_manager = $DialogueManager
 ```
4. Start a dialogue:
``` gdscript
start_dialogue("res://dialogues/test_dialogue.json")
```
-->

## How it works:
Using structured JSON files ([see example](https://github.com/user-attachments/assets/70ce44e0-a886-4d81-99a5-cc1878a044ed)) as a dialogue tree it is possible to create and display dialogues in game with choices and styled text.

### Dialogue structure:
Each dialogue entry contains:
- `Sentence key` - the identifier
  - `text` — plain sentence text
  - `bbcode` — styled text using BBCode
  - `goto` — next dialogue key
  - `choices` — optional array of choices:
    - `text` — choice label
    - `goto` — next dialogue key
> [!IMPORTANT]
> The starting sentence of the dialogue must have "dialogue_start" key, and the endings must have a "dialogue_end" goto value

Here is an example of how the dialogue tree JSON file structure looks as copyable code:
``` JSON
{
    "dialogue_start": {
        "text"   : "Hello",
        "bbcode" : "Hello",
        "goto"   : "intro_1"
    },
    "intro_1": {
        "text"   : "Are you new here?",
        "bbcode" : "Are you new here?",
        "choices": [{ "text": "choice_1", "goto": "answer_1" },
                    { "text": "No",       "goto": "answer_2" }]
		},
    "answer_1": {
        "text"   : "Welcome newcomer",
        "bbcode" : "[rainbow][wave]Welcome newcomer[/wave][/rainbow]",
        "goto"   : "dialogue_end"
    },
    "answer_2": {
        "text"   : "Welcome back then",
        "bbcode" : "[wave]Welcome back then[/wave]",
        "goto"   : "dialogue_end"
    }
}
```
Dialogue can be called at any point in the game using various triggers (e.g. buttons, events...) using the ```start_dialogue(path)``` function and giving it the dialogue file location.

Here is an example of how to do it:
``` gdscript
dialogue_1.pressed.connect(start_dialogue.bind("res://dialogues/test_dialogue.json"))
dialogue_2.pressed.connect(start_dialogue.bind("res://dialogues/dialogue_2.json"))
```
In this example dialogue_1 and dialogue_2 are buttons.

## Setup

1. Copy `Dialogue.tscn` and `dialogue.gd` into your project  
   *(or clone the repository and open it in Godot)*

2. Add `Dialogue.tscn` to your main scene  

3. Reference it in code:
```gdscript
@onready var dialogue_manager = $DialogueManager
```

4. Start a dialogue through a trigger:
``` gdscript
button.pressed.connect(dialogue_manager.start_dialogue.bind("res://dialogues/test_dialogue.json"))
```

<!-- Old instalation
## Installation

### Option 1: Full Project
- Clone or download the repository
- Open it in Godot

### Option 2: Manual Setup
1. Copy `Dialogue.tscn` and `dialogue.gd` into your project
2. Instance `Dialogue.tscn` in your main scene
3. Reference it in code: 
   ```@onready var dialogue_manager = $DialogueManager```
-->
