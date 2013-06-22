---------------------------------------
--Constants
---------------------------------------
 
FUEL_SLOT = 1
LIGHT_SLOT = 2
BLOCK_SLOT = 3
CHEST_SLOT = 4
FIRST_OPEN_SLOT = 5

---------------------------------------
--Functions
---------------------------------------

-----------------------------
--Supply Functions
-----------------------------
function Check_Inv(item)
	if turtle.getItemCount(item) == 1 then
		for i = FIRST_OPEN_SLOT, 16 do
			turtle.select(i)
			if turtle.compareTo(item) == true then
				if turtle.transferTo(item) ~= true then
					os.reboot()
				end
				turtle.select(FIRST_OPEN_SLOT)
				break
			end
		end
	end
end

 unction Fuel()
	local intFuel = turtle.getFuelLevel()
	
        if intFuel ~= 'unlimited' and intFuel > 0 then
		turtle.select(FUEL_SLOT)
		if turtle.refuel(1) ~= true then
			os.reboot()
		end
        end
end

-----------------------------
--Block Functions
-----------------------------
function Block_Down()
	Check_Inv(BLOCK_SLOT)
	
        turtle.select(BLOCK_SLOT)
        if turtle.compareDown() ~= true then
                Dig_Down()
                turtle.select(BLOCK_SLOT)
                turtle.placeDown()
        end
end

function Block_Forward()
	Check_Inv(BLOCK_SLOT)
	
        turtle.select(BLOCK_SLOT)
        if turtle.compare() ~= true then
                Dig_Forward()
                turtle.select(BLOCK_SLOT)
                turtle.place()
        end
end
 
function Block_Up()
	Check_Inv(BLOCK_SLOT)
	
        turtle.select(BLOCK_SLOT)
        if turtle.compareUp() ~= true then
                Dig_Up()
                turtle.select(BLOCK_SLOT)
                turtle.placeUp()
        end
end

function Light_Forward()
	Check_Inv(LIGHT_SLOT)
	
	turtle.select(LIGHT_SLOT)
	turtle.place()
end

-----------------------------
--Move Functions
-----------------------------

function Move_Down()
	Fuel()
	
	while not turtle.down() do
		if turtle.detectDown() then
			Dig_Down()
		end
	end
	
	pos.y = pos.y - 1
end

function Move_Forward()
	Fuel()
	
	while not turtle.forward() do
		if turtle.detect() then
			Dig_Forward()
		end
	end
	
	pos.x = pos.x + dir.x
	pos.z = pos.z + dir.z
end

function Move_Up()
	Fuel()
	
	while not turtle.up() do
		if turtle.detectUp() then
			Dig_Up()
		end
	end
	
	pos.y = pos.y + 1
end

-----------------------------
--Turn Functions
-----------------------------

function Turn_Left()
	turtle.turnLeft()
	dir.x, dir.z = -dir.z, dir.x
end

function Turn_Right()
	turtle.turnRight()
	dir.x, dir.z = dir.z, -dir.x
end

function Face_Back()
	while dir.z ~= -1 do
		Turn_Left()
	end
end

function Face_Front()
	while dir.z ~= 1 do
		Turn_Right()
	end
end

function Face_Left()
	while dir.x ~= -1 do
		Turn_Left()
	end
end

function Face_Right()
	while dir.x ~= 1 do
		Turn_Right()
	end
end

-----------------------------
--Dig Functions
-----------------------------
function Dig_Down()
        while turtle.detectDown() == true do
                turtle.digDown()
                sleep(0.5)
	end 
end
 
function Dig_Forward()
        while turtle.detect() == true do
                turtle.dig()
                sleep(0.5)
	end        
end
 
function Dig_Up()
        while turtle.detectUp() == true do
                turtle.digUp()
                sleep(0.5)
	end 
end

-----------------------------
--Command Matrix Functions
-----------------------------

mtxCommands = {}
for i = -1, 1 do
	mtxCommands[i] = {}
	for j = -1, 1 do
		mtxCommands[i][j] = 0
	end
end

mtxCommands[-1][-1] = function()
print(pos.x)
print(pos.y)
print(pos.z)
	Block_Down()
	Face_Left()
	Block_Forward()
	Move_Up()
end

mtxCommands[0][-1] = function()
	Face_Left()
	
	if turtle.detect() == true or turtle.detectUp() == true then
		Block_Down()
		Dig_Up()
		Move_Forward()
	else
		Face_Front()
		Move_Forward()
	end
	
end

mtxCommands[1][-1] = function()
	Block_Down()
	Face_Right()
	Block_Forward()
	Face_Left()
	Move_Forward()
end

mtxCommands[-1][0] = function()
	Face_Left()
	Block_Forward()
	if pos.z % 5 == 0 then 
		Light_Forward()
	end
	Move_Up()
end

mtxCommands[0][0] = function()
	Move_Down()
end

mtxCommands[1][0] = function()
	Face_Right()
	Block_Forward()
	if pos.z % 5 == 0 then 
		Light_Forward()
	end
	Move_Down()
end

mtxCommands[-1][1] = function()
	Block_Up()
	Face_Left()
	Block_Forward()
	Face_Right()
	Move_Forward()
end

mtxCommands[-1][0] = function()
	Block_Up()
	Face_Right()
	Move_Forward()
end

mtxCommands[1][1] = function()
	Block_Up()
	Face_Right()
	Block_Forward()
	Move_Down()
end

---------------------------------------
--Initialization
---------------------------------------
 
args = { ... }
intLength = tonumber(args[1])
intLength = intLength or 5
if intLength % 5 ~= 0 then
	intLength = intLength - (intLength % 5)
end

intStep = 1

pos = {x=0, y=0, z=0}
dir = {x=0, z=1}

---------------------------------------
--Main
---------------------------------------
while pos.z <= intLength do
print(pos.x)
print(pos.y)
print(pos.z)
	mtxCommands[pos.x][pos.y]()

end