# Hollow World!

### Project Description
This game is best described as a hybrid of RPG and action-arcade somewhat similar to that of the original Zelda games (namely The Legend of Zelda: A Link to the Past) while drawing inspiration from Metroidvania series such as Hollow Knight.  The concept of the game is to kill monsters inside an arena, granting the player score and prompting more to spawn.  The player will control a character and be able to move around, attack, and take damage.  There will be a variety of different types of monsters.  Each elimination will add to the player’s score, and the game should continue so long as the player stays alive.  The goal is to get the highest score you can.

### Directions
  1) Open finalProject.pde in finalProject folder with Processing. 
  2) Press play. 
  3) Press any button on keyboard to start. 
  4) **Want to learn how to play? Press and hold 'I' for instructions.**
  5) Enter the portal to be transported into the arena. 
  6) Kill monsters and stay alive. 
  7) Have fun! 
_________________________

### Development Log

##### 5/16/19 (Start of Project)
###### Bryan Lai along with Calvin Chu (Day the prototype was discussed.)
* created project repo, processing folder, and main pde file
* added abstract class Thing 
##### 5/17/19
###### Bryan Lai:
* added Monster, OverWorldObject, and Player classes
* added damageable, collideable, and movable interfaces
###### Calvin Chu:
* started basic monster functions - started a Slime class
* created an experimentation folder
* started different branches
##### 5/18/19
###### Bryan Lai:
* Start researching/work on basic movement for player.
* Add more instance variables for the Player Class, OverworldObject, etc.
###### Calvin Chu:
* created a function implementing basic passive movement for a monster
* implemeted file reading to obtain sprite images to animate a slime
* added basic player tracking for monster
##### 5/19/19
###### Bryan Lai:
* Add x_pos and y_pos to abstract class Thing. 
* Also added interface methods that needed to be implemented in Monster, Player, etc.
* Added player movement with the use of 4 boolean variables. (isRight, isLeft, isUp, isDown)
###### Calvin Chu:
* fixed and refined basic player tracking for monster - implemented monster update behavior regarding proximity to player
* fixed isTouching() method
* added experimental directional animation
* changed implementaion of loading sprites
##### 5/20/19
###### Bryan Lai:
* Remove extra player that was created due to a bug.
* Add another sprite and create different forms of movement by toggling x and c. 
  * X --> Run (Speed changes to 4)
  * C --> Walk (Speed changes to 2)
* Work on angle detection from player.
###### Calvin Chu:
* modified attack method to take in Thing target
* added basic attack for slime (isTouching => loseHealth)
* added invulnerability timers for Player and Monster when they are attacked
* filled out all present methods for Monster class
* added sprites and worked on movement for the player
##### 5/21/19
###### Bryan Lai:
* Added more sprites and changed attack() method implementation by including another parameter for target.
* Added new sprites and reuse frame/sprite implementation from Monster.
* Edit player_sprites.txt and add reversed pngs.
* Worked on running animations.
* Added the lastDirection constant to manage sprite changes.
###### Calvin Chu:
* start of piranha_plant class (name w.i.p.)
* added sprites for piranha plant
* added unique movement behavior for pirnha plant
* started piranha plant attack function
* began research on attacking algorithm for player
* worked on player sprites and successfully solved movement issues
##### 5/22/19
###### Bryan Lai:
* Create arc for attack and show coordinates/values on screen for testing.
* Work on angle of the player relative to the monster to complete attack() method of player.
###### Calvin Chu:
* added Projectile class
* made working projectiles for Piranha Plant, fixing projectile storage and registering damage
* implemented image for Piranha Plant projectile, called fireball
##### 5/23/19
###### Bryan Lai:
* Realize that 90 and 270 degrees were inverted.
* Get attack to finally work properly.
* Display monster hp changes. (This doesn't compare to Calvin's HUD and invulnerability time.)
###### Calvin Chu:
* started work on the HUD
* added heart sprites to the file
* HUD now displays player's current health in increments of half a heart
##### 5/24/19
###### Bryan Lai:
* Added tiles for room development.
* Relocate sprites and images and semi-complete OverworldObject class.
###### Calvin Chu:
* added flashing red for sprites when they are damaged respectively
* added and simple health bars => displayed over monsters' head when damaged and linger for some time
* implemented death animations for the existing monsters (Slime and Piranha Plant)
##### 5/25/19
###### Calvin Chu:
* tweaked health bars and added death animations for existing monsters
* added files for next monster Minotaur and started work on Minotaur class
##### 5/26/19
###### Calvin Chu:
* tweaked Minotaur behavior
* added files for next monster Boar
* implemented a Boar class
##### 5/27/19
###### Calvin Chu:
* continued tweaking Minotaur
* lowered Slime animation delay
* added files for next monster Spirit
##### 5/28/19
###### Bryan Lai:
* Fixed lagging error with the tiles by changing methods with loadImage.
* Add sprites/parameters a specific txt file to draw onto the screen. 
* Create simplistic way to generate tiles (once the map is ideally made) from a text file. (Easier than hardcoding each tile.)
###### Calvin Chu:
* added and implemented Spirit class
* added sprite for Spirit's projectile
* added files for next monster Griffin
##### 5/29/19
###### Calvin Chu:
* started a Screens class to display different interfaces in the game
* worked on a basic title screen and implemented it
* implemented Griffin class
* resized Boar sprites
##### 5/30/19
###### Calvin Chu:
* added new Dragon class for next monster
* remade title screen
* changes to Screen class => added frame storage for animated screens, modified constructor
* renamed Piranha Plant to Baby (as in baby dragon)
##### 5/31/19
###### Calvin Chu:
* worked on boss modifiers (now making use of isBoss boolean) for Monster class
* implemented unique boss modifiers to monsters with sprites of varying dimensions to fix resizing
##### 6/1/19
###### Calvin Chu:
* added score value to monster constructor and int score for each monster
* implemented score tracker and displayer in HUD that shows current score in top right corner and accomodates for increasing number of digits in the score
##### 6/2/19
###### Calvin Chu:
* touched up on player abilities => changed dash sprite, fiddled with cooldowns (still needs work)
* fixed issue with player no longer flashing when holding a sword and gettting damaged
##### 6/3/19
###### Calvin Chu:
* created the animated instructions screen and implemented it
* set display of instruction screen to 'I'
* added basic ability cooldown icons to HUD
##### 6/4/19 (Last Day)
###### Calvin Chu:
* changed visibility of ability cooldown icons so that you can only see them when you pick up the corresponding item
* added color codes (light green for ready and brightening red for on cooldown) to cooldown icons on HUD
* sprinkled in comments for the functions of different classes and variables that are important and need description
* attempted balancing monsters
