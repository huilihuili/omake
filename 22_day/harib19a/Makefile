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
		
a.bim : a.obj a_nask.obj Makefile
	$(OBJ2BIM) @$(RULEFILE) out:a.bim map:a.map a.obj a_nask.obj
		
a.hrb : a.bim Makefile
	$(BIM2HRB) a.bim a.hrb 0
	
hello3.bim : hello3.obj a_nask.obj Makefile
	$(OBJ2BIM) @$(RULEFILE) out:hello3.bim map:hello3.map hello3.obj a_nask.obj
	
hello3.hrb : hello3.bim Makefile
	$(BIM2HRB) hello3.bim hello3.hrb 0

crack1.bim : crack1.obj Makefile
	$(OBJ2BIM) @$(RULEFILE) out:crack1.bim map:crack1.map crack1.obj a_nask.obj
	
crack1.hrb : crack1.bim Makefile
	$(BIM2HRB) crack1.bim crack1.hrb 0

crack2.hrb : crack2.nas Makefile
	$(NASK) crack2.nas crack2.hrb crack2.lst
	
crack3.hrb : crack3.nas Makefile
	$(NASK) crack3.nas crack3.hrb crack3.lst
	
crack4.hrb : crack4.nas Makefile
	$(NASK) crack4.nas crack4.hrb crack4.lst

crack5.hrb : crack5.nas Makefile
	$(NASK) crack5.nas crack5.hrb crack5.lst

crack6.hrb : crack6.nas Makefile
	$(NASK) crack6.nas crack6.hrb crack6.lst
	
# 3MB+64KB=3136KB

bootpack.hrb : bootpack.bim Makefile
	$(BIM2HRB) bootpack.bim bootpack.hrb 0

hello.hrb : hello.nas Makefile
	$(NASK) hello.nas hello.hrb hello.lst
	
hello2.hrb : hello2.nas Makefile
	$(NASK) hello2.nas hello2.hrb hello2.lst
	
haribote.sys : asmhead.bin bootpack.hrb Makefile
	copy /B asmhead.bin+bootpack.hrb haribote.sys

haribote.img : ipl10.bin haribote.sys \
				hello.hrb hello2.hrb a.hrb hello3.hrb crack1.hrb crack2.hrb crack3.hrb crack4.hrb crack5.hrb crack6.hrb\
				Makefile
	$(EDIMG)   imgin:../../tolset/z_tools/fdimg0at.tek \
		wbinimg src:ipl10.bin len:512 from:0 to:0 \
		copy from:haribote.sys to:@: \
		copy from:ipl10.nas to:@: \
		copy from:make.bat to:@: \
		copy from:hello.hrb to:@: \
		copy from:hello2.hrb to:@: \
		copy from:a.hrb to:@: \
		copy from:hello3.hrb to:@: \
		copy from:crack1.hrb to:@: \
		copy from:crack2.hrb to:@: \
		copy from:crack3.hrb to:@: \
		copy from:crack4.hrb to:@: \
		copy from:crack5.hrb to:@: \
		copy from:crack6.hrb to:@: \
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
	-$(DEL) *.map
	-$(DEL) *.bim
	-$(DEL) *.hrb
	-$(DEL) int.nas
	-$(DEL) graphic.nas
	-$(DEL) dsctbl.nas
	-$(DEL) bootpack.map
	-$(DEL) bootpack.bim
	-$(DEL) bootpack.hrb
	-$(DEL) haribote.sys
# 执行clean命令，并且删除helloos.img文件
src_only :
	$(MAKE) clean
	-$(DEL) haribote.img