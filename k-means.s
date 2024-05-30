
#
# IAC 2023/2024 k-means
# 
# Grupo: 1
# Campus: Alameda
#
# Autores:
# 110263, Beatriz Teixeira
# 109974, Mariana Carvalho
# 109643, Tiago Mateus
#
# Tecnico/ULisboa


# ALGUMA INFORMACAO ADICIONAL PARA CADA GRUPO:
# - A "LED matrix" deve ter um tamanho de 32 x 32
# - O input e' definido na seccao .data. 
# - Abaixo propomos alguns inputs possiveis. Para usar um dos inputs propostos, basta descomentar 
#   esse e comentar os restantes.
# - Encorajamos cada grupo a inventar e experimentar outros inputs.
# - Os vetores points e centroids estao na forma x0, y0, x1, y1, ...

#ifndef RIPES_IO_HEADER
#define RIPES_IO_HEADER
# *****************************************************************************
# * LED_MATRIX_0
# *****************************************************************************
#define LED_MATRIX_0_BASE	(0xf0000000)
#define LED_MATRIX_0_SIZE	(0x1000)
#define LED_MATRIX_0_WIDTH	(0x20)
#define LED_MATRIX_0_HEIGHT	(0x20)

#endif // RIPES_IO_HEADER

#-------------------------------INFORMACOES DE UTILIZACAO-----------------------------------
#Este Codigo Possui direitos de autores reservado as pessoas em cima referidas

#Intrucoes:
    #Cada vetor de pontos (points) deve conter o seu respetivo numero de pontos (n_points)
    #E o respetivo vetor de indices (id_points)

# Variaveis em memoria
.data

#Input A - linha inclinada
#n_points:    .word 9
#id_points:   .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#points:      .word 0,0, 1,1, 2,2, 3,3, 4,4, 5,5, 6,6, 7,7 8,8

#Input B - Cruz
#n_points:    .word 5
#id_points:   .word 0, 0, 0, 0, 0
#points:     .word 4,2, 5,1, 5,2, 5,3 6,2

#Input C
#n_points:    .word 23
#id_points:   .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#points: .word 0,0, 0,1, 0,2, 1,0, 1,1, 1,2, 1,3, 2,0, 2,1, 5,3, 6,2, 6,3, 6,4, 7,2, 7,3, 6,8, 6,9, 7,8, 8,7, 8,8, 8,9, 9,7, 9,8

#Input D
n_points:    .word 30
id_points:   .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
points:      .word 16, 1, 17, 2, 18, 6, 20, 3, 21, 1, 17, 4, 21, 7, 16, 4, 21, 6, 19, 6, 4, 24, 6, 24, 8, 23, 6, 26, 6, 26, 6, 23, 8, 25, 7, 26, 7, 20, 4, 21, 4, 10, 2, 10, 3, 11, 2, 12, 4, 13, 4, 9, 4, 9, 3, 8, 0, 10, 4, 10



# Valores de centroids e k a usar na 1a parte do projeto:
#centroids:   .word 0,0
#k:           .word 1

# Valores de centroids, k e L a usar na 2a parte do prejeto:
centroids:   .word 0,0, 0,0 , 0,0
k:           .word 3
L:           .word 10

# Abaixo devem ser declarados o vetor clusters (2a parte) e outras estruturas de dados
# que o grupo considere necessarias para a solucao:
#clusters:    


# Strings para o output

Primeiro:        .string "A resetar o numero de centroids...\n"
Segundo:        .string "A limpar o ecra...\n"
Terceiro:        .string "A preencher os pontos dos clusters...\n"
Quarto:        .string "A calcular o centroid...\n"
Quinto:        .string "A preencher o ponto correspondente ao centroid...\n"
Final:        .string "Terminar a execucao 0"

# Definicoes de RNG
seed: .word 0    #Seed Definido pelo Clock low 32bits
mult: .word 295409844
.equ C 1         #Incrementecao de 1
.equ mod 31      #Modulo para os 32 tamanho led



