
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

# Variaveis em memoria
.data

#Input A - linha inclinada
#n_points:    .word 9
#points:      .word 0,0, 1,1, 2,2, 3,3, 4,4, 5,5, 6,6, 7,7 8,8

#Input B - Cruz
#n_points:    .word 5
#points:     .word 4,2, 5,1, 5,2, 5,3 6,2

#Input C
#n_points:    .word 23
#points: .word 0,0, 0,1, 0,2, 1,0, 1,1, 1,2, 1,3, 2,0, 2,1, 5,3, 6,2, 6,3, 6,4, 7,2, 7,3, 6,8, 6,9, 7,8, 8,7, 8,8, 8,9, 9,7, 9,8

#Input D
n_points:    .word 30
points:      .word 16, 1, 17, 2, 18, 6, 20, 3, 21, 1, 17, 4, 21, 7, 16, 4, 21, 6, 19, 6, 4, 24, 6, 24, 8, 23, 6, 26, 6, 26, 6, 23, 8, 25, 7, 26, 7, 20, 4, 21, 4, 10, 2, 10, 3, 11, 2, 12, 4, 13, 4, 9, 4, 9, 3, 8, 0, 10, 4, 10



# Valores de centroids e k a usar na 1a parte do projeto:
centroids:   .word 0,0
k:           .word 1

# Valores de centroids, k e L a usar na 2a parte do prejeto:
#centroids:   .word 0,0, 10,0, 0,10
#k:           .word 3
#L:           .word 10

# Abaixo devem ser declarados o vetor clusters (2a parte) e outras estruturas de dados
# que o grupo considere necessarias para a solucao:
#clusters:    


# Strings para o output

Primeiro:        .string "A resetar o número de centroids...\n"
Segundo:        .string "A limpar o ecrã...\n"
Terceiro:        .string "A preencher os pontos dos clusters...\n"
Quarto:        .string "A calcular o centroid...\n"
Quinto:        .string "A preencher o ponto correspondente ao centroid...\n"


# Definicoes de cores a usar no projeto 

colors:      .word 0xff0000, 0x00ff00, 0x0000ff  # Cores dos pontos do cluster 0, 1, 2, etc.

.equ        black         0
.equ        white         0xffffff
.equ        red           0xff0000
.equ        green         0x00ff00
.equ        blue          0x0000ff


# Codigo
 
.text
    # Chama funcao principal da 1a parte do projeto
    jal mainSingleCluster

    # Descomentar na 2a parte do projeto:
    #jal mainKMeans
    
    # Termina o programa (chamando chamada sistema)
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
<<<<<<< HEAD
# Limpa todos os pontos do ecra
=======
# Limpa todos os pontos do ecrï¿½
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
# Argumentos: nenhum
# Retorno: nenhum

cleanScreen:
    li a0, LED_MATRIX_0_HEIGHT   ##Vai buscar as dimensoes do ecra
    li a1, LED_MATRIX_0_WIDTH    
    mul a2, a0, a1               #Organiza as dimensoes do ecra num u'nico vetor de 4 bits
    la a3, LED_MATRIX_0_BASE     #Carrega o vetor que se ve no ecra
    la a4, LED_MATRIX_0_BASE     #Carrega o segundo vetor que se ve no ecra
    
<<<<<<< HEAD
    #Obtem o vetor que comeca no fim do ecra
=======
    #Gets the second display vector to the other end
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
    addi t0, zero, 4
    mul t0, t0, a2
    add a4, a4, t0
    li a5, white                 #Define a cor
    
cleanloop:
<<<<<<< HEAD
    bgt a3, a4, endcleanloop       #Se ambos os vetores se encontram, a funcao acaba
    sw a5, 0(a3)                   #Muda a cor no inicio
=======
    bgt a3, a4, endcleanloop      #If both vectors pointers meet, ends loop
    sw a5, 0(a3)                  #Changes Colour in the begining
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
    sw a5, 4(a3)
    sw a5, 8(a3)
    sw a5, 12(a3)
    
<<<<<<< HEAD
    sw a5, 0(a4)                   #Muda a cor no fim
=======
    sw a5, 0(a4)                  #Changes Colour in the end
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
    sw a5, -4(a4)
    sw a5, -8(a4)
    sw a5, -12(a4)
    
