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
intLength = intLength or 5
if intLength % 5 ~= 0 then
	intLength = intLength - (intLength % 5)
end

locStart = vector.new(gps.locate())

intFacing = GetFacing()

---------------------------------------
--Functions
---------------------------------------

function GetFacing()
	turtle.forward()
	
	locNew = vector.new(gps.locate())
	
	if locNew.x > locStart.x then
		return 3
	elseif locNew.x < locStart.x then
		return 1
	elseif locNew.z > locStart.z then
		return 0
	elseif locNew.z < locStart.z then
		return 2
	else
		os.reboot()
	end
	
end


---------------------------------------
--Main
---------------------------------------

print("x: " .. locStart.x .. " y: " .. locStart.y .. " z: " .. z .. " f: " .. intFacing)