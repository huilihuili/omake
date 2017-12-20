OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj \
				int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj \
				mtask.obj console.obj file.obj window.obj

TOOLPATH = ../../tolset/z_tools/
INCPATH  = ../../tolset/z_tools/haribote/


MAKE = $(TOOLPATH)make.exe -r
NASK = $(TOOLPATH)nask.exe

CC1 = $(TOOLPATH)cc1.exe -I$(INCPATH) -Os -Wall -quiet
GAS2NASK = $(TOOLPATH)gas2nask.exe -a
OBJ2BIM  = $(TOOLPATH)obj2bim.exe
MAKEFONT = $(TOOLPATH)makefont.exe
BIM2HRB  = $(TOOLPATH)bim2hrb.exe
BIN2OBJ = $(TOOLPATH)bin2obj.exe
RULEFILE = $(TOOLPATH)haribote/haribote.rul

EDIMG = $(TOOLPATH)edimg.exe
IMGTOL = $(TOOLPATH)imgtol.com
COPY = copy
DEL = del


# 执行不带参数的make时候，就相当于执行"make img"命令
default :
	$(MAKE) img

# 如果想要制作ipl.bin，就下检查一下ipl.nas和Makefile这两个文件是否都准备好了
ipl10.bin : ipl10.nas Makefile 
	$(NASK) ipl10.nas ipl10.bin ipl10.lst

asmhead.bin : asmhead.nas Makefile
	$(NASK) asmhead.nas asmhead.bin asmhead.lst

hankaku.bin : hankaku.txt Makefile
	$(MAKEFONT) hankaku.txt hankaku.bin
	
hankaku.obj : hankaku.bin Makefile
	$(BIN2OBJ) hankaku.bin hankaku.obj _hankaku
	
bootpack.bim : $(OBJS_BOOTPACK) Makefile
	$(OBJ2BIM) @$(RULEFILE) out:bootpack.bim stack:3136k map:bootpack.map \
		$(OBJS_BOOTPACK)
		
# 3MB+64KB=3136KB

bootpack.hrb : bootpack.bim Makefile
	$(BIM2HRB) bootpack.bim bootpack.hrb 0

hello.hrb : hello.nas Makefile
	$(NASK) hello.nas hello.hrb hello.lst
	
haribote.sys : asmhead.bin bootpack.hrb Makefile
	copy /B asmhead.bin+bootpack.hrb haribote.sys

haribote.img : ipl10.bin haribote.sys hello.hrb Makefile
	$(EDIMG)   imgin:../../tolset/z_tools/fdimg0at.tek \
		wbinimg src:ipl10.bin len:512 from:0 to:0 \
		copy from:haribote.sys to:@: \
		copy from:ipl10.nas to:@: \
		copy from:make.bat to:@: \
		copy from:hello.hrb to:@: \
		imgout:haribote.img

		
%.gas : %.c bootpack.h Makefile
	$(CC1) -o $*.gas $*.c

%.nas : %.gas Makefile
	$(GAS2NASK) $*.gas $*.nas

%.obj : %.nas Makefile
	$(NASK) $*.nas $*.obj $*.lst

# 命令
img :
	$(MAKE) haribote.img 
	
run :
	$(MAKE) img
	$(COPY) haribote.img ..\..\tolset\z_tools\qemu\fdimage0.bin
	$(MAKE) -C ../../tolset/z_tools/qemu

# 删除ipl.bin和 ipl.lst文件
clean :
	-$(DEL) *.bin
	-$(DEL) *.lst
	-$(DEL) *.gas
	-$(DEL) *.obj
	-$(DEL) bootpack.nas
	-$(DEL) int.nas
	-$(DEL) graphic.nas
	-$(DEL) dsctbl.nas
	-$(DEL) bootpack.map
	-$(DEL) bootpack.bim
	-$(DEL) bootpack.hrb
	-$(DEL) haribote.sys
	-$(DEL) hello.hrb
# 执行clean命令，并且删除helloos.img文件
src_only :
	$(MAKE) clean
	-$(DEL) haribote.img