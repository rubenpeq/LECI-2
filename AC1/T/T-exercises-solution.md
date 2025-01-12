# Theory Exercises

## 1. Quais são os 3 blocos fundamentais de um sistema computacional?
Os 3 blocos fundamentais de um sistema computacional são o **CPU**, **memória** e as **unidades de I/O**.

## 2. Quais são os 3 principais blocos funcionais na arquitetura de um CPU?
Os 3 blocos principais na arquitetura de um CPU são a **unidade de controlo**, a **secção de dados** e o **espaço de endereçamento**.

## 3. Qual a função do registo Program Counter?
O Program Counter serve para guardar o endereço da próxima instrução a ser executada.

## 4. Descreva de forma sucinta a função de um compilador.
Um compilador é um programa que converte um código fonte de linguagem de mais alto nivel para código de linguagem assembly.

## 5. Descreva de forma sucinta a função de um assembler. 
Um assembler é um programa que traduz código escrito em assembly para código de máquina (binário), que pode ser diretamente executado pelo processador.

## 6. Quantos registos internos de uso geral tem o MIPS?
O MIPS tem **32 registos internos** de uso geral.

## 7. No MIPS, qual a dimensão, em bits, que cada um dos registos internos pode armazenar? 
Cada registo interno no MIPS pode armazenar **32 bits**.

## 8. Qual a sintaxe, em Assembly do MIPS, de uma instrução aritmética de soma ou subtração?
soma        -> ``add r, a, b  # r = a+b``<br>
subtração   -> ``sub r, a, b  # r = a-b``

## 9. O que distingue a instrução **srl** da instrução **sra** do MIPS?
O **srl** não mantém o sinal (o bit inserido é sempre 0) enquanto **sra** mantém o sinal (O bit inserido é igual ao bit mais significativo).

## 10. Se $5=0x81354AB3, qual o resultado armazenado no registo destino, expresso em hexadecimal, das instruções:
### a. srl $3,$5,1
$5 = 1000 0001 0011 0101 0100 1010 1011 0011 = **0x81354AB3**<br>
$3 = 0100 0000 1001 1010 1010 0101 0101 1001 = **0x409AA55A**

### b. sra $4,$5,1
$5 = 1000 0001 0011 0101 0100 1010 1011 0011 = **0x81354AB3**<br>
$4 = 1100 0000 1001 1010 1010 0101 0101 1001 = **0xC09AA55A**

## 11. System calls:
### a. O que é um system call?
Um system call é um pedido que um programa faz ao sistema operativo para executar uma tarefa.

### b. No MIPS, qual o registo usado para identificar o system call a executar?
O registo $v0 é usado para identificar o número do system call a ser executado no MIPS.

### c. Qual o registo ou registos usados para passar argumentos para os systems calls?
Os registos $a0, $a1, $a2 e $a3 são usados para passar argumentos para os system calls no MIPS.

### d. Qual o registo usado para obter o resultado devolvido por um system call (nos casos em que isso se aplica)?
O registo $v0 é usado para armazenar o resultado devolvido por um system call no MIPS.

## 12. Em Arquitetura de Computadores, como definiria o conceito de endereço?
Um endereço é uma identificação única que indica a localização de um dado ou de uma instrução na memória de um computador.

## 13. Defina o conceito de espaço de endereçamento de um processador?
O espaço de endereçamento de um processador é o conjunto total de endereços de memória que ele pode acessar.

## 14. Como se organiza internamente um processador? Quais são os blocos fundamentais da secção de dados? Para que serve a unidade de controlo? 
Um CPU é organizado em blocos funcionais: secção de dados e a unidade de controlo.
Os blocos fundamentais da secção de dados são os registos internos, ALU e multiplexers.
A unidade de controlo é responsável pela coordenação dos elementos do datapath, durante a execução de um programa:
- Gera os sinais de controlo que adequam a operação de cada um dos recursos da secção de dados às necessidades da instrução que estiver a ser executada
- Dependendo da arquitetura, pode ser uma máquina de estados ou um elemento meramente combinatório
- Independentemente da Unidade de Controlo ser combinatória ou sequencial, o CPU é sempre uma máquina de estados síncrona

## 15. Qual é o conceito fundamental por detrás do modelo de arquitetura "**stored-program**"?
O conceito "**stored-program**" implica que na memória possa residir, ao mesmo tempo, informação de natureza tão variada como: o código fonte de um programa em C, um editor de texto, um compilador, e o próprio programa resultante da compilação.

## 16. Como se codifica uma instrução? Que informação fundamental deverá ter o código máquina de uma instrução?
A codificação em MIPS é feita por uma sequência de 32 bits e varia dependendo do formato (R, I ou J).<br>
Independentemente do formato, tem sempre o OpCode presente nos 6 bits mais significativos.<br>
Pode também conter registos(operandos): Identifica os registos a serem utilizados na operação.<br>
Offset de um endereço de memória (se necessário): Indica a localização de dados ou instruções na memória.

## 17. Descreva pelas suas próprias palavras o conceito de ISA (Instruction Set Architecture).
O ISA é o conjunto de instruções e regras que define como o hardware e o software de um processador interagem.
Especifica as operações que o processador pode realizar, como somar, carregar dados da memória ou realizar saltos, além do formato das instruções, modos de endereçamento e tipos de dados suportados. É a interface que conecta o software ao hardware.

## 18. Independentemente do modelo da arquitetura, identifique quantas e quais as classes de instruções que compões o conjunto de instruções executáveis por um processador dessa arquitetura?
Existem 3 tipos de classes de instruções:
- **Processamento**
    - Aritméticas e lógicas
- **Transferência de informação**
    - Cópia entre registos internos e entre registos internos e memória
- **Controlo de fluxo de execução**
    - Alteração da sequência de execução (estruturas condicionais, ciclos, chamadas a funções,…)

## 19. O que carateriza e distingue as arquiteturas do tipo "**register-memory**" e "**load-store**"? De que tipo é a arquitetura MIPS?
A arquitetura do tipo "**register-memory**" permite que os operandos das instruções aritméticas e lógicas residam tanto nos registos internos do CPU como em memória.
No caso de "**load-store**", apenas permite que os operandos residam nos registos internos do CPU. MIPS usa uma arquitetura **load-store**.

