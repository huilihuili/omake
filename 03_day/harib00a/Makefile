TOOLPATH = ../../tolset/z_tools/
MAKE = $(TOOLPATH)make.exe -r
NASK = $(TOOLPATH)nask.exe
EDIMG = $(TOOLPATH)edimg.exe
IMGTOL = $(TOOLPATH)imgtol.com
COPY = copy
DEL = del


# 执行不带参数的make时候，就相当于执行"make img"命令
default :
	$(MAKE) img



# 如果想要制作ipl.bin，就下检查一下ipl.nas和Makefile这两个文件是否都准备好了
ipl.bin : ipl.nas Makefile 
	$(NASK) ipl.nas ipl.bin ipl.lst

helloos.img : ipl.bin Makefile
	$(EDIMG)   imgin:../../tolset/z_tools/fdimg0at.tek   wbinimg src:ipl.bin len:512 from:0 to:0   imgout:helloos.img
	
	
# 命令
img :
	$(MAKE) -r helloos.img 
	
asm :
	$(MAKE) -r ipl.bin

run :
	$(MAKE) img
	$(COPY) helloos.img ..\..\tolset\z_tools\qemu\fdimage0.bin
	$(MAKE) -C ../../tolset/z_tools/qemu

# 删除ipl.bin和 ipl.lst文件
clean :
	-$(DEL) ipl.bin
	-$(DEL) ipl.lst

# 执行clean命令，并且删除helloos.img文件
src_only :
	$(MAKE) clean
	-$(DEL) helloos.img