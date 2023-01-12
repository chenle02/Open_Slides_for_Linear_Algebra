--To include this file, use
--dofile('csv.lua') or require('csv')

--Function to convert a *SV file to a Lua array
--file: the name of the file to read
--delim: the delimeter (default ',')
function dataToTable(file, delim)
    --Set initial values
    if delim == nil then --allow delim to be optional
        delim = ','
    end
    file = io.open(file) --Always ensures that the file is in its beginning position
    local data = {}
    local row = 1
    
    --Loop through data
    for current in file:lines() do --file:lines() returns a string
        data[row] = {} --Initialize array within array (make 2d)
        local col = 1 --Used for adding individual columns of data
        data[row][col] = ""
        for ch in current:gmatch('.') do --ch is a character in the string
            if ch == delim then
                col = col + 1
                data[row][col] = "" --initialize string in new column
            else
                data[row][col] = data[row][col] .. ch
            end
        end
        row = row + 1
    end
    
    --Clean up
    file:close()
    return data
end

function tableToTeX(array, inject, inject_on)
    --[[
    array: the 2D array of data
    inject: string between tabular lines
    inject_on: list of lines to inject string at the end
            - Bound is [2, rows - 1], nil adds inject string to all lines
            - Out of bound line numbers are ignored
            - The list is sorted automatically
    For some reason, LuaLaTeX does not like it when I output newlines with
    \hlines. The output of this function is a continuous string.
    ]]
    
    --Initial conditions
    local result = ""
    local line = 1 --keeps track of add_to index, not used if inject_on is nil
    if inject_on ~= nil then
        table.sort(inject_on)
    end
    
    --Insert data
    for y=1, #array do
        if inject ~= nil and y ~= 1 then
            if inject_on == nil or inject_on[line] == y then
                result = result .. inject .. ' '
                line = line + 1
            end
        end
        for x=1, #array[y] do
            result = result .. array[y][x]
            if x < #array[y] then
                result = result .. " & "
            end
        end
        if y < #array then
            result = result .. " \\\\ "
        end
    end
    
    return result
end

--Extends the string type by allowing index selection via at(index) method.
--Can be called as s:at(index)
function string.at(self,index)
    return self:sub(index,index)
end

--[[Sample data (test.csv)
a,b,c
d,2,3
e,4,5
f,6,7
g,8,9
h,10,11
i,12,13
j,14,15
]]

--------------------------------------------------------------------------------

--[[Sample LuaTeX usage: test.tex
\documentclass[12pt,letterpaper]{article}%{{{
\usepackage[utf8x]{luainputenc}
\usepackage{luacode} %\luaexec macro: allows for '\\hline' in inline code
\def\arraystretch{2} %Give tabular environments internal padding
\begin{document}
 	\begin{tabular}{|c|c|c|}
 		\hline
		\luaexec{
			require('csv.lua')
			t = dataToTable('test.csv')
			tex.sprint(tableToTeX(t, '\\hline'))
		} \\
		\hline
	\end{tabular}
	\hspace{2cm}
 	\begin{tabular}{c|c|c}
		\luaexec{
			tex.sprint(tableToTeX(t, '\\hline', {2}))
		}
	\end{tabular}
	\hspace{2cm}
 	\begin{tabular}{c|cc}
		\luaexec{
			tex.sprint(tableToTeX(t, '\\hline', {2, 4, 6, 8}))
		}
	\end{tabular}
\end{document}
]]

--------------------------------------------------------------------------------

--[[Useful Forum Post (http://tex.stackexchange.com/questions/33096/which-lua-environment-should-i-use-with-luatex-lualatex)
	There are two questions here. You should consider asking one question at a time for your next posts.
	
	Now to the Lua code environment. Don't use any of them if you can. Just do
	
	\directlua{  require("myfile")  }
	
	and put all of your Lua code in that file. See another answer for a list of directories TeX searches for the file myfile.lua.
	
	If for some reason you can't do that (when you are only allowed to ship only one file for example) you should use the environment luacode* (with *) from the luacode package. That has the safest character catcodes. That means you can say something like:
	
	\begin{luacode*}
	texio.write_nl("This is a string with\n a newline in it")
	tex.print(-2, string.format( "5 %% 4 is %d ", 5 % 4))
	\end{luacode*}
	
	(You need the -2 as the first argument to tex.sprint(), because the % sign (resulting from the double %% is interpreted from TeX as a comment sign after the environment closes. TeX sees at the end of the environment 5 % 4 is 1 and treats the % as the end of input. So you need to tell TeX that this % is a regular character. You have two choices: either pass TeX a string like this: string.format("5 \\%% 4 is ...") so that TeX sees 5 \% 4 is ... as you would do with normal text or make % a normal letter, so TeX does not recognize it as a comment sign. To do that you have to change the category code. The easiest way is to assign the special catcode table -2 to tex.print(). It is a safe catcode table, no characters have a special meaning.)
	
	If you need to use TeX macros in Lua code, use the luacode environment (without *):
	
	\begin{luacode}
	    local current_page = tonumber(\thepage)
	    texio.write_nl("We are on page " .. current_page)
	\end{luacode}
	
	And if you need to put your code in a command, use \luaexec:
	
	\newcommand\myrepeat[2]{%
	\luaexec{
	  for i=1,#1 do
	     tex.sprint("\luatexluaescapestring{#2}")
	   end
	 }}
	
	\myrepeat{4}{Hello world}
	
	(you can't use the environments directly in a \newcommand, but you could use \luacodestar ... \endluacodestar if you really want the environment functionality). The \luatexluaescapestring{} is necessary to escape input characters like " that would be harmful to the Lua string.
	
	You have also asked if there is a shortcut such as the $...$ for math typesetting. No, there is none. IMO that is not such a big problem, as Lua code (in practice, but YMMV) is only used at a few points (with macros or with environments for example) and not so much in running text. Mostly in packages. (See the documentation to the luacolor package for example. Even if you don't understand the package in full detail at the first glance, you can see where the TeX code is with the \directlua calls, aliased in the example to \LuaCol@directlua and how the Lua code is separated from it in another file. See that there are only very few lines of Lua code inside the \LuaCol@directlua commands? In my opinion we can learn a lot from this code, as Heiko Oberdiek is an excellent package writer.)
	
	Now to your second question about Saving variables. If you don't declare your variables local, they are accessible in all Lua chunks. But you are asking to pass Lua code to TeX. You can do this for example:
	
	\begin{luacode*}
	tex.sprint("\setcounter{mycounter}{" .. my_lua_value .. "}")
	\end{luacode*}
	
	to create a \setcounter command with your value. Or you can use the tex.count Lua interface:
	
	\begin{luacode*}
	tex.count[10] = my_lua_value
	\end{luacode*}
	
	and your value is in \count10. But this is a bit dangerous as you have to be certain to use a free counter.
]]
