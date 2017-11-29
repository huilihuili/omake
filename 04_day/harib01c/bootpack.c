void io_hlt(void);
void write_mem8(int addr, int data);

void HariMain(void)
{
	
	int i;
	char* p;
	
	for (i = 0xa0000; i <= 0xaffff; i++) {
		p = (char*) i;
		*p = i & 0x0f;
	}
	
	for (;;) {
		io_hlt();
	}
}

