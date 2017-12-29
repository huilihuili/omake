void api_putchar(int c);
void api_end(void);

void HariMain(void) {
	char a[100];
	a[10] = 'A';
	api_putchar(a[10]);
	
	a[102] = 'B';
	api_putchar(a[102]);
	
	a[103] = 'C';
	api_putchar(a[103]);
	
	api_end();
}