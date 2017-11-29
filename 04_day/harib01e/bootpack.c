void io_hlt(void);
void write_mem8(int addr, int data);

void HariMain(void)
{
	
	int i;
	char* p;
	
	p = (char*) 0xa0000;
	for (i = 0; i <= 0xaffff; i++) {
		p[i] = i & 0x0f;
	}
	
	for (;;) {
		io_hlt();
	}
}

