---------------------------------------
--Constants
---------------------------------------
 
FUEL_SLOT = 1
LIGHT_SLOT = 2
BLOCK_SLOT = 3
CHEST_SLOT = 4
 
---------------------------------------
--Initialization
---------------------------------------
 
args = { ... }
intLength = tonumber(args[1])
intLength = intLength or 7
if intLength % 7 ~= 0 then
	intLength = intLength - (intLength % 7)
end
 
intStepCount = 1
 
---------------------------------------
--Functions
---------------------------------------
 
function CheckLights()
        if turtle.getItemCount(LIGHT_SLOT) == 0 then
        os.reboot()
        end
end
 
function CheckChests()
        if turtle.getItemCount(CHEST_SLOT) == 0 then
        os.reboot()
        end
end
 
--Compress important inventory items
function Compress_Inv()
        for i = 5, 16 do
                turtle.select(i)
                if turtle.compareTo(FUEL_SLOT) == true then
                        turtle.transferTo(FUEL_SLOT)
                elseif turtle.compareTo(LIGHT_SLOT) == true then
                        turtle.transferTo(LIGHT_SLOT)
                elseif turtle.compareTo(BLOCK_SLOT) == true then
                        turtle.transferTo(BLOCK_SLOT)
                elseif turtle.compareTo(CHEST_SLOT) == true then
                        turtle.transferTo(CHEST_SLOT)
                end
        end
end
 
function DoChest()
        CheckChests()
        turtle.select(CHEST_SLOT)
        turtle.place()
       
        for i = 5, 16 do
                turtle.select(i)
                if turtle.compareTo(LIGHT_SLOT) ~= true and turtle.compareTo(CHEST_SLOT) ~= true then
                        turtle.drop()
                end
        end
end
 
--Check if space below is Block and if not replace
function DoBlock_Down()
        turtle.select(BLOCK_SLOT)
        if turtle.compareDown() ~= true then
                DoDig_Down()
                turtle.select(BLOCK_SLOT)
                turtle.placeDown()
        end
end
 
--Check if space forward is Block and if not replace
function DoBlock_Forward()
        turtle.select(BLOCK_SLOT)
        if turtle.compare() ~= true then
                DoDig_Forward()
                turtle.select(BLOCK_SLOT)
                turtle.place()
        end
end
 
--Check if space above is Block and if not replace
function DoBlock_Up()
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
                sleep(0.25)
        until turtle.detectDown() ~= true
end
 
--Dig forward until space is clear
function DoDig_Forward()
        repeat
                turtle.dig()
                sleep(0.25)
        until turtle.detect() ~= true
end
 
--Dig up until space is clear
function DoDig_Up()
        repeat
                turtle.digUp()
                sleep(0.25)
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
 
function IsInvFull()
       
        for i = 16, 5, -1 do
                if turtle.getItemCount(i) == 0 then
                        return false
                end
        end

	return true
       
end
---------------------------------------
--Main
---------------------------------------
while intStepCount <= intLength do
        CheckLights()
        DoFuel()
       
        DoDig_Forward()
        turtle.forward()
        DoBlock_Down()
        DoDig_Up()
        turtle.turnLeft()
        DoDig_Forward()
        turtle.forward()
        DoBlock_Down()
        DoBlock_Forward()
        DoDig_Up()
        turtle.up()
	DoBlock_Forward()
        DoDig_Up()
        turtle.up()
        DoBlock_Forward()
        DoBlock_Up()
        turtle.turnRight()
        turtle.turnRight()
        DoDig_Forward()
        turtle.forward()
	
	if intStepCount % 7 == 0 then
                DoLight()
        else
		DoBlock_Up()
	end
	
        DoDig_Forward()
        turtle.forward()
        DoBlock_Up()
        DoBlock_Forward()
        DoDig_Down()
        turtle.down()
	DoBlock_Forward()
        DoDig_Down()
        turtle.down()
        DoBlock_Forward()
        DoBlock_Down()
        turtle.back()
	
        Compress_Inv()
        if IsInvFull() == true then
                DoChest()
        end
               
        turtle.turnLeft()
 
        intStepCount =  intStepCount + 1
	
	turtle.select(BLOCK_SLOT)
end