## 20. O ciclo de execução de uma instrução é composto por uma sequência ordenada de operações. Quantas e quais são essas operações (passos de execução)?
O cicle do execução de uma instrução é composto por 5 operações:
- **Fase Fetch**
    - Instruction fetch: leitura do código máquina da instrução (instrução reside em memória)
    - Instruction decode: descodificação da instrução pela unidade de controlo
- **Fase Execute**
    - Operand fetch: leitura do(s) operando(s)
    - Execute: execução da operação especificada pela instrução
    - Store result: armazenamento do resultado da operação no destino especificado na instrução

## 21. Como se designa o barramento que permite identificar, na memória, a origem ou o destino da informação transferida?
Designa-se como **Address Bus**.

## 22. Qual a finalidade do barramento normalmente designado por Data Bus?
O barramento designado por **Data Bus** é o que permite a transferência de informação entre **CPU** <-> **memória** ou **I/O**.

## 23. Os processadores da arquitetura hipotética ZWYZ possuem 4 registos internos e todas as instruções são codificadas usando 24 bits. Num dos formatos de codificação existem 5 campos: um OpCode com 5 bits, três campos para identificar registos internos em operações aritméticas e lógicas e um campo para codificar valores constantes imediatos em complemento para dois. Qual a gama de representação destas constantes?
Seria necessário 2 bits para identificar cada registo interno, ou seja, 6 bits para identificar 3 registos internos + 5 bits do OpCode.<br>
Sobram 13 bits para o campo dos valores constantes imediatos, sendo que este está codificado em complemento para dois, a gama de representação seria entre **$2^{12}$** e **$2^{12}-1$**

## 24.  A arquitetura hipotética ZPTZ tem um barramento de endereços de 32 bits e um barramento de dados de 16 bits. Se a memória desta arquitetura for bit_addressable:
### a. Qual a dimensão do espaço de endereçamento desta arquitetura?
A dimensão de endereçamento seria de **$2^{32}$ endereços**.

### b. Qual a dimensão máxima da memória, expressa em bytes, suportada por esta arquitetura?
A dimensão máxima da memória seria de **$2^{32}$ bits**, ou seja, **$2^{29}$ bytes (512MB)**.

## 25. Considere agora uma arquitetura em que o respetivo ISA especifica uma organização de memória do tipo word-addressable, em que a dimensão da word é 32 bits. Tendo o espaço de endereçamento do processador 24 bits, qual a dimensão máxima de memória que este sistema pode acomodar se expresso em bytes?
Este sistema pode acomodar $2^{24} \times 32$ bits, ou seja, **64 MB** de memória.

## 26. Relativamente à arquitetura MIPS:
### a. Com quantos bits são codificadas as instruções no MIPS?
Em MIPS, cada instrução é codificada com **32 bits**.

### b. O que diferencia o registo $0 dos restantes registos de uso geral?
O **registo $0** contém sempre o valor **0x00000000** na arquitetura MIPS.

### c. Qual o endereço do registo interno do MIPS a que corresponde a designação lógica $ra?
O registo correspondente à designação lógica $ra é o **registo $31**.

## 27. No MIPS, um dos formatos de codificação de instruções é designado por R: 
### a. Quais os campos em que se divide este formato de codificação?
Este formato divide-se em 6 campos:
- **op** (6 bits)
- **rs** (5 bits)
- **rt** (5 bits)
- **rd** (5 bits)
- **shamt** (5 bits)
- **funct** (6 bits)

### b. Qual o significado de cada um desses campos?
- **op**
    - OpCode (é sempre zero nas instruções tipo R)
- **rs**
    - Endereço do registo que contém o 1º operando fonte
- **rt**
    - Endereço do registo que contém o 2º operando fonte
- **rd**
    - Endereço do registo onde o resultado vai ser armazenado
- **shamt**
    - shift amount (útil apenas em instruções de deslocamento)
- **funct**
    - código da operação a realizar


### c. Qual o valor do campo opCode nesse formato?
O valor do campo OpCode no formato R é sempre 0.

### d. O que faz a instrução cujo código máquina é: 0x00000000?
A instrução cujo código máquina é 0x00000000 no MIPS é um NOP (No Operation), que simplesmente não faz nada e avança o pipeline.

## 28. O símbolo ”>>“ da linguagem C significa deslocamento à direita e é traduzido em assembly por srl ou sra (no caso do MIPS). Dê exemplos de casos em linguagem C em que o compilador gera um srl e exemplos em que gera um sra.
O compilador utilizará **srl** para tipos **unsigned**(ex. **unsigned int**) e **sra** para tipos **signed**(ex. **int**).

## 29. Qual a instrução nativa do MIPS em que é traduzida a instrução virtual "move $4,$15"?
A instrução virtual ``move $4, $15`` será traduzida para ``or $4, $15, $0``.

## 30. Determine o código máquina das seguintes instruções (verifique a tabela na última página):   
### a. xor $5,$13,$24
op = 000000<br>
rs = 01101<br>
rt = 11000<br>
rd = 00101<br>
shamt = 00000<br>
funct = 100110<br>
Código máquina -> **0x01B82826** (**0000 0001 1011 1000 0010 1000 0010 0110**)

### b. sub $25,$14,$8
op = 000000<br>
rs = 01110<br>
rt = 01000<br>
rd = 11001<br>
shamt = 00000<br>
funct = 100010<br>
Código máquina -> **0x01C8C822** (**0000 0001 1100 1000 1100 1000 0010 0010**)

### c. sll $3,$9,7
op = 000000<br>
rs = 00000<br>
rt = 01001<br>
rd = 00011<br>
shamt = 00111<br>
funct = 000000<br>
Código máquina -> **0x000919C0** (**0000 0000 0000 1001 0001 1001 1100 0000**)

### d. sra $18,$9,8
op = 000000<br>
rs = 00000<br>
rt = 01001<br>
rd = 10010<br>
shamt = 01000<br>
funct = 000011<br>
Código máquina -> **0x00099203** (**0000 0000 0000 1001 1001 0010 0000 0011**)

