local svg = {}

-- new system

function svg.node(tag, args, child)
	if child == '' then child = nil end
	local s = {}
	table.insert(s, assert(tag))
	for k,v in pairs(args) do
		
		-- used with nearly everything
		if k == 'style' then
			if type(v) == 'table' then
				local t = {}
				for k2,v2 in pairs(v) do
					table.insert(t, k2..':'..v2)
				end
				v = table.concat(t, ';')
			end
		
		-- used with poly and polyfill
		elseif k == 'points' then
			if type(v) == 'table' then
				local t = {}
				for _,v2 in ipairs(v) do
					table.insert(t, v2[1]..','..v2[2])
				end
				v = table.concat(t, ' ')
			end
		end
		if type(v) ~= 'number' and type(v) ~= 'string' then
			error('tried to convert non-convertable obj '..tostring(v)..' type '..type(v)..' for key '..k)
		end
		table.insert(s, k.."='"..v.."'")
	end
	s = '<' .. table.concat(s, ' ') 
	if not child then
		s = s .. '/>'
	else
		s = s .. '>' .. child .. '</' .. tag .. '>'
	end
	return s
end

function svg.text(args, child)
	return svg.node('text', args, child) 
end

function svg.line(args, child)
	return svg.node('line', args, child)
end

function svg.g(args, child)
	return svg.node('g', args, child)
end

function svg.polygon(args, child)
	return svg.node('polygon', args, child)
end

function svg.polyline(args, child)
	return svg.node('polyline', args, child)
end

function svg.rect(args, child)
	return svg.node('rect', args, child)
end

function svg.line(args, child)
	return svg.node('line', args, child)
end

function svg.matrix(...)
	return table.concat{'matrix(', table.concat({...}, ' '), ')'}
end

function svg.escape(s)
	s = s:gsub('&', '&amp;')
	return s
end

return svg
