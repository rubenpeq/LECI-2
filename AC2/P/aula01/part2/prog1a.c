int main(void)
{
    char c;
    int cnt = 0;
    do
    {
        c = getChar();
        putChar(c);
        cnt++;
    } while (c != '\n');
    printInt(cnt, 10);
    return 0;
}