# Definicoes de cores a usar no projeto 
colors:      .word 0xf3a0ad, 0x6d8777 , 0xb28dff  # Cores dos pontos do cluster 0, 1, 2, etc.

.equ        black         0
.equ        white         0xffffff
.equ        red           0xff0000
.equ        green         0x00ff00
.equ        blue          0x0000ff
.equ        lightpurple   0xeceae4
.equ        purple        0xb28dff


# Codigo
 
.text
    # Chama funcao principal da 1a parte do projeto
    #jal mainSingleCluster

    # Descomentar na 2a parte do projeto:
    #jal DynamicMemoryAllocation_forPoints
    jal mainKMeans
    
    # Termina o programa (chamando chamada sistema)
    #la a0, Final
    #li a7, 4
    #ecall
    li a7, 10
    ecall


### printPoint
# Pinta o ponto (x,y) na LED matrix com a cor passada por argumento
# Nota: a implementacao desta funcao ja' e' fornecida pelos docentes
# E' uma funcao auxiliar que deve ser chamada pelas funcoes seguintes que pintam a LED matrix.
# Argumentos:
# a0: x
# a1: y
# a2: cor

printPoint:
    li a3, LED_MATRIX_0_HEIGHT
    sub a1, a3, a1
    addi a1, a1, -1
    li a3, LED_MATRIX_0_WIDTH
    mul a3, a3, a1
    add a3, a3, a0
    slli a3, a3, 2
    la a0, LED_MATRIX_0_BASE
    add a3, a3, a0   
    sw a2, 0(a3)
    jr ra
    

### cleanScreen
# Limpa todos os pontos do ecra
# Argumentos: nenhum
# Retorno: nenhum

cleanScreen:
    li a0, LED_MATRIX_0_HEIGHT   ##Vai buscar as dimensoes do ecra
    li a1, LED_MATRIX_0_WIDTH    
    mul a2, a0, a1               #Organiza as dimensoes do ecra num u'nico vetor de 4 bits
    la a3, LED_MATRIX_0_BASE     #Carrega o vetor que se ve no ecra
    la a4, LED_MATRIX_0_BASE     #Carrega o segundo vetor que se ve no ecra
    
    #Obtem o vetor que comeca no fim do ecra
    slli a2, a2, 2
    add a4, a4, a2
    li a5, lightpurple             #Define a cor
    
cleanloop:
    bgt a3, a4, endcleanloop       #Se ambos os vetores se encontram, a funcao acaba
    sw a5, 0(a3)                   #Muda a cor no inicio
    sw a5, 4(a3)
    sw a5, 8(a3)
    sw a5, 12(a3)
    
    sw a5, 0(a4)                   #Muda a cor no fim
    sw a5, -4(a4)
    sw a5, -8(a4)
    sw a5, -12(a4)
    
    addi a3, a3, 16                #Vai para o proximo
    addi a4, a4, -16               #Vai para o proximo
    j cleanloop                    #Reinicia o loop
    
endcleanloop:
    jr ra                          #Retorna ao ponto de chamada

    
    
    
### printClusters
# Pinta os agrupamentos na LED matrix com a cor correspondente.
# Argumentos: nenhum
# Retorno: nenhum

printClusters:
    # POR IMPLEMENTAR (1a e 2a parte)
    lw t1, n_points       #Da load ao numero de pontos
    la a5, id_points      #Carrega o vetor de indices dos pontos
    la a4, points
    addi sp, sp, -12       #Guarda memoria na stack
    sw ra, 0(sp)          #Guarda o endereco de retorno e vai para printLoop
  
### printLoop_Points
# Printa pontos num vetor
# Argumentos: nenhum
# Retorno: nenhum
printLoop_Points:
    beqz t1, end_Points    #Condicao de finalizacao
    sw t1, 8(sp)
    
    lw a0, 0(a4)           #Da load ao ponto X
    lw a1, 4(a4)           #Da load ao ponto Y
    sw a0, 4(sp)           #Guarda o valor de X
    
    jal ra, nearestCluster
    sw a0, 0(a5)
    la t3, colors

