# Source codes for the slides


## Prerequisites
1. The slides were compiled using [lualatex](https://www.luatex.org/); see also [here](https://ctan.org/pkg/luatex?lang=en). You can also use [pdflatex](https://ctan.org/pkg/pdftex?lang=en) to compile the slides.
2. The [lua](https://www.lua.org/) script has been used to automate the compilation of the slides.

## Usage
1. Use [makefile.lua](./makefile.lua) to compile a list of slides. 
  * There are two special lists:
    *  [allfile.txt](./allfile.txt): list of all slides. In order to compile all
        slides, run
        `./makefile.lua allfile.txt`
    *  [Working_List txt](./Working_List.txt): the slides that are under development:
        `./makefile.lua Working_List.txt` 
2. Use [TeachingMath221_Spring2021.lua](./TeachingMath221_Spring2021.lua) script to open all slides specified in the list [Working_List.txt](./Working_List.txt)
3. For vim user, one may source [commands.vim](./commands.vim) when editing the
   slides, where one finds some handful commands for editing the slides.
4. [saveTable.lua](./saveTable.lua): this is an utility lua script.
