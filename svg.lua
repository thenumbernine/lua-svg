local svg = {}

function svg.poly(vtxs)
	local s = {"<polygon fill='#000000' points='"}
	local sep
	for i=1,#vtxs,2 do
		table.insert(s, sep)
		sep = ' '
		table.insert(s, vtxs[i])
		table.insert(s, ',')
		table.insert(s, vtxs[i+1])
	end
	table.insert(s, "'/>")
	return table.concat(s)
end

function svg.rect(xmin,xmax,ymin,ymax)
	return svg.poly{xmin,ymin,xmax,ymin,xmax,ymax,xmin,ymax}
end

-- there is a line, you know...
function svg.line(...)
	local args = {...}
	local color
	if type(args[1]) == 'table' then
		args = args[1]
		color = args.color
	end
	local x1,y1,x2,y2 = unpack(args,1,4)
	--[[
	local dx = x2 - x1
	local dy = y2 - y1
	local mag = math.max(math.sqrt(dx*dx + dy*dy), .001)
	local nx = .2 * dx / mag
	local ny = .2 * dy / mag
	return svg.poly{x1,y1, x2,y2, x2+ny,y2-nx, x1+ny,y1-nx}
	--]]
	local color
	if args.color then
		color = table.concat(args.color,',')
	else
		color = '0,0,0'
	end
	local width = args.width or 1
	s = {'<line x1="',x1,'" y1="',y1,'" x2="', x2, '" y2="', y2, '" style="stroke:rgb(',color,');stroke-width:',width,'"/>'}
	return table.concat(s)
end
function svg.matrix(...)
	return table.concat{'matrix(', table.concat({...}, ' '), ')'}
end

function svg.escape(s)
	s = s:gsub('&', '&amp;')
	return s
end

return svg

