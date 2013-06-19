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
function Block_Down()
        turtle.select(BLOCK_SLOT)
        if turtle.compareDown() ~= true then
                Dig_Down()
                turtle.select(BLOCK_SLOT)
                turtle.placeDown()
        end
end
 
--Check if space forward is Block and if not replace
function Block_Forward()
        turtle.select(BLOCK_SLOT)
        if turtle.compare() ~= true then
                Dig_Forward()
                turtle.select(BLOCK_SLOT)
                turtle.place()
        end
end
 
--Check if space above is Block and if not replace
function Block_Up()
        turtle.select(BLOCK_SLOT)
        if turtle.compareUp() ~= true then
                Dig_Up()
                turtle.select(BLOCK_SLOT)
                turtle.placeUp()
        end
end
 
--Dig down until space is clear
function Dig_Down()
        repeat
                turtle.digDown()
                sleep(0.25)
        until turtle.detectDown() ~= true
end
 
--Dig forward until space is clear
function Dig_Forward()
        repeat
                turtle.dig()
                sleep(0.25)
        until turtle.detect() ~= true
end
 
--Dig up until space is clear
function Dig_Up()
        repeat
                turtle.digUp()
                sleep(0.25)
        until turtle.detectUp() ~= true
end
 
--Check fuel level and refuel if less than 10
function Fuel()
        if turtle.getFuelLevel() ~= 'unlimited' then
                if turtle.getFuelLevel() < 10 then
                        turtle.select(FUEL_SLOT)
                        if turtle.refuel(1) ~= true then
                                os.reboot()
                        end
                end
        end
end
 
function Square(x)

	Block_Down()
	
	for i = 1, x-1 do
		
		turtle.turnLeft()
		
		for j=1, i do
			turtle.forward()
			Block_Down()
		end
		
		turtle.turnLeft()
		
		for j=1, i do
			turtle.forward()
			Block_Down()
		end
	end
	
	for i = 1, x-1 do
		
		turtle.turnLeft()

		turtle.forward()
		Block_Down()

	end

end
---------------------------------------
--Main
---------------------------------------
Fuel()

Square(7)
