---------------------------------------
--Constants
---------------------------------------
 
local FUEL_SLOT = 1
local LIGHT_SLOT = 2
local BLOCK_SLOT = 3
local CHEST_SLOT = 4
local FIRST_OPEN_SLOT = 5

---------------------------------------
--Functions
---------------------------------------

-----------------------------
--Supply Functions
-----------------------------
local function Check_Inv(item)
	
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

local function Fuel()
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
local function Block_Down()
	Check_Inv(BLOCK_SLOT)
	
        turtle.select(BLOCK_SLOT)
        if turtle.compareDown() ~= true then
                Dig_Down()
                turtle.select(BLOCK_SLOT)
                turtle.placeDown()
        end
end

local function Block_Forward()
	Check_Inv(BLOCK_SLOT)
	
        turtle.select(BLOCK_SLOT)
        if turtle.compare() ~= true then
                Dig_Forward()
                turtle.select(BLOCK_SLOT)
                turtle.place()
        end
end
 
local function Block_Up()
	Check_Inv(BLOCK_SLOT)
	
        turtle.select(BLOCK_SLOT)
        if turtle.compareUp() ~= true then
                Dig_Up()
                turtle.select(BLOCK_SLOT)
                turtle.placeUp()
        end
end

local function Light_Forward()
	Check_Inv(LIGHT_SLOT)
	
	turtle.select(LIGHT_SLOT)
	turtle.place()
end

-----------------------------
--Move Functions
-----------------------------

local function Move_Down()
	Fuel()
	
	while not turtle.down() do
		if turtle.detectDown() then
			Dig_Down()
		end
	end
	
	pos.y = pos.y - 1
end

local function Move_Forward()
	Fuel()
	
	while not turtle.forward() do
		if turtle.detect() then
			Dig_Forward()
		end
	end
	
	pos.x = pos.x + dir.x
	pos.z = pos.z + dir.z
end

local function Move_Up()
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

local function Turn_Left()
	turtle.turnLeft()
	dir.x, dir.z = -dir.z, dir.x
end

local function Turn_Right()
	turtle.turnRight()
	dir.x, dir.z = dir.z, -dir.x
end

local function Face_Back()
	while dir.z ~= -1 do
		Turn_Left()
	end
end

local function Face_Front()
	while dir.z ~= 1 do
		Turn_Right()
	end
end

local function Face_Left()
	while dir.x ~= -1 do
		Turn_Left()
	end
end

local function Face_Right()
	while dir.x ~= 1 do
		Turn_Right()
	end
end

-----------------------------
--Dig Functions
-----------------------------
local function Dig_Down()
        while turtle.detectDown() == true do
                turtle.digDown()
                sleep(0.5)
	end 
end
 
local function Dig_Forward()
        while turtle.detect() == true do
                turtle.dig()
                sleep(0.5)
	end        
end
 
local function Dig_Up()
        while turtle.detectUp() == true do
                turtle.digUp()
                sleep(0.5)
	end 
end

-----------------------------
--Command Matrix Functions
-----------------------------

local function Bottom_Left()
	Block_Down()
	Face_Left()
	Block_Forward()
	Move_Up()
end

local function Bottom_Center()
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

local function Bottom_Right()
	Block_Down()
	Face_Right()
	Block_Forward()
	Face_Left()
	Move_Forward()
end

local function Middle_Left()
	Face_Left()
	Block_Forward()
	if pos.z % 5 == 0 then 
		Light_Forward()
	end
	Move_Up()
end

local function Middle_Center()
	Move_Down()
end

local function Middle_Right()
	Face_Right()
	Block_Forward()
	if pos.z % 5 == 0 then 
		Light_Forward()
	end
	Move_Down()
end

local function Top_Left()
	Block_Up()
	Face_Left()
	Block_Forward()
	Face_Right()
	Move_Forward()
end

local function Top_Center()
	Block_Up()
	Face_Right()
	Move_Forward()
end

local function Top_Right()
	Block_Up()
	Face_Right()
	Block_Forward()
	Move_Down()
end

local function Command(f)
	f()
end

---------------------------------------
--Initialization
---------------------------------------
 
local args = { ... }
local intLength = tonumber(args[1])
local intLength = intLength or 5
if intLength % 5 ~= 0 then
	intLength = intLength - (intLength % 5)
end

local intStep = 1

local pos = {x=0, y=0, z=0}
local dir = {x=0, z=1}

local mtxCommands = {}
for i = -1, 1 do
	mtxCommands[i] = {}
	for j = -1, 1 do
		mtxCommands[i][j] = 0
	end
end

mtxCommands[-1][-1] = "Bottom_Left"
mtxCommands[-1][0] = "Bottom_Center"
mtxCommands[-1][1] = "Bottom_Right"
mtxCommands[0][-1] = "Middle_Left"
mtxCommands[0][0] = "Middle_Center"
mtxCommands[0][1] = "Middle_Right"
mtxCommands[1][-1] = "Top_Left"
mtxCommands[1][0] = "Top_Center"
mtxCommands[1][1] = "Top_Right"

---------------------------------------
--Main
---------------------------------------
while pos.z <= intLength do

	Command(mtxCommands[pos.x][pos.y])

end