## 31. Traduza para instruções Assembly do MIPS a seguinte expressão aritmética, supondo que x e y são inteiros e residentes em $t2 e $t5, respetivamente (apenas pode usar instruções nativas e não deverá usar a instrução de multiplicação): <br> y = -3 * x + 5;
```asm
add     $t5, $t2, $t2    # $t5 = 2x
add     $t5, $t0, $t2    # $t5 = 3x
sub     $t5, $0, $t0     # $t5 = -3x
addi    $t5, $t5, 5      # $t5 = -3 * x + 5
```

## 32. Traduza para instruções assembly do MIPS o seguinte trecho de código:
```c
int a, b, c;    //a:$t0, b:$t1, c:$t2
unsigned int x, y, z;  //x:$a0, y:$a1, z:$a2
z = (x >> 2) + y;
c = (a >> 5) – 2 * b;
```
```asm
sll     $a2, $a0, 2         # $a2 = (x >> 2)
add     $a2, $a2, $a1       # z = (x >> 2) + y
sra     $t2, $t0, 5         # $t2 = (a >> 5)
add     $t3, $t1, $t1       # $t3 = 2b
sub     $t2, $t2, $t3       # c = (a >> 5) – 2 * b
```

## 33. Considere que as variáveis g, h, i e j são conhecidas e podem ser representadas por uma variável de 32 bits num programa em C. Qual a correspondência, em linguagem C, às seguintes instruções:  
### a.
```asm
add  h, i, g    # h = i + g
```
### b.
```asm
addi j, j, 1   # j++
add  h, h, j   # h = h + j
```

## 34. Assumindo que g=1, h=2, i=3 e j=4 qual o valor destas variáveis no final das sequências das alíneas da questão anterior?
Após as instruções das alíneas anteriores, as variáveis têm os seguintes valores:
- g = 1;
- h = 9;
- i = 3;
- j = 5;

## 35. Descreva a operação realizada pela instrução assembly "slt" e quais os resultados possíveis?
A instrução **slt(set if lesser than)** é usada para comparar dois registos. ``slt $d, $s, $t``:
- **$d = 1** se **$s < $t**
- **$d = 0** se **$s >= $t**

## 36.  Qual o valor armazenado no registo $1 na execução da instrução "slt $1, $3, $7", admitindo que:   
### a. $3=5 e $7=23
**$1 = 1** (5 < 23)
### b. $3=0xFE e $7=0x913D45FC
**$1 = 0** (0xFE(-2) > 0x913D45FC(-1852024068))

## 37. Com que registo implícito comparam as instruções "bltz", "blez", "bgtz" e "bgez"?
As instruções **bltz**, **blez**, **bgtz** e **bgez** comparam com o **registo $0** (0).

## 38.  Decomponha em instruções nativas do MIPS as seguintes instruções virtuais:  
### a. blt $15,$3,exit
```asm
slt $1, $15, $3
bne $1, $0, exit
```
### b. ble $6,$9,exit
```asm
slt $1, $9, $6
beq $1, $0, exit
```
### c. bgt $5,0xA3,exit
```asm
addi $1, $0, 0xA3
slt $1, $1, $5
bne $1, $0, exit
```
### d. bge $10,0x57,exit
```asm
slti $1, $10, 0x57
beq $1, $0, exit
```
### e. blt $19,0x39,exit
```asm
slti $1, $19, 0x39
bne $1, $0, exit
```
### f. ble $23,0x16,exit
```asm
addi $1, $0, 0x16
slt $1, $1, $23
beq $1, $0, exit
```

## 39. Na tradução de C para assembly, quais as principais diferenças entre um ciclo "while(...){...}" e um ciclo "do{...}while(...);"?
Num ciclo **"while(...){...}"** as instruções de branch encontram-se no inicio do ciclo e tem um salto incondicional no final, enquanto um ciclo **"do{...}while(...)"** apenas tem instruções de branch no final do ciclo, sem salto incondicional.

## 40. Traduza para assembly do MIPS os seguintes trechos de código de linguagem C (admita que a, b e c residem nos registos $4, $7 e $13, respetivamente):  
### a.  
```c
if(a > b && b != 0)
    c = b << 2;
else
    c = (a & b) ^ (a | b);
```
```asm
    ble $4, $7, else
    beq $7, $0, else
if:
    sll $13, $7, 2      # c = b << 2
else:
    and $8, $4, $7      # $8 = (a & b)
    or $9, $4, $7       # $9 = (a | b)
    xor $13, $8, $9     # c = (a & b) ^ (a | b)
```
### b.  
```c
if(a > 3 || b <= c)
    c = c – (a + b);
else
    c = c + (a – 5);
```
```asm
    bgt $4, 3, if
    ble $7, $13, if
    j else
if:
    add $5, $4, $7      # $5 = (a + b)
    sub $13, $13, $5    # c = c – (a + b)
else:
    addi $5, $4, -5     # $5 = (a - 5)
    add $13, $13, $5    # c = c + (a – 5)
```

## 41. Como se designa o modo de endereçamento usado pelo MIPS para ter acesso a palavras residentes na memória externa?
Designa-se por **endereçamento indireto por registo com deslocamento**, em que o endereço de acesso à memória é calculado pela soma algébrica do conteúdo do registo com o offset.

## 42. Na instrução "lw $3,0x24($5)" qual a função dos registos $3, $5 e da constante 0x24?
Na instrução ``lw $3,0x24($5)``:
- $3: Registo no qual vai ser armazenado o valor lido da memória
- $5: Registo que contém o endereço base, a partir do qual vai ser adicionado o offset
- 0x24: Esta constante é o offset que irá ser adicionado ao conteúdo do registo $5, dando o endereço da memória a ser lido.

## 43. Qual é o tipo de codificação das instruções de acesso à memória no MIPS? Descreva o seu formato e o significado de cada um dos seus campos?
O formato do tipo I é o utilizado para o acesso à memória no MIPS. Este formato divide-se em 4 campos:
- **op**(6 bits)
    - OpCode.
- **rs**(5 bits)
    - Registo que contém o endereço base a ser somado pelo **offset**.
- **rt**(5 bits)
    - registo destino se for uma operação de leitura ou registo fonte se for uma operação de escrita.
- **offset**(16 bits)
    - **offset** a ser somado com **rs**.

