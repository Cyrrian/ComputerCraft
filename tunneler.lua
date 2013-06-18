---------------------------------------
--Constants
---------------------------------------
 
FUEL_SLOT = 1
TORCH_SLOT = 2
COBBLE_SLOT = 3
CHEST_SLOT = 4
 
---------------------------------------
--Initialization
---------------------------------------
 
args = { ... }
intLength = tonumber(args[1])
intLength = intLength or 5
if intLength % 5 ~= 0 then
	intLength = intLength - (intLength % 5) + 5
end
 
intStepCount = 1
 
---------------------------------------
--Functions
---------------------------------------
 
function CheckTorches()
        if turtle.getItemCount(TORCH_SLOT) == 0 then
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
        for i = 1, 16 do
                turtle.select(i)
                if FUEL_SLOT ~= i and turtle.compareTo(FUEL_SLOT) == true then
                        turtle.transferTo(FUEL_SLOT)
                elseif TORCH_SLOT ~= i and turtle.compareTo(TORCH_SLOT) == true then
                        turtle.transferTo(TORCH_SLOT)
                elseif COBBLE_SLOT ~= i and turtle.compareTo(COBBLE_SLOT) == true then
                        turtle.transferTo(COBBLE_SLOT)
                elseif CHEST_SLOT ~= i and turtle.compareTo(CHEST_SLOT) == true then
                        turtle.transferTo(CHEST_SLOT)
                end
        end
end
 
function DoChest()
        CheckChests()
        turtle.select(CHEST_SLOT)
        turtle.place()
       
        for i = 1, 16 do
                turtle.select(i)
                if turtle.compareTo(FUEL_SLOT) ~= true and turtle.compareTo(TORCH_SLOT) ~= true and turtle.compareTo(CHEST_SLOT) ~= true and i ~= COBBLE_SLOT then
                        turtle.drop()
                end
        end
end
 
--Check if space below is cobble and if not replace
function DoCobble_Down()
        turtle.select(COBBLE_SLOT)
        if turtle.compareDown() ~= true then
                DoDig_Down()
                turtle.select(COBBLE_SLOT)
                turtle.placeDown()
        end
end
 
--Check if space forward is cobble and if not replace
function DoCobble_Forward()
        turtle.select(COBBLE_SLOT)
        if turtle.compare() ~= true then
                DoDig_Forward()
                turtle.select(COBBLE_SLOT)
                turtle.place()
        end
end
 
--Check if space above is cobble and if not replace
function DoCobble_Up()
        turtle.select(COBBLE_SLOT)
        if turtle.compareUp() ~= true then
                DoDig_Up()
                turtle.select(COBBLE_SLOT)
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
 
function DoTorch()     
                        DoDig_Forward()
                        turtle.forward()
                        turtle.select(COBBLE_SLOT)
                        turtle.place()
                        turtle.back()
                        turtle.select(TORCH_SLOT)
                        turtle.place()
end
 
function IsInvFull()
        intEmptySlots = 16
       
        for i = 1, 16 do
                if turtle.getItemCount(i) > 0 then
                        intEmptySlots = intEmptySlots - 1
                end
        end
       
        if intEmptySlots <= 1 then
                return true
        end
       
        return false
       
end
---------------------------------------
--Main
---------------------------------------
while intStepCount <= intLength do
        CheckTorches()
        DoFuel()
       
        --Dig forward until clear
        DoDig_Forward()
        --Move forward
        turtle.forward()
        --Check down for cobble, dig and replace if not
        DoCobble_Down()
        --Dig up until clear
        DoDig_Up()
        --Turn left
        turtle.turnLeft()
        --Dig forward until clear
        DoDig_Forward()
        --Move forward
        turtle.forward()
        --Check down for cobble, dig and replace if not
        DoCobble_Down()
        --Check forward for cobble, dig and replace if not
        DoCobble_Forward()
        --Dig up until clear
        DoDig_Up()
        --Move up
        turtle.up()
        --Place left torch if needed
        if intStepCount % 10 == 5 then
                DoTorch()
        else
        --Else check forward for cobble, dig and replace if not
                DoCobble_Forward()
        end
        --Dig up until clear
        DoDig_Up()
        --Move up
        turtle.up()
        --Check forward for cobble, dig and replace if not
        DoCobble_Forward()
        --Check up for cobble, dig and replace if not
        DoCobble_Up()
        --Turn right
        turtle.turnRight()
        --Turn right
        turtle.turnRight()
        --Dig forward until clear
        DoDig_Forward()
        --Move forward
        turtle.forward()
        --Check up for cobble, dig and replace if not
        DoCobble_Up()
        --Dig forward until clear
        DoDig_Forward()
        --Move forward
        turtle.forward()
        --Check up for cobble, dig and replace if not
        DoCobble_Up()
        --Check forward for cobble, dig and replace if not
        DoCobble_Forward()
        --Dig down
        DoDig_Down()
        --Move down
        turtle.down()
        --Place right torch if needed
        if intStepCount % 10 == 0 then
                DoTorch()
        else
        --Else check forward for cobble, dig and replace if not
                DoCobble_Forward()
        end
        --Dig down
        DoDig_Down()
        --Move down
        turtle.down()
        --Check forward for cobble, dig and replace if not
        DoCobble_Forward()
        --Check down for cobble, dig and replace if not
        DoCobble_Down()
        --Move back
        turtle.back()
        --Check for only one empty space
        Compress_Inv()
        if IsInvFull() == true then
        --Drop chest and dump extra junk if near full
                DoChest()
        end
               
        --Turn left
        turtle.turnLeft()
 
        intStepCount =  intStepCount + 1
end