# 文件生成规则

# 执行不带参数的make时候，就相当于执行"make img"命令
default :
	../../tolset/z_tools/make.exe img



# 如果想要制作ipl.bin，就下检查一下ipl.nas和Makefile这两个文件是否都准备好了
ipl.bin : ipl.nas Makefile 
	../../tolset/z_tools/nask.exe ipl.nas ipl.bin ipl.lst

helloos.img : ipl.bin Makefile
	../../tolset/z_tools/edimg.exe   imgin:../../tolset/z_tools/fdimg0at.tek   wbinimg src:ipl.bin len:512 from:0 to:0   imgout:helloos.img
	
	
# 命令
img :
	../../tolset/z_tools/make.exe -r helloos.img 
	
asm :
	../../tolset/z_tools/make.exe -r ipl.bin

run :
	../../tolset/z_tools/make.exe img
	copy helloos.img ..\..\tolset\z_tools\qemu\fdimage0.bin
	../../tolset/z_tools/make.exe -C ../../tolset/z_tools/qemu

# 删除ipl.bin和 ipl.lst文件
clean :
	-del ipl.bin
	-del ipl.lst

# 执行clean命令，并且删除helloos.img文件
src_only :
	../../tolset/z_tools/make.exe clean
	-del helloos.img