## 44. Qual a diferença entre as instruções "sw" e "sb"?
A instrução **sb** guarda num endereço da memória 1 byte de informação, enquanto **sw** guarda 4 bytes (o endereço em que vai ser guardado o valor tem de estar alinhado a 4).

## 45. O que distingue as instruções "lb" e "lbu"?
Ambas as instruções leem 1 byte da memória mas **lbu(load byte unsigned)** coloca todos os 24 bits mais significativos a 0, enquanto **lb(load byte)** faz a extensão de sinal dos 8 bits menos significativos para 32 bits.

## 46. O que acontece quando uma instrução lw/sw tenta aceder a um endereço que não é múltiplo de 4?
Quando o MIPS tenta aceder à memória nesse endereço, verifica que o endereço é inválido e gera uma exceção, terminando aí a execução do programa.

## 47. Traduza para assembly do MIPS os seguintes trechos de código de linguagem C (atribua registos internos para o armazenamento das variáveis i e k ):
### a.
```c
int i, k;
for(i=5, k=0; i < 20; i++, k+=5);
```
```asm
li $t0, 5               # i=5
li $t1, 0               # k=0
for:
bge $t0, 20, endfor     # for(i<20)
addi $t0, $t0, 1        # i++
addi $t1, $t1, 5        # k+=5
j for

endfor:
```
 
### b.
```c
int i=100, k=0;
for( ; i >= 0; )
{
    i--;
    k -= 2;
}
```
```asm
li $t0, 100             # i=100
li $t1, 0               # k=0
for: bltz $t0, endfor   # for(i>=0)
addi $t0, $t0, -1       # i--
addi $t1, $t1, -2       # k-=2

endfor:
```
  
### c.
```c
unsigned int k=0;
for( ; ; )
{
k += 10;
}
```
```asm
li $t0, 0           # k=0
for:
addiu $t0, $t0, 10  # k+=10

endfor:
```
### d.
```c
int k=0, i=100;
do
{
    k += 5;
} while(--i >= 0);
```
```asm
li $t0, 0       # k=0
li $t1, 100     # i=100
do:
addi $t0, $t0, 5    # k+=5
addi $t1, $t1, -1   # --i
bgez $t1, do
```

## 48. Sabendo que o OpCode da instrução "lw" é 0x23, determine o código máquina, expresso em hexadecimal, da instrução "lw $3,0x24($5)".
OpCode = 100011<br>
rs = 00101<br>
rt = 00011<br>
offset = 0000000000100100<br>
Código máquina -> **0x8CA30024** (**1000 1100 1010 0011 0000 0000 0010 0100**)

## 49. Suponha que o conteúdo da memória externa foi inicializada, a partir do endereço 0x10010000, com os valores 0x01,0x02,0x03,0x04,0x05,0x06,0x07 e assim sucessivamente. Suponha ainda que $3=0x1001 e $5=0x10010000. Qual o valor armazenado no registo destino após a execução da instrução "lw $3,0x24($5)" admitindo uma organização de memória little endian?
O endereço a ser lido, calculado de $5 + 0x24 = 0x10010024:
```
0x10010024: 0x25 (LSB)
0x10010025: 0x26
0x10010026: 0x27
0x10010027: 0x28 (MSB)
```
Em uma organização **little-endian**, o byte menos significativo é armazenado no endereço mais baixo da memória, assim o valor completo carregado em $3 será **0x28272625**

## 50. Considere as mesmas condições da questão anterior. Qual o valor armazenado no registo destino pelas instruções: 
### a.
```
lbu $3,0xA3($5)

0x100100A3: 0xA4
$3 = 0x000000A4
```
### b. 
```
lb  $4,0xA3($5)

0x100100A3: 0xA4
$3 = 0xFFFFFFA4
```

## 51. Quantos bytes são reservados no segmento de dados da memória por cada uma das seguintes diretivas:  
### a. L1: .asciiz "Aulas5&6T"
**10 bytes**
### b. L2: .byte 5,8,23
**3 bytes**
### c. L3: .word 5,8,23
**12 bytes**
### d. L4: .space 5
**5 bytes**

## 52. Desenhe esquematicamente a memória e preencha-a com o resultado das diretivas anteriores admitindo que são interpretadas sequencialmente pelo Assembler.
|Address    |Value  |
|   :---:   | :---:	|
|0x10010000 | "aluA"  |
|0x10010004 | "6&5s"  |
|0x10010008 | 0x0805'\0T'|
|0x1001000C | 0x00000017 |
|0x10010010 | 0x00000005 |
|0x10010014 | 0x00000008 |
|0x10010018 | 0x00000017 |
|0x1001001C | 0x00000000 |
|0x10010020 | 0x00000000 |

## 53. Supondo que "L1:" corresponde ao endereço inicial do segmento de dados, e que esse endereço é 0x10010000, determine os endereços a que correspondem os labels "L2:",  "L3:" e "L4:"
- **L1** -> 0x10010000
- **L2** -> 0x1001000A
- **L3** -> 0x10010010
- **L4** -> 0x1001001C

## 54. Suponha que "b" é um array declarado como "int b[25];": 
### a. Como é obtido, em C, o endereço inicial do array, i.e., o endereço a partir do qual está armazenado o seu primeiro elemento?  
O endereço pode ser obtido por exemplo com ``int *p = b`` ou ``int *p = &b[0]``.

### b. Supondo uma memória "byte-addressable", como é obtido, em assembly o endereço do elemento "b[6]"?
```asm
la $t1, array   # $t1 = &b[0]
lw $t0, 24($t1) # $t0 = b[6]
```

## 55. O que é codificado no campo offset do código máquina das instruções "beq/bne"?
No campo offset das instruções **beq/bne** está codificada a diferença entre o endereço do **label** e o valor do **PC(program counter)**, dividindo o resultado por 4 pois o endereço é sempre multiplo de 4 (**offset = (label - PC) >> 2**).

## 56. A partir do código máquina de uma instrução "beq/bne", como é formado o endereço-alvo (Branch Target Address)?
**Branch Target Adress = PC + (offset << 2)**.

## 57. Qual o formato de codificação de cada uma das seguintes instruções: "beq/bne", "j", "jr"?
- **beq/bne**: Formato I
- **j**: Formato J
- **jr**: Formato R

