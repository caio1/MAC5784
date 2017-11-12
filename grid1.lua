-- Screen size
local screenW, screenH, halfW, halfH = display.viewableContentWidth, display.viewableContentHeight, display.viewableContentWidth*0.5, display.viewableContentHeight*0.5

-- Grid
numberOfColumns = 16
columnWidth = math.floor( screenW / numberOfColumns )		
function getColumnPosition( columnNumber )
	return (columnNumber - 1) * columnWidth
end
function getColumnWidth( numberOfColumns )
	return numberOfColumns * columnWidth
end	

-- Loop columns
for i = 1, numberOfColumns do
	-- Loop thru records
	for y = 1, 26 do
		-- Set column and row
		local column = i
		local row = y * 20 - 20

		-- Set text of label
		local text = i
		if i < 10 then
			text = '0' .. text
		end
		
		-- Add newText
		local options = 
		{
			text = text,
			x = getColumnPosition(column),
			y = row,
			width = getColumnWidth(column+1),
			fontSize = 14,
			align = "left"
		}
		local label1 = display.newText( options )
		label1.anchorX = 0
		label1.anchorY = 0
	end
end	