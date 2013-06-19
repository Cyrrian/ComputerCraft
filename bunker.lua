---------------------------------------
--Constants
---------------------------------------
 
FUEL_SLOT = 1
LIGHT_SLOT = 2
BLOCK_SLOT = 3
WINDOW_SLOT = 4
DOOR_SLOT = 5
BUTTON_SLOT= 6
 
---------------------------------------
--Functions
---------------------------------------
  
--Check if space below is Block and if not replace
function DoBlock_Down()
	DoDig_Down()
        turtle.select(BLOCK_SLOT)
        if turtle.compareDown() ~= true then
                DoDig_Down()
                turtle.select(BLOCK_SLOT)
                turtle.placeDown()
        end
end
 
--Check if space forward is Block and if not replace
function DoBlock_Forward()
	DoDig_Forward()
        turtle.select(BLOCK_SLOT)
        if turtle.compare() ~= true then
                DoDig_Forward()
                turtle.select(BLOCK_SLOT)
                turtle.place()
        end
end
 
--Check if space above is Block and if not replace
function DoBlock_Up()
	DoDig_Up()
        turtle.select(BLOCK_SLOT)
        if turtle.compareUp() ~= true then
                DoDig_Up()
                turtle.select(BLOCK_SLOT)
                turtle.placeUp()
        end
end
 
--Dig down until space is clear
function DoDig_Down()
        repeat
                turtle.digDown()
                sleep(0.5)
        until turtle.detectDown() ~= true
end
 
--Dig forward until space is clear
function DoDig_Forward()
        repeat
                turtle.dig()
                sleep(0.5)
        until turtle.detect() ~= true
end
 
--Dig up until space is clear
function DoDig_Up()
        repeat
                turtle.digUp()
                sleep(0.5)
        until turtle.detectUp() ~= true
end
 
--Check fuel level and refuel if less than 10
function DoFuel()
        if turtle.getFuelLevel() ~= 'unlimited' then
                if turtle.getFuelLevel() < 10 then
                        turtle.select(FUEL_SLOT)
                        if turtle.refuel(1) ~= true then
                                os.reboot()
                        end
                end
        end
end
 
function DoLight()     
                        DoDig_Up()
                        turtle.select(LIGHT_SLOT)
                        turtle.placeUp()
end
 
---------------------------------------
--Main
---------------------------------------
DoFuel()


DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()

DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.forward()
DoBlock_Down()
turtle.turnLeft()
turtle.forward()