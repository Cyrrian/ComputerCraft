---------------------------------------
--Constants
---------------------------------------
 
FUEL_SLOT = 1
LIGHT_SLOT = 2
BLOCK_SLOT = 3
CHEST_SLOT = 4

---------------------------------------
--Functions
---------------------------------------

function GetFacing(locStart)
	turtle.forward()
	
	print("x: " .. locStart.x .. " y: " .. locStart.y .. " z: " .. locStart.z)
	
	locNew = vector.new(gps.locate())
	
	print("x: " .. locNew.x .. " y: " .. locNew.y .. " z: " .. locNew.z)
	
	if locNew.x > locStart.x then
		return 3
	elseif locNew.x < locStart.x then
		return 1
	elseif locNew.z > locStart.z then
		return 0
	elseif locNew.z < locStart.z then
		return 2
	else
		--os.reboot()
	end
	
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

locStart = vector.new(gps.locate())

intFacing = GetFacing(locStart)

---------------------------------------
--Main
---------------------------------------
print("x: " .. locStart.x .. " y: " .. locStart.y .. " z: " .. locStart.z .. " f: " .. intFacing)