## 58. A partir do código máquina de uma instrução "j", como se obtém o endereço-alvo (Jump Target Address)?
O **Jump Target Adress** é pelos 4 bits mais significativos do PC, seguido dos 26 bits codificados no formato J, usando 2 shifts à esquerda (**PC[31-28]+(código máquina[25-0] << 2)**).

## 59. Dada a seguinte sequência de declarações:  
```c
int b[25];
int a;
int *p = b;
```
Identifique qual ou quais das seguintes atribuições permitem aceder ao elemento de índice 5 do array "b":  
| a = b[5]; | a = *p + 5; | a = *(p + 5); | a = *(p + 20); |
|:---:|:---:|:---:|:---:|
| sim | não | sim | não |

## 60. Assuma que as variáveis f, g, h, i e j correspondem aos registos $t0, $t1, $t2, $t3 e $t4 respetivamente. Considere que o endereço base dos arrays de inteiros A e B está contido nos registos $s0 e $s1. Considere ainda as seguintes expressões:
```c
f = g + h + B[2]
j = g - A[B[2]]
```
### a. Qual a tradução para assembly de cada uma das instruções C indicadas?
```asm
lw $t0, 8($s1)      # $t0 = B[2]
add $t0, $t0, $t2   # $t0 = h + B[2]
add $t0, $t0, $t1   # f = g + h + B[2]
```
```asm
lw $t4, 8($s1)      # $t4 = B[2] 
sll $t4, $t4, 2     # $t4 = B[2]*4
addu $t4, $t4, $s1  # $t4 = A[B[2]]
sub $t4, $t1, $t4   # j = g - A[B[2]]
```

### b. Quantas instruções assembly são necessárias para cada uma das instruções C indicadas? E quantos registos auxiliares são necessários?
Para ``f = g + h + B[2]`` foram usadas 3 instruções assembly e em ``j = g - A[B[2]]`` são necessárias 4 instruções assembly. Em ambas não foi necessário utilizar nenhum registo auxiliar.

### c. Considerando a tabela seguinte que representa o conteúdo byte-a-byte da memória, nos endereços correspondentes aos arrays A e B, indique o valor de cada elemento dos arrays assumindo uma organização little endian.
| Endereço | Valor |
|:--------:|:-----:|
| A+12     | ...   |
| A+11     | 0x00  |
| A+10     | 0x00  |
| A+9      | 0x00  |
| A+8      | 0x01  |
| A+7      | 0x22  |
| A+6      | 0xED  |
| A+5      | 0x34  |
| A+4      | 0x00  |
| A+3      | 0x00  |
| A+2      | 0x00  |
| A+1      | 0x00  |
| A+0      | 0x12  |

| A | Valor |
|:----:|:----:|
| A[0] | 0x00000012 |
| A[1] | 0x22ED3400 |
| A[2] | 0x00000001 |

| Endereço | Valor |
|:--------:|:-----:|
| B+12     | ...   |
| B+11     | 0x00  |
| B+10     | 0x00  |
| B+9      | 0x00  |
| B+8      | 0x02  |
| B+7      | 0x00  |
| B+6      | 0x00  |
| B+5      | 0x50  |
| B+4      | 0x02  |
| B+3      | 0xFF  |
| B+2      | 0xFF  |
| B+1      | 0xFF  |
| B+0      | 0xFE  |

| B | Valor |
|:----:|:----:|
| B[0] | 0xFFFFFFFE |
| B[1] | 0x00005002 |
| B[2] | 0x00000002 |

### d. Assumindo que g = -3 e h = 2, qual o valor final das variáveis f e j?
f = g + h + B[2] = -3 + 2 + 0x02 = **0x00000001 (1)** 
j = g - A[B[2]] = -3 - A[2] = -3 - 0x01 = **0xFFFFFFFC (-4)**

## 61. Pretende-se escrever uma função para a troca do conteúdo de duas variáveis (a e b).
**Isto é, se, antes da chamada à função, a=2 e b=5, então, após a chamada à função, os valores de a e b devem ser: a=5 e b=2**
**Uma solução incorreta para o problema é a seguinte:**
```c
void troca(int x, int y)
{
    int aux;
    aux = x;
    x = y;
    y = aux;
}
```
**Identifique o erro presente no trecho de código e faça as necessárias correções para que a função tenha o comportamento pretendido.**<br>
A solução anterior troca apenas a cópia dos valores que foram dados à função, para alterar os valores originais teria de ser com os ponteiros para as variáveis.
```c
void troca(int *x, int *y)
{
    int aux;
    aux = *x;
    *x = *y;
    *y = aux;
}
```

## 62. Na instrução "jr $ra", como é obtido o endereço-alvo?
Na instrução ``jr $ra`` o endereço-alvo é o valor presente no registo $ra.

## 63. Qual é o menor e o maior endereço para onde uma instrução "j", residente no endereço de memória 0x5A18F34C, pode saltar?
Uma instrução do tipo **j** tem os 4 bits mais significantes iguais ao PC(program counter), ou seja, o menor endereço será **0x50000000** e o maior **0x5FFFFFFF**.

## 64. Qual é o menor e o maior endereço para onde uma instrução "beq", residente no endereço de memória 0x5A18F34C, pode saltar?
Uma instrução ``beq`` é do tipo **I**, por isso o endereço-alvo = PC + (offset << 2). O PC na execução desta instrução seria PC = 0x5A18F34C + 4 = 0x5A18F350. O offset é codificado com 16 bits em complemento para dois, logo:
- Endereço Mínimo = 0x5A18F350 - $2^{15} \times 4$ = 0x5A16F350
- Endereço Máximo = 0x5A18F350 + $(2^{15}-1) \times 4$ = 0x5A1AF34C

## 65. Qual é o menor e o maior endereço para onde uma instrução "jr", residente no endereço de memória 0x5A18F34C pode saltar?
Uma instrução ``jr`` pode saltar para qualquer endereço de 32 bits presente no registo associado à instrução, logo pode saltar entre **0x00000000** e **0xFFFFFFFF**.

## 66. Qual a gama de representação da constante nas instruções aritméticas imediatas (e.g. addi)?
As instruções aritméticas imediatas são do formato **I** por isso usa 16 bits em complemento para dois para representar a constante, logo a gama de representação será entre $[-2^{15}, 2^{15}-1]$ ([-32768, +32767]).

