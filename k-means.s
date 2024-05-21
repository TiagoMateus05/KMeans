
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
#centroids:   .word 0,0
#k:           .word 1

# Valores de centroids, k e L a usar na 2a parte do prejeto:
centroids:   .word 0,0, 10,0, 0,10
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


# Definicoes de cores a usar no projeto 

colors:      .word 0xff0000, 0x00ff00, 0x0000ff  # Cores dos pontos do cluster 0, 1, 2, etc.

.equ        black         0
.equ        white         0xffffff
.equ        red           0xff0000
.equ        green         0x00ff00
.equ        blue          0x0000ff
.equ        lightpurple        0xeceae4
.equ        purple        0xb28dff


# Codigo
 
.text
    # Chama funcao principal da 1a parte do projeto
    #jal mainSingleCluster

    # Descomentar na 2a parte do projeto:
    jal mainKMeans
    
    # Termina o programa (chamando chamada sistema)
    #la a0, Final
    #li a7, 4
    #ecall
    #li a7, 10
    #ecall


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
    la t0, points         #Da load ao vetor dos pontos
    lw t1, n_points       #Da load ao numero de pontos
    li a2, purple           #Da load a' cor
    addi sp, sp, -4       #Guarda memoria na stack
    sw ra, 0(sp)          #Guarda o endereco de retorno e vai para printLoop
  
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
    

### calculateCentroids
# Calcula os k centroides, a partir da distribuicao atual de pontos associados a cada agrupamento (cluster)
# Argumentos: nenhum
# Retorno: nenhum

calculateCentroids:
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

    lw t2, 4(sp)           #Da load a' vari?vel temporaria
    div a0, t3, t2         #Calcula a coordenada X do centroid
    div a1, t4, t2         #Calcula a coordenada Y do centroid
    
    lw ra, 0(sp)           #D? load ao endereco de retorno
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

### mainSingleCluster
# Funcao principal da 1a parte do projeto.
# Argumentos: nenhum
# Retorno: nenhum

#----------------------------------------------------------------------------------------
mainSingleCluster:                  #~~MAIN~~
    #1. Coloca k=1 (caso nao esteja a 1)
    # POR IMPLEMENTAR (1a parte)
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
    
    jal ra, printClusters

    #4. calculateCentroids
    la a0, Quarto
    li a7, 4
    ecall
    
    jal ra, calculateCentroids
    
    #5. printCentroids
    la a0, Quinto
    li a7, 4
    ecall
    
    jal ra, printCentroids

    #6. Termina
    la a0, Final
    li a7, 4
    ecall
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
    jr ra


### nearestCluster
# Determina o centroide mais perto de um dado ponto (x,y).
# Argumentos:
# a0, a1: (x, y) point
# Retorno:
# a0: cluster index

nearestCluster:
    # POR IMPLEMENTAR (2a parte)
    lw a6, k                        #Dar load ao numero de centroids
    la a7, centroids                #Dar load ao vetor de centroids
    li t0, 0                        #Inicializar a variavel onde vai estar o centroid final
    li t2, 0
ciclo:
    beqz a6, fim                    #Se chegar ao fim do vetor dos centroids vai para o final da funcao
    mv a2, a7                       #Colocar o x do centroid no registo correspondente
    addi a7, a7, 4                  #Passar para o proximo valor do vetor, que e' o y
    mv a3, a7                       #Colocar o y do centroid no registo correspondente
    jal manhattanDistance           #Calcular a distancia entre o ponto dado e o centroid
    addi a6, a6, -1                 #Diminuir o valor de k para sinalizar que ja se analisou 1 centroid
    beqz t0, primeira_iteracao      #Se for a primeira iteracao, vai guardar os valores independentemente de se e' a distancia menor ou nao
    bltu a0, t1, alterar            #Nas proximas, apenas altera as informacoes se a distancia calculada for menos que a anterior
    addi t2, t2, 1                  #Aumenta o contador do indice dos clusters
    j ciclo
primeira_iteracao:
    mv t1, a0                       #O t1 vai guardar a distancia entre os pontos do centroid anterior               #
    j ciclo                         #Proxima iteracao do ciclo
alterar:
    mv t1, a0                       #Guarda o valor da distancia
    addi t2, t2, 1                  #Aumenta o contador do indice dos clusters
    mv t0, t2                       #Indica que o indice do cluster correspondente
    j ciclo
fim:
    mv a0, t0                       #Coloca o indice do cluster no a0
    jr ra


### mainKMeans
# Executa o algoritmo *k-means*.
# Argumentos: nenhum
# Retorno: nenhum

mainKMeans:  
    # POR IMPLEMENTAR (2a parte)
    li a0, 4
    li a1, 2
    jal nearestCluster
    jr ra
    