ciclo_cores:
    blez a0, 16
    addi t3, t3, 4
    addi a0, a0, -1
    j ciclo_cores
    
    lw a2, 0(t3)
    lw a0, 4(sp)
    jal ra, printPoint     #Chama a funcao printPoint
    
    addi a4, a4, 8         #Vai para o proximo ponto
    lw t1, 8(sp)
    addi a5, a5, 4
    addi t1, t1, -1        #Contador do loop
    j printLoop_Points     #Vai para a funcao printLoop
end_Points:
    lw ra, 0(sp)           #Da load ao endereco de retorno
    addi sp, sp, 12         #Liberta espaco na stack     
    jr ra                  #Retorna para o ponto de chamada






### printCentroids
# Pinta os centroides na LED matrix
# Nota: deve ser usada a cor preta (black) para todos os centroides
# Argumentos: nenhum
# Retorno: nenhum
printCentroids:
    la t0, centroids       #Da load ao vetor de centroids
    lw t1, k               #Da load ao numero de centroids
    li a2, black           #Da load a' cor do centroid
    addi sp, sp, -4        #Guarda espaco na stack
    sw ra, 0(sp)           #Guarda o endereco de retorno
    j printLoop            #Comeca o loop

### printLoop
# Printa pontos num vetor
# Argumentos: nenhum
# Retorno: nenhum
printLoop:
    beqz t1, end           #Condicao de finalizacao
    lw a0, 0(t0)           #Da load ao ponto X
    lw a1, 4(t0)           #Da load ao ponto Y
    jal ra, printPoint     #Chama a funcao printPoint
    addi t0, t0, 8         #Vai para o proximo ponto
    addi t1, t1, -1        #Contador do loop
    j printLoop            #Vai para a funcao printLoop
end:
    lw ra, 0(sp)           #Da load ao endereco de retorno
    addi sp, sp, 4         #Liberta espaco na stack     
    jr ra                  #Retorna para o ponto de chamada

### calculateCentroids
# Calcula os k centroides, a partir da distribuicao atual de pontos associados a cada agrupamento (cluster)
# Argumentos: nenhum
# Retorno: nenhum

calculateCentroids:
    addi sp, sp, -8        #Guarda espaco na stack para os argumentos
    sw ra, 0(sp)           #Guarda o endereco de retorno
    la t0, centroids       #Da load ao vetor dos centroids
    lw t2, n_points        #Da load ao numero de pontos
    li a2, 0
    
    
    la t1, points          #Da load ao vetor que contem os pontos
    la s1, id_points
    #Colocar as variaveis a zero
    addi t3, zero, 0
    addi t4, zero, 0
    
    sw t2, 4(sp)           #Guarda espaco para uma variavel temporaria
    jal ra, loop_points    #Calcula a soma dos ponts com a funcao loop_points

    lw t2, 4(sp)           #Da load a variavel temporaria
    div a0, t3, t2         #Calcula a coordenada X do centroid
    div a1, t4, t2         #Calcula a coordenada Y do centroid
    
    addi a2, a2, 1
    
    lw ra, 0(sp)           #Da load ao endereco de retorno
    sw a0, 0(t0)           #Guarda o ponto X do centroid no vetor
    sw a1, 4(t0)           #Guarda o ponto Y do centroid no vetor
    addi sp, sp, 8         #Liberta espaco na stack
    jr ra                  #Retorna para o ponto de chamada

loop_points:
    bne a2, a3, skip
    lw t5, 0(t1)           #Da load ao valor X
    lw t6, 4(t1)           #Da load ao valor Y
    
    addi, t2, t2, -1       #Counter os Number os Points
    add t3, t3, t5         #Adiciona o valor x a media
    add t4, t4, t6         #Adiciona o valor x a media
skip:
    blez t2, end_loop_points    #Verifica se o loop tem de acabar
    addi t1, t1 8          #Vai para o proximo ponto
    j loop_points          #Reinicia o loop
    
end_loop_points:
    jr ra                  #Retorna para o ponto de chamada