## 67. Qual a gama de representação da constante nas instruções lógicas imediatas (e.g. andi)?
As instruções lógicas imediatas, também são do formato **I**, mas ao contrário das aritméticas imediatas, as lógicas não precisam de lidar com sinal, logo a gama de representação será entre $[0, 2^{16}-1]$ ([0, +65535]).

## 68. Por que razão não existe, no ISA do MIPS, uma instrução nativa que permita manipular diretamente uma constante de 32 bits?
Como as instruções são todas codificadas em 32 bits, não há maneira de manipular diretamente uma constante de 32 bits com apenas 1 instrução, sendo que para além da costante é necessário estar codificado os outros campos da instrução (OpCode, registos, ...).

## 69. Como é que, no assembly do MIPS, se podem manipular constantes de 32 bits?
As constantes de 32 bits são manipuladas através instrução ``lui`` (Load Upper Immediate), que coloca a constante “immediate” nos 16 bits mais significativos do registo destino e de seguida uma instrução ``ori`` com os 16 bits menos significativos da constante de 32 bits.
```asm
lui $6,0xF328       #$6 = 0xF3280000
ori $6,$6,0x64D9    #$6 = 0xF3280000 | 0x000064D9 = 0xF32864D9
```

## 70. Apresente a decomposição em instruções nativas das seguintes instruções virtuais:
### a. li  $6,0x8B47BE0F
```asm
lui $6, 0x8B47       # $6 = 0x8B470000
ori $6, $6, 0xBE0F   # $6 = 0x8B47BE0F
```

### b. xori $3,$4,0x12345678
```asm
lui $1, 0x1234       # $1 = 0x1234
ori $1, $1, 0x5678   # $1 = 0x12345678
xor $3, $4, $1       # $3 = $4 ^ $1
```

### c. addi $5,$2,0xF345AB17
```asm
lui $1, 0xF345       # $1 = 0xF345
ori $1, $1, 0xAB17   # $1 = 0xF345AB17
add $5, $2, $1       # $5 = $2 + $1
```

### d. beq $7,100,L1
```asm
li $1, 100           # $1 = 100
beq $7, $1, L1       # branch if $7 == $1
```

### e. blt $3,0x123456,L2
```asm
lui $1, 0x0012       # $1 = 0x0012
ori $1, $1, 0x3456   # $1 = 0x00123456
slt $2, $3, $1       # $2 = 1 if $3 < $1 else 0
bne $2, $0, L2       # branch if $2 != $0
```

## 71. O que é uma sub-rotina?
Uma sub-rotina é a uma função.

## 72. Qual a instrução do MIPS usada para evocar uma sub-rotina? 
A instrução usada para evocar uma sub-rotina é ``jal``.

## 73. Por que razão não pode ser usada a instrução "j" para evocar uma sub-rotina?
Não pode ser usada a instrução ``j`` pois é necessário guardar o PC no registo $ra para se saber onde retornar ao código depois da execução da sub-rotina.

## 74. Quais as operações que são sequencialmente realizadas na execução de uma instrução de evocação de uma sub-rotina?
- Fase fetch
    - ``IR = MEM[PC]    # IR = código máquina``
    - ``PC = PC + 4``
- Fase execute
    - ``$ra = PC``
    - ``PC = target_address``

## 75. Qual o número e nome virtual do registo associado à execução dessa instrução?
O registo associado à execução da instrução ``jal`` é o **$ra (return address)** e tem o número **$31**.

## 76. No caso de uma sub-rotina ser simultaneamente chamada e chamadora (sub-rotina intermédia) que operações é obrigatório realizar nessa sub-rotina?
No caso de ser uma sub-rotina intermédia, deve-se salvaguardar os registos seguros (**$sn**) que vai utilizar, assim como o valor do **$ra**.

## 77. Qual a instrução usada para retornar de uma sub-rotina?
A instrução usada para retornar de uma sub-rotina é ``jr $ra``.

## 78. Que operação fundamental é realizada na execução dessa instrução?
O PC será alterado para o valor presente no **$ra**.

## 79. O que é uma stack e qual a finalidade do stack pointer?
Uma stack é uma estrutura na memória essencial para a manipulação eficiente de dados temporários na memória e o stack pointer aponta para o topo da stack, conseguindo assim fazer a manipulação da stack.

## 80. Como funcionam as operações de push e pop?
- Push
    - Decrementa o stack pointer (SP) para alocar espaço na stack.
    - Armazena o valor no endereço apontado pelo SP.
```asm
addi $sp, $sp, -4   # Decrementa o SP para alocar espaço
sw $t0, 0($sp)      # Armazena o valor de $t0 na stack
```
- Pop
    - Recupera o valor armazenado no topo da stack (endereço apontado pelo SP).
    - Incrementa o stack pointer (SP) para liberar o espaço.
```asm
lw $t0, 0($sp)      # Recupera o valor do topo da stack
addi $sp, $sp, 4    # Incrementa o SP para liberar espaço
```

## 81. Por que razão as stacks crescem normalmente no sentido dos endereços mais baixos?
A estratégia de crescimento da stack no sentido dos endereços mais baixos permite uma gestão simplificada da fronteira entre os segmentos de dados e de stack.

## 82. Quais as regras para a implementação em software de uma stack no MIPS?
1. O registo $sp (stack pointer) contém o endereço da última posição ocupada da stack.
2. A stack cresce no sentido decrescente dos endereços da memória.
3. A stack está organizada em words de 32 bits.

## 83. Qual o registo usado, no MIPS, como stack pointer?
O registo usado como stack pointer é o **$29 ($sp)**.

## 84.  De acordo com a convenção de utilização de registos no MIPS:  
### a. Que registos são usados para passar parâmetros e para devolver resultados de uma sub-rotina?
Os registos usados para passar parâmetros são $a0 a $a3 e para devolver $v0 e $v1.

### b. Quais os registos que uma sub-rotina pode livremente usar e alterar sem necessidade de prévia salvaguarda?
Os registos $t0 a $t9, $v0 e $v1, e $a0 a $a3 podem ser livremente utilizados e alterados pelas sub-rotinas.

