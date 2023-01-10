#!/usr/bin/env lua
-- This script open all pdf files indicate by:
-- "Teaching_List.txt"


-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

-- tests the functions above
local path = "./"
local file = path .. 'Working_List.txt'
local lines = lines_from(file)
-- print("Print the lines now...")
-- for i=1,#lines,1 do
--    print(lines[i])
-- end
-- print("Done.")

-- print all line numbers and their contents
for k,v in pairs(lines) do
  filename=v:gsub(".tex","") .. "-Presentation.pdf"
  os.execute("zathura --page=1 ".. path .. filename .. " &")
  -- print("zathura ".. path .. filename)
  print('line[' .. k .. ']', filename)
end

