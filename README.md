# Hollow World! (for now)

### Project Description
This game is best described as a hybrid of RPG and action-adventure similar to that of the original Zelda games (namely The Legend of Zelda: A Link to the Past) while drawing inspiration from Metroidvania series such as Hollow Knight.  The concept of the game is to clear rooms/floors of monsters in order to unlock the next room/floor.  The player will control a character and be able to move around, attack, and take damage.  There will be different presets of rooms and types of monsters.  Each elimination will add to the player’s score, and the game should continue so long as the player stays alive.

### Directions


_________________________

### Development Log

##### 5/16/19 (Start of Project)
Bryan Lai along with Calvin Chu (Day the prototype was discussed.)
* created project repo, processing folder, and main pde file
* added abstract class Thing 
##### 5/17/19
Bryan Lai:
* added Monster, OverWorldObject, and Player classes
* added damageable, collideable, and movable interfaces
Calvin Chu:
* started basic monster functions - started a Slime class
* created an experimentation folder
* started different branches
##### 5/18/19
Bryan Lai:
* Start researching/work on basic movement for player.
* Add more instance variables for the Player Class, OverworldObject, etc.
Calvin Chu:
* created a function implementing basic passive movement for a monster
* implemeted file reading to obtain sprite images to animate a slime
* added basic player tracking for monster
##### 5/19/19
Bryan Lai:
* Add x_pos and y_pos to abstract class Thing. 
* Also added interface methods that needed to be implemented in Monster, Player, etc.
* Added player movement with the use of 4 boolean variables. (isRight, isLeft, isUp, isDown)
Calvin Chu:
* fixed and refined basic player tracking for monster - implemented monster update behavior regarding proximity to player
* fixed isTouching() method
* added experimental directional animation
* changed implementaion of loading sprites
##### 5/20/19
Bryan Lai:
* Remove extra player that was created due to a bug.
* Add another sprite and create different forms of movement by toggling x and c. 
  * X --> Run (Speed changes to 4)
  * C --> Walk (Speed changes to 2)
* Work on angle detection from player.
Calvin Chu:
* modified attack method to take in Thing target
* added basic attack for slime (isTouching => loseHealth)
* added invulnerability timers for Player and Monster when they are attacked
* filled out all present methods for Monster class
* added sprites and worked on movement for the player
##### 5/21/19
Bryan Lai:
* Added more sprites and changed attack() method implementation by including another parameter for target.
* Added new sprites and reuse frame/sprite implementation from Monster.
* Edit player_sprites.txt and add reversed pngs.
* Worked on running animations.
* Added the lastDirection constant to manage sprite changes.
Calvin Chu:
* start of piranha_plant class (name w.i.p.)
* added sprites for piranha plant
* added unique movement behavior for pirnha plant
* started piranha plant attack function
* began research on attacking algorithm for player
* worked on player sprites and successfully solved movement issues
##### 5/22/19
Bryan Lai:
* Create arc for attack and show coordinates/values on screen for testing.
* Work on angle of the player relative to the monster to complete attack() method of player.
Calvin Chu:
* added Projectile class
* made working projectiles for Piranha Plant, fixing projectile storage and registering damage
* implemented image for Piranha Plant projectile, called fireball
##### 5/23/19
Bryan Lai:
* Realize that 90 and 270 degrees were inverted.
* Get attack to finally work properly.
* Display monster hp changes. (This doesn't compare to Calvin's HUD and invulnerability time.)
Calvin Chu:
* started work on the HUD
* added heart sprites to the file
* HUD now displays player's current health in increments of half a heart
##### 5/24/19
Bryan Lai:
* Added tiles for room development.
* Relocate sprites and images and semi-complete OverworldObject class.
Calvin Chu:
* added flashing red for sprites when they are damaged respectively
* added and simple health bars => displayed over monsters' head when damaged and linger for some time
* implemented death animations for the existing monsters (Slime and Piranha Plant)
##### 5/25/19
Calvin Chu:
* tweaked health bars and added death animations for existing monsters
* added files for next monster Minotaur and started work on Minotaur class
##### 5/26/19
Calvin Chu:
* tweaked Minotaur behavior
* added files for next monster Boar
* implemented a Boar class
##### 5/27/19
Calvin Chu:
* continued tweaking Minotaur
* lowered Slime animation delay
* added files for next monster Spirit
