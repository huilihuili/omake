void io_hlt(void);
void io_cli(void);
void io_out8(int port, int data);
int io_load_eflags(void);
void io_store_eflags(int eflags);


void init_palette(void);
void set_palette(int start, int end, unsigned char *rgb);
void boxfill8(unsigned char *vram, int xsize, unsigned char c, int x0, int y0, int x1, int y1);

#define COL8_000000		0		/*	0:黑		*/
#define COL8_ff0000		1		/*	1:亮红		*/
#define COL8_00ff00		2		/*	2:亮绿		*/
#define COL8_ffff00		3		/*	3:亮黄		*/
#define COL8_0000ff		4		/*	4:亮蓝		*/
#define COL8_ff00ff		5		/*	5:亮紫		*/
#define COL8_00ffff		6		/*	6:浅亮蓝	*/
#define COL8_ffffff		7		/*	7:白		*/
#define COL8_c6c6c6		8		/*	8:亮灰		*/
#define COL8_840000		9		/*	9:暗红		*/
#define COL8_008400		10		/*	10:暗绿		*/
#define COL8_848400		11		/*	11:暗黄		*/
#define COL8_000084		12		/*	12:暗青		*/
#define COL8_840084		13		/*	13:暗紫		*/
#define COL8_008484		14		/*	14:浅暗蓝	*/
#define COL8_848484		15		/*	15:暗灰		*/

void HariMain(void)
{
	
	int i;
	char* p;
	
	init_palette();
	
	p = (char*) 0xa0000;
	
	boxfill8(p, 320, COL8_ff0000, 20, 20, 120, 120);
	boxfill8(p, 320, COL8_00ffff, 70, 50, 170, 150);
	boxfill8(p, 320, COL8_ffff00, 120, 80, 220, 180);
	
	for (;;) {
		io_hlt();
	}
}

void init_palette(void) {
	static unsigned char table_rgb[16 * 3] = {
		0x00, 0x00, 0x00,		/*	0:黑		*/
		0xff, 0x00, 0x00,		/*	1:亮红		*/
		0x00, 0xff, 0x00,		/*	2:亮绿		*/
		0xff, 0xff, 0x00,		/*	3:亮黄		*/
		0x00, 0x00, 0xff,		/*	4:亮蓝		*/
		0xff, 0x00, 0xff,		/*	5:亮紫		*/
		0x00, 0xff, 0xff,		/*	6:浅亮蓝	*/
		0xff, 0xff, 0xff,		/*	7:白		*/
		0xc6, 0xc6, 0xc6,		/*	8:亮灰		*/
		0x84, 0x00, 0x00,		/*	9:暗红		*/
		0x00, 0x84, 0x00,		/*	10:暗绿		*/
		0x84, 0x84, 0x00,		/*	11:暗黄		*/
		0x00, 0x00, 0x84,		/*	12:暗青		*/
		0x84, 0x00, 0x84,		/*	13:暗紫		*/
		0x00, 0x84, 0x84,		/*	14:浅暗蓝	*/
		0x84, 0x84, 0x84		/*	15:暗灰		*/
	};
	set_palette(0, 15, table_rgb);
	return;
}

void set_palette(int start, int end, unsigned char *rgb) {
	int i, eflags;
	eflags = io_load_eflags();	/*	记录中断许可标志的值 */
	io_cli();					/*	将中断许可标志设置为0，禁止中断*/
	io_out8(0x03c8, start);
	for (i = start; i <= end; i++) {
		io_out8(0x03c9, rgb[0] /4);
		io_out8(0x03c9, rgb[1] /4);
		io_out8(0x03c9, rgb[2] /4);
		
		rgb += 3;
	}
	io_store_eflags(eflags);		/*	复原中断标志许可标志*/
	return;
}

void boxfill8(unsigned char *vram, int xsize, unsigned char c, int x0, int y0, int x1, int y1) {
	int x, y;
	for (y = y0; y <= y1; y++) {
		for (x = x0; x <= x1; x++) {
			vram[y * xsize + x] = c;
		}
	}
}

