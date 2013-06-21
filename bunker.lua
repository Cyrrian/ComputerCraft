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

-----------------------------
--Supply Functions
-----------------------------
function Blocks()
	
	if turtle.getItemCount(BLOCK_SLOT) == 1 then
		for i = 7, 16 do
			turtle.select(i)
			if turtle.compareTo(BLOCK_SLOT) == true then
				turtle.transferTo(BLOCK_SLOT)
				break
			end
		end
	end
end

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

-----------------------------
--Block Functions
-----------------------------
function Block_Down()
	Blocks()
        turtle.select(BLOCK_SLOT)
        if turtle.compareDown() ~= true then
                Dig_Down()
                turtle.select(BLOCK_SLOT)
                turtle.placeDown()
        end
end

function Block_Forward()
	Blocks()
        turtle.select(BLOCK_SLOT)
        if turtle.compare() ~= true then
                Dig_Forward()
                turtle.select(BLOCK_SLOT)
                turtle.place()
        end
end
 
function Block_Up()
	Blocks()
        turtle.select(BLOCK_SLOT)
        if turtle.compareUp() ~= true then
                Dig_Up()
                turtle.select(BLOCK_SLOT)
                turtle.placeUp()
        end
end

-----------------------------
--Dig Functions
-----------------------------
function Dig_Down()
        repeat
                turtle.digDown()
                sleep(0.25)
        until turtle.detectDown() ~= true
end
 
function Dig_Forward()
        repeat
                turtle.dig()
                sleep(0.25)
        until turtle.detect() ~= true
end
 
function Dig_Up()
        repeat
                turtle.digUp()
                sleep(0.25)
        until turtle.detectUp() ~= true
end

-----------------------------
--Move Functions
-----------------------------
function Move_Back()
	if turtle.back() ~= true then
		turtle.turnLeft()
		turtle.turnLeft()
		Move_Forward()
		turtle.turnLeft()
		turtle.turnLeft()
	end
end

function Move_Forward()
	if turtle.detect() then
		Dig_Forward()
	end
	
	turtle.forward()
end

function Move_Up()
	if turtle.detectUp() then
		Dig_Up()
	end
	
	turtle.up()
end

---------------------------------------
--Main
---------------------------------------
Fuel()

size = 7

-----------------------------
--Base
-----------------------------
Block_Down()
	
for i = 1, size-1, 1 do
	
	turtle.turnLeft()
	print("i: " .. i .. " j: " .. j .. " size: " .. size)
	for j=1, i do
		Move_Forward()
		Block_Down()
	end
	
	turtle.turnLeft()
	print("i: " .. i .. " j: " .. j .. " size: " .. size)
	for j=1, i do
		Move_Forward()
		Block_Down()
	end
end

turtle.turnLeft()
print("i: " .. i .. " j: " .. j .. " size: " .. size)
for i = 1, size-1 do
			
	Move_Forward()
	Block_Down()

end

-----------------------------
--Walls
-----------------------------
Move_Up()
	
for i=1, x-1 do

	Block_Up()
	Block_Down()
	Move_Back()
	Block_Forward()
	
end

turtle.turnRight()

for i=1, x-1 do

	Block_Up()
	Block_Down()
	Move_Back()
	Block_Forward()
	
end

turtle.turnRight()

for i=1, x-1 do

	Block_Up()
	Block_Down()
	Move_Back()
	Block_Forward()
	
end

turtle.turnRight()

for i=1, x-2 do

	Block_Up()
	Block_Down()
	Move_Back()
	Block_Forward()
	
end

Block_Down()
Move_Up()
Block_Down()
Move_Up()
Block_Down()