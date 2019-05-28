# Hollow World! (for now)

### Project Description
This game is best described as a hybrid of RPG and action-adventure similar to that of the original Zelda games (namely The Legend of Zelda: A Link to the Past) while drawing inspiration from Metroidvania series such as Hollow Knight.  The concept of the game is to clear rooms/floors of monsters in order to unlock the next room/floor.  The player will control a character and be able to move around, attack, and take damage.  There will be different presets of rooms and types of monsters.  Each elimination will add to the player’s score, and the game should continue so long as the player stays alive.

### Directions


_________________________

### Development Log

##### 5/16/19 (Start of Project)
* created project repo, processing folder, and main pde file
* added abstract class Thing 
##### 5/17/19
* added Monster, OverWorldObject, and Player classes
* started basic monster functions - started a Slime class
* added damageable, collideable, and movable interfaces
* created an experimentation folder
* started different branches
##### 5/18/19
* created a function implementing basic passive movement for a monster
* implemeted file reading to obtain sprite images to animate a slime
* added basic player tracking for monster
##### 5/19/19
* fixed and refined basic player tracking for monster - implemented monster update behavior regarding proximity to player
* fixed isTouching() method
* added experimental directional animation
* changed implementaion of loading sprites
##### 5/20/19
* modified attack method to take in Thing target
* added basic attack for slime (isTouching => loseHealth)
* added invulnerability timers for Player and Monster when they are attacked
* filled out all present methods for Monster class
* added sprites and worked on movement for the player
##### 5/21/19
* start of piranha_plant class (name w.i.p.)
* added sprites for piranha plant
* added unique movement behavior for pirnha plant
* started piranha plant attack function
* began research on attacking algorithm for player
* worked on player sprites and successfully solved movement issues
##### 5/22/19
* added Projectile class
* made working projectiles for Piranha Plant, fixing projectile storage and registering damage
* implemented image for Piranha Plant projectile, called fireball
##### 5/23/19
* started work on the HUD
* added heart sprites to the file
* HUD now displays player's current health in increments of half a heart
##### 5/24/19
* added flashing red for sprites when they are damaged respectively
* added and simple health bars => displayed over monsters' head when damaged and linger for some time
* implemented death animations for the existing monsters (Slime and Piranha Plant)
##### 5/25/19
* tweaked health bars and added death animations for existing monsters
* added files for next monster Minotaur and started work on Minotaur class
##### 5/26/19
* tweaked Minotaur behavior
* added files for next monster Boar
* implemented a Boar class
##### 5/27/19
* continued tweaking Minotaur
* lowered Slime animation delay
* added files for next monster Spirit