### c. Quais os registos que uma sub-rotina chamadora tem a garantia que a sub-rotina chamada não altera?
Os registos $s0 a $s7 tem a garantia de que a sub-rotina não os irá alterar.

### d. Em que situação devem ser usados registos “$sn”?
Os registos $sn devem ser usados caso haja uma chamada a outra sub-rotina e seja necessário usar os registos após a execução dessa.

### e. Em que situação devem ser usados os restantes registos: $tn, $an e $vn?
Os restantes registos devem ser utilizados para os restantes valores que não necessitam de ficar guardados.

## 85. De acordo com a convenção de utilização de registos do MIPS:
### a. Que registos podem ter de ser copiados para a stack numa sub-rotina intermédia?
Numa sub-rotina intermédia deve ser copiado o registo $ra e podem ser copiados os registos $sn que vão ser usados.

### b. Que registos podem ter de ser copiados para a stack numa sub-rotina terminal?
Num sub-rotina terminal não deve ser necessário copiar registos para a stack.

## 86. Para a função com o protótipo seguinte indique, para cada um dos parâmetros de entrada e para o valor devolvido, qual o registo do MIPS usado para a passagem dos respetivos valores:
```c
char fun(int a, unsigned char b, char *c, int *d);
```
| Parâmetro | Registo |
|:----:|:----:|
| a | $a0 |
| b | $a1 |
| c | $a2 |
| d | $a3 |
| return | $v0 |

## 87. Para uma codificação em complemento para 2, apresente a gama de representação que é possível obter com 3, 4, 5, 8 e 16 bits (indique os valores-limite da representação em binário, hexadecimal e em decimal com sinal e módulo).
- 3 bits
    - [0b100, 0b011]
    - [0x4, 0x3]
    - [-4, 3]
- 4 bits
    - [0b1000, 0b0111]
    - [0x8, 0x7]
    - [-8, 7]
- 5 bits
    - [0b10000, 0b01111]
    - [0x10, 0x0F]
    - [-16, 15]
- 8 bits
    - [0b10000000, 0b01111111]
    - [0x80, 0x7F]
    - [-128, 127]
- 16 bits
    - [0b1000000000000000, 0b0111111111111111]
    - [0x8000, 0x7FFF]
    - [-32768, 32767]

## 88. Traduza para assembly do MIPS a seguinte função “fun1()”, aplicando a convenção de passagem de parâmetros e salvaguarda de registos:
```c
char *fun2(char *, char);
char *fun1(int n, char *a1, char *a2)
{
    int j = 0;
    char *p = a1;

    do
    {
        if((j % 2) == 0)
            fun2(a1++, *a2++);
    } while(++j < n);
    *a1='\0';
    return p;
}
```
```asm
# char *fun1(int n, char *a1, char *a2)
# Register map
# $s0 -> n (int)
# $s1 -> a1 (char *)
# $s2 -> a2 (char *)
# $s3 -> p
# $s4 -> j

fun1:
    addi $sp, $sp, -24          # allocate space in stack
    sw $ra, 0($sp)              # save $ra
    sw $s0, 4($sp)              # save $s0
    sw $s1, 8($sp)              # save $s1
    sw $s2, 12($sp)             # save $s2
    sw $s3, 16($sp)             # save $s3
    sw $s4, 20($sp)             # save $s4

    move $s0, $a0               # $s0 = n
    move $s1, $a1               # $s1 = a1
    move $s2, $a2               # $s2 = a2
    
    li $s4, 0                   # j = 0
    move $s3, $s1               # *p = a1

do:
    rem $t0, $s4, 2             # $t0 = j % 2
    bne $t0, $0, endif          # if((j % 2) == 0)

    move $a0, $s1               # $a0 = a1
    lb $a1, 0($s2)              # $a1 = *a2
    jal fun2                    # fun2(a1, *a2);
    addi $s1, $s1, 1            # a1++
    addi $s2, $s2, 1            # a2++

endif:
    addi $s4, $s4, 1            # ++j
    blt $s4, $s0, do            # while(++j < n);

    sb $0, 0($s1)               # *a1 = '\0'
    move $v0, $s3               # return p

    lw $ra, 0($sp)              # restore $ra
    lw $s0, 4($sp)              # restore $s0
    lw $s1, 8($sp)              # restore $s1
    lw $s2, 12($sp)             # restore $s2
    lw $s3, 16($sp)             # restore $s3
    lw $s4, 20($sp)             # restore $s4
    addi $sp, $sp, 24           # free stack
    jr   $ra                    # end sub-routine
```

## 89. Determine a representação em complemento para 2, com 16 bits, das seguintes quantidades decimais:  
5 = **0000 0000 0000 0101**<br>
-3 = **1111 1111 1111 1101**<br>
-128 = **1111 1111 1000 0000**<br>
-32768 = **1000 0000 0000 0000**<br>
31 = **0000 0000 0001 1111**<br>
-8 = **1111 1111 1111 1000**<br>
256 = **0000 0001 0000 0000**<br>
-32 = **1111 1111 1110 0000**

## 90. Determine o valor em decimal representado por cada uma das quantidades seguintes, supondo que estão codificadas em complemento para 2 com 8 bits:  
0b00101011 = **53**<br>
0xA5 = - (0b01011010 + 1) = - 0b01011011 = **-91**<br>
0b10101101 = - (0b01010010 + 1) = - 0b01010011 = **-83**<br>
0x6B = 0b01101011 = **107**<br>
0xFA = - (0b00000101 + 1) = - 0b00000110 = **-6**<br>
0x80 = - (0b01111111 + 1) = - 0b10000000 = **-128**

## 91. Determine a representação das quantidades do exercício anterior em hexadecimal com 16 bits (também codificadas em complemento para 2).
0b00101011 = **0x002B**<br>
0xA5 = **0xFFA5**<br>
0b10101101 = **0xFFAD**<br>
0x6B = **0x006B**<br>
0xFA = **0xFFFA**<br>
0x80 = **0xFF80**

## 92. Como é realizada a deteção de overflow em operações de adição com quantidades sem sinal?
Em operações de adição com quantidades sem sinal, é detetado um overflow se o bit carry for igual a 1.

