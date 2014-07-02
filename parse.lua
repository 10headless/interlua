parseTokens = {
	{a = "PRINT", b = "print"},
	{a = "IF", b = "if"},
	{a = "EQUALS", b = "=="},
	{a = "ASSIGN", b = "="},
	{a = "LPAREN", b = "("},
	{a = "RPAREN", b = ")"},
	{a = "LBRACK", b = "{"},
	{a = "RBRACK", b = "}"},
	{a = "SEMICOLON", b = ";"}
}

function parseString(string)
	local last = 1
	local isString = false
	for i = 1, #string do
		local char = string:sub(last, i)
		local char_c = string:sub(i,i)
		local lastLast = last
		if isString == false then
			if char == " " or char == "\t" or char == "\n" then
				last = i + 1
			end
			
			if char_c == " " then
				if tonumber(char:sub(1, #char-1)) ~= nil then
					table.insert(tokens, {a = "INT", b = char:sub(1, #char-1)})
					last = i+1
				end
			end
			if i == #string then
				if tonumber(char) ~= nil then
					table.insert(tokens, {a = "INT", b = char})
					last = i+1
				end
			end
			if char_c == "\"" then
				isString = true
			end
			if isString == false and lastLast == last then
				for j, b in ipairs(parseTokens) do
					if char:find(b.b)~= nil then
						if char == b.b then
							table.insert(tokens, {a = b.a, b = b.b})
							last = i+1
						else
							local find = char:find(b.b)
							local s1 = char:sub(1,find-1)
							local s2 = char:sub(find)
							if tonumber(s1)~= nil then
								table.insert(tokens, {a = "INT", b = s1})
							else
								table.insert(tokens, {a = "NAME", b = s1})
							end
							table.insert(tokens, {a = b.a, b = s2})
							last = i+1
						end
					end	
				end
			end
		else
			if char_c == "\"" then
				table.insert(tokens, {a = "STRING", b = string:sub(last+1, i-1)})
				last = i + 1
			end
		end
	end
end