### mainSingleCluster
# Funcao principal da 1a parte do projeto.
# Argumentos: nenhum
# Retorno: nenhum

#----------------------------------------------------------------------------------------
mainSingleCluster:                  #~~MAIN~~
    #1. Coloca k=1 (caso nao esteja a 1)
    # POR IMPLEMENTAR (1a parte)
    addi sp, sp, -4
    sw ra, 0(sp)
    
    la a0, Primeiro
    li a7, 4
    ecall
    
    la t0, k
    addi t1, zero, 1
    sw t1, 0(t0)
    
    #2. cleanScreen
    la a0, Segundo
    li a7, 4
    ecall
    
    jal ra, cleanScreen

    #3. printClusters
    la a0, Terceiro
    li a7, 4
    ecall
    
    #jal ra, printClusters

    #4. calculateCentroids
    la a0, Quarto
    li a7, 4
    ecall
    
    #jal ra, calculateCentroids
    
    #5. printCentroids
    la a0, Quinto
    li a7, 4
    ecall
    
    #jal ra, printCentroids

    #6. Termina
    la a0, Final
    li a7, 4
    ecall
    
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra
#------------------------------------------------------------------------------------------
#DynamicMemoryAllocation_forPoints
#Gera um vetor para guardar os pontos e os indice
#Argumentos: Nenhum
#Retorno: s10 - Inicio do endereço vetor, s11 - endereço variável do vetor
DynamicMemoryAllocation_forPoints:
    lw t0, n_points
    li t1, 3
    mul t0, t0, t1
    slli t0, t0, 2
    sub s10, sp, t0
    add s11, zero, s10
    sub sp, sp, t0
    jr ra
    
#RandomNumberGenerator
#Gera a Seed
#Argumentos: Nenhum
#Retorno: a0, x e a1, y

RandomNumberGenerator:
    li a0, 0
    li a7, 30
    ecall            #Carrega o atual Clock low 32bits
    la t0, seed   
    sw a0, 0(t0)     #Guarda o clock como seed
    jr ra

initializeCentroids:
    addi sp, sp, -4    #Aloca memoria no stack
    sw ra, 0(sp)       #Guarda o retorno ra no stack
    
    jal RandomNumberGenerator    #Gera um seed
    la t0, centroids   #Carrega o vetor dos centroids
    lw t1, k           #Carrega o numero de centroids
    slli t1, t1, 1     #Multiplica por 2 (gera primeiro um x e no segundo ciclo um y)
    la t6, seed        #carrega o endereço do seed do RNG
    li t5, mod         #Carrega o modulo (31 atual, evita repeticoes de valores)

centroidGenerateCicle:
    blez t1, fim_ciclo_gerador    #Condicao de termino (quando gerar o x e y valores n vezes)
    lw t2, 0(t6)       #Carrega a seed
    lw t3, mult        #Carrega o multiplicador
    
    mul t2, t2, t3     #Multiplica a seed pelo multiplicador
    sw t2, 0(t6)       #Guarda a nova seed
    
    addi t2, t2, 7     #Incrementa 7 (numero primo, evita repeticoes)
    
    remu t2, t2, t5    #Calcula o valor de 0 a 32
    
    
    sw t2, 0(t0)       #Guarda o valor
    addi t0, t0, 4     #Incrementa o proximo espaço
    addi t1, t1, -1    #Decrementa o contador
    j centroidGenerateCicle #Repete o ciclo para x e depois y até todos os pontos
     
fim_ciclo_gerador:
    lw ra, 0(sp)       #Carrega endereço de retorno
    addi sp, sp, 4     #Liberta memoria
    jr ra              #Retorna a funcao 
    

### manhattanDistance
# Calcula a distancia de Manhattan entre (x0,y0) e (x1,y1)
# Argumentos:
# a0, a1: x0, y0
# a2, a3: x1, y1
# Retorno:
# a0: distance

