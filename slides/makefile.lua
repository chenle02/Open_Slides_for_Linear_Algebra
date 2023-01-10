#!/usr/bin/env lua
if arg[1] == nil then
	print("Usage: makefile.lua tex_file_list.txt")
	print("See the sample file: allfile.txt")
	print("By Le Chen 06/2020, Emory")
	return
end

require("csv")
table = dataToTable(arg[1],'_')

loadfile("saveTable.lua")(table,"SavedTable.table")

for i=1,#table,1 do
	t = string.gsub(table[i][2],'.tex','')
	-- Handout first
	latexcmd = string.format("lualatex --interaction=batchmode %s_%s",table[i][1],table[i][2])
	cmd = string.format("sed -i 's/pdf,9pt/pdf,handout,9pt/g' %s_%s", table[i][1], table[i][2])
	os.execute(cmd)
	os.execute(latexcmd)
	os.execute(latexcmd)
	cmd = string.format("mv %s_%s.pdf %s_%s-Handout.pdf",table[i][1],t,table[i][1],t)
	os.execute(cmd)
	-- Presentation first
	cmd = string.format("sed -i 's/pdf,handout,9pt/pdf,9pt/g' %s_%s", table[i][1], table[i][2])
	print(cmd)
	os.execute(cmd)
	os.execute(latexcmd)
	os.execute(latexcmd)
	cmd = string.format("cp %s_%s.pdf %s_%s-Presentation.pdf",table[i][1],t,table[i][1],t)
	os.execute(cmd)
	-- Change back to Handout
	-- cmd = string.format("sed -i 's/pdf,9pt/pdf,handout,9pt/g' %s_%s", table[i][1], table[i][2])
	-- os.execute(cmd)
end