<<<<<<< HEAD
    addi a3, a3, 16                #Vai para o proximo
    addi a4, a4, -16               #Vai para o proximo
    j cleanloop                    #Reinicia o loop
=======
    addi a3, a3, 16                #Jumps to next
    addi a4, a4, -16                #Jumps to next
    j cleanloop                   #Returns to loop
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
    
endcleanloop:
    jr ra                          #Retorna ao ponto de chamada

    
### printClusters
# Pinta os agrupamentos na LED matrix com a cor correspondente.
# Argumentos: nenhum
# Retorno: nenhum

printClusters:
    # POR IMPLEMENTAR (1a e 2a parte)
<<<<<<< HEAD
    la t0, points         #Da load ao vetor dos pontos
    lw t1, n_points       #Da load ao numero de pontos
    li a2, red            #Da load a' cor
    addi sp, sp, -4       #Guarda memoria na stack
    sw ra, 0(sp)          #Guarda o endereco de retorno e vai para printLoop
=======
    la t0, points         #Loads Cluster Points Vector
    lw t1, n_points       #Loads Number of Points
    li a2, red            #Loads Colour
    addi sp, sp, -4       #Allocates Memory in Stack
    sw ra, 0(sp)          #Saves Return Address and goes to PrintLoop
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
  
### printLoop
# Printa pontos num vetor
# Argumentos: nenhum
# Retorno: nenhum
printLoop:
<<<<<<< HEAD
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
=======
    beqz t1, end           #End Condition
    lw a0, 0(t0)           #Loads X Point
    lw a1, 4(t0)           #Loads Y Point
    jal ra, printPoint     #Calls PrintPoint Function
    addi t0, t0, 8         #Jumps to next point
    addi t1, t1, -1        #Loop Counter
    j printLoop            #Goes to Print Loop
    
end:
    lw ra, 0(sp)           #Loads Return Adress
    addi sp, sp, 4         #Free Stack Memory       
    jr ra                  #Returns to where function was called
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9

### printCentroids
# Pinta os centroides na LED matrix
# Nota: deve ser usada a cor preta (black) para todos os centroides
# Argumentos: nenhum
# Retorno: nenhum
printCentroids:
<<<<<<< HEAD
    la t0, centroids       #Da load ao vetor de centroids
    lw t1, k               #Da load ao numero de centroids
    li a2, black           #Da load a' cor do centroid
    addi sp, sp, -4        #Guarda espaco na stack
    sw ra, 0(sp)           #Guarda o endereco de retorno
    j printLoop            #Comeca o loop
=======
    # POR IMPLEMENTAR (1a e 2a parte)
    la t0, centroids       #Loads Centroid Vectors
    lw t1, k               #Loads Number of Centroids
    li a2, black           #Loads Colour of Centroid
    addi sp, sp, -4        #Allocate Space in stack
    sw ra, 0(sp)           #Saves Adress
    j printLoop            #Starts Loop
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
    

### calculateCentroids
# Calcula os k centroides, a partir da distribuicao atual de pontos associados a cada agrupamento (cluster)
# Argumentos: nenhum
# Retorno: nenhum

calculateCentroids:
<<<<<<< HEAD
    addi sp, sp, -8        #Guarda espaco na stack para os argumentos
    la t0, centroids       #Da load ao vetor dos centroids
    la t1, points          #Da load ao vetor que contem os pontos
    lw t2, n_points        #Da load ao numero de pontos
    
    #Colocar as variaveis a zero
    addi t3, zero, 0
    addi t4, zero, 0
    
    sw ra, 0(sp)           #Guarda o endereco de retorno
    sw t2, 4(sp)           #Guarda espaco para uma variavel temporaria
    jal ra, loop_points    #Calcula a soma dos ponts com a funcao loop_points

    lw t2, 4(sp)           #Da load a' variável temporaria
    div a0, t3, t2         #Calcula a coordenada X do centroid
    div a1, t4, t2         #Calcula a coordenada Y do centroid
    
    lw ra, 0(sp)           #Dá load ao endereco de retorno
    sw a0, 0(t0)           #Guarda o ponto X do centroid no vetor
    sw a1, 4(t0)           #Guarda o ponto Y do centroid no vetor
    addi sp, sp, 8         #Liberta espaco na stack
    jr ra                  #Retorna para o ponto de chamada