## 93. Como é realizada a deteção de overflow em operações de adição com quantidades com sinal (codificadas em complemento para 2)?
- Ocorre overflow quando é ultrapassada a gama de representação. Isso acontece quando:
    - se somam dois positivos e o resultado obtido é negativo.
    - se somam dois negativos e o resultado obtido é positivo.

A situação de overflow ocorre quando o carry-in do bit mais significativo não é igual ao carry-out.

## 94. Considere os seguintes pares de valores em $s0 e $s1:<br>i.  $s0 = 0x70000000 $s1 = 0x0FFFFFFF<br>ii. $s0 = 0x40000000 $s1 = 0x40000000
### a. Qual o resultado produzido pela instrução add $t0, $s0, $s1?
- **i.**
    - $t0 = 0x70000000 + 0x0FFFFFFF = 0x7FFFFFFF
- **ii.**
    - $t0 = 0x40000000 + 0x40000000 = 0x80000000

### b. Para a alínea anterior os resultados são os esperados ou ocorreu overflow?
- **i.**
    - Não ocorreu overflow, a soma de 2 positivos deu um número positivo.
- **ii.**
    - Ocorreu overflow, a soma de 2 positivos deu um número negativo.

### c. Qual o resultado produzido pela instrução sub $t0, $s0, $s1?
**i.**
```
$t0 = 0x70000000 + (-0x0FFFFFFF) = 0x60000001
   1111 ... -> carry
    0111 0000 ... 0000 0000 -> MSB carry-in = 1
   +1111 0000 ... 0000 0001
  1 0110 0000 ... 0000 0001 -> carry-out = 1
```
**ii.**
```
$t0 = 0x40000000 + (-0x40000000) = 0x00000000
   1100 ... -> carry
    0100 0000 ... 0000 0000 -> MSB carry-in = 1
   +1100 0000 ... 0000 0000
  1 0000 0000 ... 0000 0000 -> carry-out = 1
```
### d. Para a alínea anterior os resultados são os esperados ou ocorreu overflow?
Em ambos os casos não ocorreu overflow, **carry-in == carry-out**.

### e. Qual o resultado produzido pelas instruções:
```asm
add $t0, $s0,$s1
add $t0, $t0,$s1
```
**i.**
```asm
add $t0, $s0,$s1
$t0 = 0x70000000 + 0x0FFFFFFF = 0x7FFFFFFF
   0000 ... -> carry
    0111 0000 ... 0000 0000 -> carry-in = 0
   +0000 1111 ... 1111 1111
  0 0111 1111 ... 1111 1111 -> carry-out = 0

add $t0, $t0,$s1
$t0 = 0x7FFFFFFF + 0x0FFFFFFF = 0x8FFFFFFE
   0111 ...
    0111 1111 ... 1111 1111 -> MSB carry-in = 1
   +0000 1111 ... 1111 1111
  0 1000 0000 ... 0000 0000 -> carry-out = 0

```
**ii.**
```asm
add $t0, $s0,$s1
$t0 = 0x40000000 + 0x40000000 = 0x80000000
   0100 ... -> carry
    0100 0000 ... 0000 0000 -> carry-in = 1
   +0100 0000 ... 0000 0000
  0 1000 0000 ... 0000 0000 -> carry-out = 0

add $t0, $t0,$s1
$t0 = 0x80000000 + 0x40000000 = 0xC0000000
   0000 ... -> carry
    1000 0000 ... 0000 0000 -> carry-in = 0
    0100 0000 ... 0000 0000
  0 1100 0000 ... 0000 0000 -> carry-out = 0
```

### f. Para a alínea anterior os resultados são os esperados ou ocorreu overflow?
No caso dos pares de valores **i**, houve overflow na segunda instrução, no **ii** houve overflow na primeira instrução.

## 95. Para a multiplicação de dois operandos de "m" e "n" bits, respetivamente, qual o número de bits necessário para o armazenamento do resultado qualquer que este seja?
Para o armazenamento do resultado seria necessários **m + n bits**.

## 96. Apresente a decomposição em instruções nativas das seguintes instruções virtuais:
### a. mul $5,$6,$7
```asm
mult $6, $7
mflo $5
```

### b. la $t0,label  c/ label = 0x00400058
```asm
lui $1, 0x0040
ori $t0, $1, 0x0058
```

### c. div $2,$1,$2
```asm
div $1, $2  # hi = $1 % $2
            # lo = $1 / $2
mflo $2
```

### d. rem $5,$6,$7
```asm
div $6, $7  # hi = $6 % $7
            # lo = $6 / $7
mfhi $5
```

### e. ble $8,0x16,target
```asm
addi $1, $0, 0x16
slt $1, $1, $8
beq $1, $0, target
```

### f. bgt $4,0x3F,target
```asm
addi $1, $0, 0x3F
slt $1, $1, $4
bne $1, $0, target
```

## 97. Determine o resultado da instrução mul $5,$6,$7, quando $6=0xFFFFFFFE e $7=0x00000005.
```
0xFFFFFFFE * 0x00000005 = -2 * 5 = -10
hi = 0xFFFFFFFF
lo = 0xFFFFFFF6
```
## 98. Determine o resultado da execução das instruções virtuais div $5,$6,$7 e rem $5,$6,$7 quando $6=0xFFFFFFF0 e $7=0x00000003.
```
0xFFFFFFF0 / 0x00000003 = -16 / 3 = -5 (rem = -1)
hi = 0xFFFFFFFF # rem $5,$6,$7
lo = 0xFFFFFFFB # div $5,$6,$7
```

## 99. Admita que pretendemos executar, em Assembly do MIPS, as operações: <br>``$t0 = $t2/$t3`` e ``$t1 = $t2 % $t3``. <br>Escreva a sequência de instruções em Assembly que permitem realizar estas duas operações. Use apenas instruções nativas.
```asm
div $t2, $t3
mfhi $t1    # $t1 = $t2 % $t3
mflo $t0    # $t0 = $t2 / $t3
```

## 100. Descreva as regras que são usadas, na ALU do MIPS, para realizar uma divisão inteira entre duas quantidades com sinal.
**Nas divisões com sinal aplicam-se as seguintes regras:**
- Divide-se dividendo por divisor, em módulo
- O quociente tem sinal negativo se os sinais do dividendo e do divisor forem diferentes
- O resto tem o mesmo sinal do dividendo
