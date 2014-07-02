require "parse"
--STUFF
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end
function trim2(s)
  return s:match "^%s*(.-)%s*$"
end
function deepcopy(t)
	if type(t) ~= 'table' then return t end
	local mt = getmetatable(t)
	local res = {}
	for k,v in pairs(t) do
		if type(v) == 'table' then
			v = deepcopy(v)
		end
		res[k] = v
	end
	setmetatable(res,mt)
	return res
end

tokens = {}

local f = assert(io.open("dat.dll", "r"))
local t = f:read("*all")
f:close()

local f2 = assert(io.open(t, "r"))
local t2 = f2:read("*all")
f2:close()


parseString(t2)
for i, v in ipairs(tokens) do
	print(v.a.."    "..v.b)
end