loop_points:
    lw t5, 0(t1)           #Da load ao valor X
    lw t6, 4(t1)           #Da load ao valor Y
    
    addi, t2, t2, -1       #Counter os Number os Points
    add t3, t3, t5         #Adiciona o valor x a' media
    add t4, t4, t6         #Adiciona o valor x a' media
    blez t2, end_loop_points    #Verifica se o loop tem de acabar
    addi t1, t1 8          #Vai para o proximo ponto
    j loop_points          #Reinicia o loop
    
end_loop_points:
    jr ra                  #Retorna para o ponto de chamada
=======
    # POR IMPLEMENTAR (1a e 2a parte)
    addi sp, sp, -8        #Allocate Space in Stack to save Arguments
    la t0, centroids       #Loads centroids Vector
    la t1, points          #Loads Points In vector
    lw t2, n_points        #Loads Number of Points
    
    #Set variables to zero
    addi t3, zero, 0
    addi t4, zero, 0
    
    sw ra, 0(sp)           #Saves return adress
    sw t2, 4(sp)           #Saves Temporary Variable
    jal ra, loop_points    #Calculate Sum of Points calling Loop_Points function

    lw t2, 4(sp)           #Loads The Temporary Varible Stored Before
    div a0, t3, t2         #Calculates X Centroid
    div a1, t4, t2         #Calculates Y Centroid
    
    lw ra, 0(sp)           #Loads Return Adress
    sw a0, 0(t0)           #Saves Centroid X in vector
    sw a1, 4(t0)           #Saves Centroid Y in vector
    addi sp, sp, 8         #Frees Space in Stack 
    jr ra                  #Return to where it was called
    

loop_points:
    lw t5, 0(t1)           #Loads Current X point
    lw t6, 4(t1)           #Loads Current Y point
    
    addi, t2, t2, -1       #Counter os Number os Points
    add t3, t3, t5         #Adds X point to average X
    add t4, t4, t6         #Adds Y point to average Y
    blez t2, end_loop_points    #Checks Loop Endding Condition
    addi t1, t1 8          #Jumps to next Point
    j loop_points          #Continues Loop
    
end_loop_points:
    jr ra                  #Return to where function was called
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9

### mainSingleCluster
# Funcao principal da 1a parte do projeto.
# Argumentos: nenhum
# Retorno: nenhum

#----------------------------------------------------------------------------------------
mainSingleCluster:                  #~~MAIN~~
    #1. Coloca k=1 (caso nao esteja a 1)
    # POR IMPLEMENTAR (1a parte)
<<<<<<< HEAD
    la a0, Primeiro
    li a7, 4
    ecall
    
=======
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
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
    
    jal ra, printClusters

    #4. calculateCentroids
<<<<<<< HEAD
    la a0, Quarto
    li a7, 4
    ecall
    
=======
    # POR IMPLEMENTAR (1a parte)
>>>>>>> a8c59333eeaedf1fbfd5330406da6e4c970968b9
    jal ra, calculateCentroids
    
    #5. printCentroids
    la a0, Quinto
    li a7, 4
    ecall
    
    jal ra, printCentroids

    #6. Termina
    termina:
        j termina
#------------------------------------------------------------------------------------------


### manhattanDistance
# Calcula a distancia de Manhattan entre (x0,y0) e (x1,y1)
# Argumentos:
# a0, a1: x0, y0
# a2, a3: x1, y1
# Retorno:
# a0: distance

manhattanDistance:
    # POR IMPLEMENTAR (2a parte)
    jr ra


### nearestCluster
# Determina o centroide mais perto de um dado ponto (x,y).
# Argumentos:
# a0, a1: (x, y) point
# Retorno:
# a0: cluster index

nearestCluster:
    # POR IMPLEMENTAR (2a parte)
    jr ra


### mainKMeans
# Executa o algoritmo *k-means*.
# Argumentos: nenhum
# Retorno: nenhum

mainKMeans:  
    # POR IMPLEMENTAR (2a parte)
    jr ra
