# The code is defining a Ruby module called `Constant`. Inside the module, there are several constants
# defined:
module Constant
    WIDTH_WINDOW = 660
    HEIGHT_WINDOW = 495
    WIDTH_TILE = 55
    HEIGHT_TILE = 55
    PLAYER = "@"
    WALL = "#"
    BLOCK= "&"
    VOID = " "
    GOAL = "*"
    WIN = "!"
    TRAP = "$"
    MOVE = {"r"=>0,"l"=>1,"u"=>2,"d"=>3}
    AXE = {"x"=>0,"y"=>1}
end