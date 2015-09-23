Welcome to Robot Toy Tracker!

This is a simple rails application that tracks and saves the last movement of multiple toy robots.

Please create a robot before tracking its movement.

It is placed in a 5x5 unit container; and it cannot leave the container's perimeters.

It is placed with the command: PLACE 0,0, NORTH
where the x,y coordinates encompass the range of 0 to 5, and NORTH is the direction. Either North, South, East and West can be used.

Other commands are:
LEFT: allowing the robot to make a 90 degree turn to its left, without moving
RIGHT: allowing the robot to make a 90 degree turn to its right, without moving
MOVE: allowing the robot to move one unit forwards in the direction it is facing
REPORT: ends the command stream, immediately displays the current location and position of the robot

The commands can be concatinated; however, there must be a preceeding space before each command.

Some sample input data can be found in DATA.md