manhattanDistance:
    # POR IMPLEMENTAR (2a parte)
    addi sp, sp, -4
    sw ra, 0(sp)
    sub t0, a0, a2            #Calcular a diferenca entre os xs
    sub t1, a1, a3            #Calcular a diferenca entre os ys
    li t2, -1                 #Fazer load de um imediato para mais tarde calcular o modulo
    
    bgtz t0, skip_module_x    #Caso o modulo dos xs seja positivo nao e' necessario calcular o modulo
    mul t0, t0, t2            #Caso o modulo dos xs seja negativo calcula-se o modulo com o imediato em t2
skip_module_x: 
    bgtz t1, skip_module_y    #Caso o modulo dos ys seja positivo nao e' necessario calcular o modulo
    mul t1, t1, t2            #Caso o modulo dos xs seja negativo calcula-se o modulo com o imediato em t2
skip_module_y:
    add a0, t0, t1            #Fazer a conta final (modulo da diferenca dos xs mais modulo da diferenca dos ys)
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra


### nearestCluster
# Determina o centroide mais perto de um dado ponto (x,y).
# Argumentos:
# a0, a1: (x, y) point
# Retorno:
# a0: cluster index

nearestCluster:
    # POR IMPLEMENTAR (2a parte)
    addi sp, sp, -8                 #0: ra, -4: a0 para x, 
    sw ra, 0(sp)
    lw a6, k                        #Dar load ao numero de centroids
    la a7, centroids                #Dar load ao vetor de centroids
    li s3, 0                        #Inicializar a variavel onde vai estar o centroid final
    li s2, -1                       #Inicia o indice dos centroids
    li t3, 0                        #Variavel para iteracoes
    sw a0, 4(sp)                    #Guarda o retorno
    
ciclo:
    beqz a6, fim                    #Se chegar ao fim do vetor dos centroids vai para o final da funcao
    lw a2, 0(a7)                    #Colocar o x do centroid no registo correspondente
    lw a3, 4(a7)                    #Colocar o y do centroid no registo correspondente
    addi a7, a7, 8                  #Passar para o proximo ponto
    
    jal manhattanDistance           #Calcular a distancia entre o ponto dado e o centroid
    
    addi a6, a6, -1                 #Diminuir o valor de k para sinalizar que ja se analisou 1 centroid
    beqz t3, primeira_iteracao      #Se for a primeira iteracao, vai guardar os valores independentemente de se e' a distancia menor ou nao
    bgtu a0, s1, skip_alterar       #Nas proximas, apenas altera as informacoes se a distancia calculada for menos que a anterior
    
    mv s1, a0                       #Guarda o valor da distancia
    addi s2, s2, 1                  #Aumenta o contador do indice dos clusters
    mv s3, s2                       #Indica que o indice do cluster correspondente
    lw a0, 4(sp)                    #Carrega o x do ponto
    j ciclo
    
skip_alterar:
    lw a0, 4(sp)                    #Carrega o x do ponto
    addi s2, s2, 1                  #Aumenta o contador do indice dos clusters
    j ciclo
    
primeira_iteracao:
    mv s1, a0                       #O t1 vai guardar a distancia entre os pontos do centroid anterior
    lw a0, 4(sp)                    #Carrega o x do ponto
    addi t3, t3, 1                  #Coloca o "nao e primeira" como verdade
    addi s2, s2, 1                  #Aumenta o contador do indice dos clusters
    j ciclo                         #Proxima iteracao do ciclo
    
fim:
    mv a0, s3                       #Coloca o indice do cluster no a0
    lw ra, 0(sp)
    addi sp, sp, 8
    jr ra


### mainKMeans
# Executa o algoritmo *k-means*.
# Argumentos: nenhum
# Retorno: nenhum
#--------------------------------------------------------------------------------------------
mainKMeans:  
    # POR IMPLEMENTAR (2a parte)
    
    addi sp, sp, -4
    sw ra, 0(sp)
    
    jal cleanScreen
    
    jal initializeCentroids
    
    bgtz s11, end_Iteration
    jal printCentroids
    
    jal printClusters
    
end_Iteration:
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra
    
    #1245367256789245789645q79645q7694579865q47896q435896754q37896q34589764q355q427895q42789
