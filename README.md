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
