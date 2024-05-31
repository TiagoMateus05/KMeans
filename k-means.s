
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
    #E o respetivo vetor de indices (id_points), introduzidos no .data
    
    #Caso pretenda colocar mais k, tenha em aten��o ao numero de cores que deseja, tal como
    #As cores pretendidas, introduzido no .data

#-------------------------------------------------------------------------------------------
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

#Input E
#n_points: .word 100
#id_points: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#points: .word 27, 8, 9, 29, 29, 16, 14, 2, 22, 29, 30, 28, 31, 21, 15, 31, 8, 9, 18, 1, 31, 25, 26, 19, 1, 20, 14, 17, 20, 22, 15, 6, 14, 16, 11, 19, 27, 20, 16, 13, 13, 30, 8, 4, 9, 29, 27, 22, 2, 31, 9, 15, 27, 0, 22, 18, 26, 11, 19, 14, 21, 26, 4, 31, 21, 2, 11, 29, 17, 20, 17, 17, 7, 2, 18, 17, 31, 25, 12, 27, 5, 6, 6, 31, 17, 3, 20, 13, 10, 12, 30, 0, 27, 30, 11, 25, 0, 3, 4, 26, 18, 27, 19, 12, 19, 25, 17, 1, 7, 1, 8, 24, 13, 31, 2, 7, 30, 6, 12, 27, 29, 10, 7, 1, 3, 19, 29, 11, 20, 13, 29, 10, 25, 24, 26, 14, 8, 22, 27, 21, 20, 4, 18, 0, 26, 17, 14, 14, 13, 14, 29, 17, 30, 20, 29, 19, 14, 1, 19, 1, 19, 19, 20, 12, 17, 4, 8, 10, 0, 25, 24, 6, 29, 3, 7, 15, 14, 29, 20, 24, 13, 28, 12, 28, 5, 24, 15, 29, 10, 5, 6, 15, 17, 16, 23, 26, 25, 14, 26, 8

#Input F
#n_points: .word 200
#id_points: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#points: .word 5, 23, 26, 24, 15, 1, 17, 18, 19, 1, 5, 11, 12, 31, 5, 30, 30, 15, 27, 12, 26, 11, 14, 12, 26, 21, 22, 18, 1, 26, 22, 18, 22, 0, 31, 22, 16, 30, 26, 22, 6, 16, 2, 2, 24, 16, 21, 26, 12, 13, 27, 21, 4, 17, 17, 28, 9, 14, 18, 26, 31, 13, 0, 28, 4, 7, 8, 28, 17, 18, 28, 14, 22, 26, 25, 10, 20, 1, 23, 2, 3, 26, 6, 19, 9, 22, 20, 10, 0, 0, 28, 19, 27, 31, 13, 9, 1, 15, 14, 6, 26, 21, 13, 27, 25, 19, 23, 0, 24, 13, 8, 11, 29, 26, 0, 4, 23, 1, 9, 4, 0, 15, 1, 20, 6, 8, 13, 8, 23, 2, 30, 22, 19, 30, 21, 10, 10, 0, 3, 0, 16, 15, 17, 27, 23, 30, 23, 2, 26, 19, 17, 0, 8, 4, 23, 20, 23, 8, 20, 2, 4, 16, 11, 12, 11, 1, 2, 17, 25, 23, 21, 25, 23, 25, 10, 14, 7, 19, 18, 8, 1, 9, 26, 8, 30, 2, 22, 12, 6, 2, 10, 20, 31, 2, 18, 30, 10, 15, 12, 13, 13, 11, 27, 18, 23, 23, 30, 24, 18, 13, 4, 28, 6, 10, 25, 28, 26, 22, 29, 22, 22, 22, 11, 23, 2, 13, 3, 6, 11, 31, 31, 24, 22, 11, 25, 18, 8, 30, 14, 0, 11, 6, 26, 24, 23, 24, 25, 4, 30, 9, 24, 15, 26, 11, 18, 1, 19, 1, 24, 25, 0, 14, 31, 28, 10, 24, 25, 6, 16, 25, 1, 19, 7, 30, 14, 18, 20, 23, 26, 2, 22, 8, 5, 5, 29, 2, 3, 6, 26, 19, 15, 18, 0, 6, 11, 1, 17, 0, 24, 0, 5, 12, 22, 19, 29, 10, 16, 13, 31, 22, 7, 16, 11, 26, 27, 0, 29, 2, 30, 11, 1, 17, 30, 17, 7, 29, 20, 25, 7, 10, 3, 12, 14, 19, 21, 4, 30, 1, 7, 4, 13, 25, 25, 2, 5, 23, 16, 27, 12, 20, 4, 21, 26, 1, 29, 31, 10, 10, 13, 21, 6, 11, 15, 14, 0, 31, 25, 11, 1, 29, 21, 30, 31, 5, 18, 31, 16, 23, 15, 7, 13, 12, 16, 15, 16, 18, 11, 27, 27, 15, 17, 10, 2, 15, 17, 19, 11, 14, 27, 28

#Input G
#n_points: .word 400
#id_points: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#points: .word 1, 13, 1, 10, 31, 0, 29, 18, 27, 5, 28, 13, 0, 7, 15, 28, 9, 21, 24, 23, 4, 17, 9, 0, 16, 1, 16, 13, 28, 17, 19, 10, 9, 2, 4, 25, 26, 1, 31, 2, 22, 12, 18, 25, 8, 18, 14, 18, 0, 28, 25, 29, 20, 7, 31, 31, 0, 24, 23, 27, 6, 11, 22, 2, 22, 18, 18, 21, 13, 20, 22, 24, 11, 5, 7, 31, 3, 20, 17, 31, 24, 6, 13, 4, 16, 26, 20, 28, 29, 21, 30, 5, 8, 11, 17, 31, 23, 1, 9, 27, 16, 30, 7, 5, 7, 4, 14, 20, 26, 22, 13, 9, 30, 27, 20, 13, 19, 1, 21, 15, 30, 13, 7, 13, 1, 15, 29, 23, 11, 17, 15, 15, 8, 30, 11, 2, 0, 12, 2, 30, 26, 31, 6, 2, 24, 31, 21, 30, 31, 23, 11, 27, 19, 13, 22, 5, 13, 14, 26, 0, 22, 25, 27, 8, 30, 9, 19, 21, 23, 22, 14, 6, 21, 21, 7, 3, 20, 3, 31, 2, 21, 14, 21, 26, 3, 24, 29, 10, 28, 30, 7, 23, 17, 17, 11, 4, 28, 7, 16, 2, 13, 7, 1, 7, 9, 2, 31, 17, 20, 4, 6, 1, 26, 7, 21, 9, 23, 3, 16, 15, 1, 12, 9, 19, 24, 5, 15, 3, 9, 1, 29, 18, 28, 15, 28, 26, 21, 25, 7, 3, 28, 5, 25, 12, 6, 25, 16, 19, 23, 5, 13, 24, 21, 25, 23, 18, 13, 0, 25, 22, 18, 28, 3, 17, 22, 13, 7, 3, 2, 3, 22, 31, 19, 26, 11, 15, 28, 17, 18, 20, 3, 18, 13, 17, 22, 28, 24, 14, 26, 11, 10, 16, 6, 26, 1, 5, 23, 10, 21, 11, 25, 28, 9, 27, 22, 18, 0, 17, 18, 11, 7, 19, 23, 7, 2, 28, 18, 12, 7, 9, 14, 30, 22, 1, 12, 14, 18, 2, 3, 28, 24, 26, 6, 10, 22, 12, 10, 10, 15, 5, 25, 0, 27, 24, 4, 25, 6, 7, 5, 4, 10, 8, 22, 24, 19, 28, 23, 7, 0, 21, 25, 14, 17, 18, 23, 9, 24, 16, 19, 14, 25, 28, 16, 28, 29, 4, 27, 7, 10, 0, 16, 8, 10, 24, 7, 21, 13, 20, 21, 4, 19, 3, 12, 22, 0, 10, 9, 21, 17, 27, 26, 15, 24, 28, 23, 4, 31, 15, 25, 18, 9, 18, 24, 28, 14, 18, 2, 7, 18, 11, 7, 15, 7, 20, 18, 17, 10, 8, 4, 18, 21, 12, 9, 4, 23, 19, 13, 14, 27, 23, 9, 5, 13, 8, 9, 7, 6, 9, 24, 16, 20, 7, 30, 16, 30, 31, 5, 23, 11, 3, 8, 22, 7, 0, 5, 20, 28, 5, 26, 7, 16, 11, 0, 21, 7, 26, 28, 15, 23, 23, 3, 31, 25, 9, 13, 17, 7, 0, 0, 19, 29, 30, 2, 31, 0, 1, 29, 26, 21, 2, 14, 22, 19, 30, 18, 31, 12, 11, 26, 28, 5, 22, 27, 9, 9, 13, 28, 25, 11, 13, 18, 17, 8, 12, 15, 27, 21, 20, 20, 16, 5, 8, 11, 16, 2, 20, 23, 24, 1, 30, 25, 5, 3, 9, 0, 7, 26, 25, 23, 28, 26, 24, 3, 2, 10, 15, 16, 31, 22, 11, 18, 28, 10, 8, 1, 12, 30, 14, 2, 23, 27, 24, 12, 22, 30, 20, 29, 27, 13, 5, 28, 1, 8, 15, 2, 8, 11, 31, 2, 16, 10, 3, 25, 12, 19, 18, 18, 4, 28, 0, 25, 3, 21, 2, 12, 14, 28, 7, 16, 5, 1, 17, 21, 24, 27, 5, 17, 31, 24, 7, 18, 7, 15, 25, 21, 0, 24, 21, 5, 14, 4, 7, 11, 11, 17, 0, 25, 29, 14, 21, 6, 17, 24, 22, 20, 16, 2, 29, 8, 4, 26, 2, 2, 20, 28, 9, 2, 0, 5, 11, 9, 18, 22, 2, 1, 13, 17, 13, 0, 25, 29, 29, 18, 24, 3, 8, 12, 2, 0, 13, 6, 17, 28, 22, 25, 30, 8, 6, 20, 17, 13, 0, 0, 19, 8, 24, 30, 7, 30, 25, 2, 20, 9, 5, 2, 21, 20, 10, 14, 28, 4, 17, 22, 14, 20, 22, 14, 15, 10, 17, 23, 12, 18, 28, 14, 8, 22, 30, 28, 11, 0, 1, 8, 1, 7, 13, 0, 26, 14, 3, 15, 13, 28, 13, 12, 5, 24, 27, 30, 8, 15, 3, 0, 20, 13, 25, 16, 22, 20, 3, 0, 20, 21, 13, 24, 13, 10, 12, 29, 7, 28, 24, 19, 21, 14, 27, 19, 27, 30, 25, 3, 15, 29, 8, 7, 3, 5, 20, 10, 15, 14, 5, 19, 10, 2, 12, 4, 0, 26, 11

# Valores de centroids, k e L a usar na 2a parte do prejeto:
#centroids:   .word 0,0, 0,0 , 0,0 0,0 , 0,0 , 0,0 , 0,0 , 0,,0
#k:           .word 8
#L:           .word 20   

#centroids:   .word 0,0, 0,0 , 0,0 0,0 0,0 0,0 0,0
#k:           .word 7
#L:           .word 20  

#centroids:   .word 0,0, 0,0 , 0,0 0,0 0,0 0,0
#k:           .word 6
#L:           .word 20    
    
#centroids:   .word 0,0, 0,0 , 0,0 0,0 0,0
#k:           .word 5
#L:           .word 20

#centroids:   .word 0,0, 0,0 , 0,0 0,0
#k:           .word 4
#L:           .word 10

centroids:   .word 0,0, 0,0 , 0,0
k:           .word 3
L:           .word 10

#centroids:   .word 0,0, 0,0
#k:           .word 2
#L:           .word 10

# Abaixo devem ser declarados o vetor clusters (2a parte) e outras estruturas de dados
# que o grupo considere necessarias para a solucao:
#clusters:    


# Strings para o output

Primeiro:        .string "A limpar o ecra...\n"
Segundo:         .string "A gerar os centroids...\n"
SegundoB:        .string "A colocar centroids...\n"
Terceiro:        .string "A preencher os pontos dos clusters...\n"
Quarto:          .string "A calcular novos centroids... \n"
Quinto:          .string "A terminar KMeans...\n"

# Definicoes de RNG
seed: .word 0    #Seed Definido pelo Clock low 32bits
mult: .word 295409844
.equ C 1         #Incrementecao de 1
.equ mod 31      #Modulo para os 32 tamanho led, evita repeticoes de pontos



# Definicoes de cores a usar no projeto 
colors:      .word 0xf3a0ad, 0x6d8777 , 0xb28dff, 0x20639b, 0x1ed14b, 0xb32d2e, 0xe09f3e, 0x39244f   # Cores dos pontos do cluster 0, 1, 2, etc.

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
    sw t1, 8(sp)           #Guarda a contagem do ciclo
    
    lw a0, 0(a4)           #Da load ao ponto X
    lw a1, 4(a4)           #Da load ao ponto Y
    sw a0, 4(sp)           #Guarda o valor de X
    
    jal ra, nearestCluster #Calcula o centroid mais proximo para o ponto
    sw a0, 0(a5)           #Guarda o indice do centroid no correnspondete ponto
    la t3, colors          #Carrega as cores usadas

ciclo_cores:               #Pesquisa a cor correspondente ao indice
    blez a0, 16            #Quando encontrar (percorrer o vetor tal colors[i]) continua o algoritmo
    addi t3, t3, 4         #Avanca no vetor de cores
    addi a0, a0, -1        #Decrementa por um a contagem no vetor
    j ciclo_cores
    
    lw a2, 0(t3)           #Carrega a cor
    lw a0, 4(sp)           #Da load ao ponto X guardado
    jal ra, printPoint     #Chama a funcao printPoint
    
    addi a4, a4, 8         #Vai para o proximo ponto
    lw t1, 8(sp)           #Carrega a contagem do ciclo
    addi a5, a5, 4         #Avanca no vetor dos indices dos pontos
    addi t1, t1, -1        #Contador do loop
    j printLoop_Points     #Vai para a funcao printLoop
end_Points:
    lw ra, 0(sp)           #Da load ao endereco de retorno
    addi sp, sp, 12         #Liberta espaco na stack     
    jr ra                  #Retorna para o ponto de chamada






### printCentroids
# Pinta os centroides na LED matrix
# Nota: deve ser usada a cor preta (black) para todos os centroides
# Argumentos: a2: cor
# Retorno: nenhum
printCentroids:
    la t0, centroids       #Da load ao vetor de centroids
    lw t1, k               #Da load ao numero de centroids
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
    addi sp, sp, -4        #Guarda espaco na stack para os argumentos
    sw ra, 0(sp)           #Guarda o endereco de retorno
    la t0, centroids       #Da load ao vetor dos centroids
    lw s2, k               #Da load ao numero de centroids
    addi a2, zero, 0    #para indices
    
loop_points_exterior:  
    blez s2, termina
    
    lw t2, n_points        #Da load ao numero de pontos
    la t1, points          #Da load ao vetor que contem os pontos
    la s1, id_points       #Da load ao vetor que contem os indices dos pontos
    
    #Colocar as variaveis a zero
    addi t3, zero, 0    #para x
    addi t4, zero, 0    #para y
    addi a4, zero, 0    #para o numero de pontos usados
    

    loop_points_interior:
        blez t2, termina_interior
        lw a3, 0(s1)           #Carrega o indice do ponto atual
        bne a2, a3, skip_se_nao_indice
    
        lw t5, 0(t1)           #Da load ao valor X
        lw t6, 4(t1)           #Da load ao valor Y
    
        add t3, t3, t5         #Adiciona o valor x a media
        add t4, t4, t6         #Adiciona o valor x a media
        addi a4, a4, 1         #Incrementa em 1 o ponto usado
        
    skip_se_nao_indice:
        addi t1, t1, 8         #Avanca para o proximo ponto
        addi s1, s1, 4         #Avanca para o proximo indice correspondente ao ponto
        addi t2, t2, -1        #Decrementa a contagem do loop interno
        j loop_points_interior
    
    termina_interior:
    add t5, t3, t4         #Soma a soma dos x e y
    beqz t5, nao_altera_centroid    #Caso a soma de x e a soma de y seja zero, nao muda o valor
    
    div a0, t3, a4         #Calcula a coordenada X do centroid
    div a1, t4, a4         #Calcula a coordenada Y do centroid
    
    sw a0, 0(t0)           #Guarda o ponto X do centroid no vetor
    sw a1, 4(t0)           #Guarda o ponto Y do centroid no vetor
    
nao_altera_centroid:
    addi t0, t0, 8         #Avanca para o proximo centroid
    addi s2, s2, -1        #Decrementa a contagem do loop interno
    addi a2, a2, 1
    j loop_points_exterior

termina:
    
    lw ra, 0(sp)           #Da load ao endereco de retorno
    addi sp, sp, 4         #Liberta espaco na stack
    jr ra                  #Retorna para o ponto de chamada
    
#Funcao de otimizacao (NAO USADA), permite que, quando um cluster esteja vazio, gera novos centroids
reset_centroids:
    addi sp, sp, 4
    j reset_centroids_no_data

### mainSingleCluster
# Funcao principal da 1a parte do projeto.
# Argumentos: nenhum
# Retorno: nenhum

#----------------------------------------------------------------------------------------
mainSingleCluster:                  #~~MAIN~~
    #1. Coloca k=1 (caso nao esteja a 1)
    # POR IMPLEMENTAR (1a parte)
    #addi sp, sp, -4
    #sw ra, 0(sp)
    
    #la a0, Primeiro
    #li a7, 4
    #ecall
    
    #la t0, k
    #addi t1, zero, 1
    #sw t1, 0(t0)
    
    #2. cleanScreen
    #la a0, Segundo
    #li a7, 4
    #ecall
    
    #jal ra, cleanScreen

    #3. printClusters
    #la a0, Terceiro
    #li a7, 4
    #ecall
    
    #jal ra, printClusters

    #4. calculateCentroids
    #la a0, Quarto
    #li a7, 4
    #ecall
    
    #jal ra, calculateCentroids
    
    #5. printCentroids
    #la a0, Quinto
    #li a7, 4
    #ecall
    
    #jal ra, printCentroids

    #6. Termina
    #la a0, Final
    #li a7, 4
    #ecall
    
    #lw ra, 0(sp)
    #addi sp, sp, 4
    #jr ra
#------------------------------------------------------------------------------------------
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
    la t6, seed        #carrega o endere?o do seed do RNG
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
    addi t0, t0, 4     #Incrementa o proximo espa?o
    addi t1, t1, -1    #Decrementa o contador
    j centroidGenerateCicle #Repete o ciclo para x e depois y at? todos os pontos
     
fim_ciclo_gerador:
    lw ra, 0(sp)       #Carrega endere?o de retorno
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
    addi sp, sp, -4           #Aloca memoria no stack
    sw ra, 0(sp)              #Guarda o endereco de retorno
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
    lw ra, 0(sp)              #Carrega o endereco de retorno
    addi sp, sp, 4            #Liberta a memoria do stack
    jr ra                     #Retorna para o endereco ra


### nearestCluster
# Determina o centroide mais perto de um dado ponto (x,y).
# Argumentos:
# a0, a1: (x, y) point
# Retorno:
# a0: cluster index

nearestCluster:
    addi sp, sp, -8                 #0: ra, -4: a0 para x, 
    sw ra, 0(sp)                    #Guarda a o endereco de retorno
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
    lw ra, 0(sp)                    #Carrega o endereco de retorno
    addi sp, sp, 8                  #Liberta memoria no stack
    jr ra                           #Retorna para o endereco de retorno


### mainKMeans
# Executa o algoritmo *k-means*.
# Argumentos: nenhum
# Retorno: nenhum
#--------------------------------------------------------------------------------------------
mainKMeans:  
    addi sp, sp, -4        #Aloca memoria no stack
    sw ra, 0(sp)           #Guarda o endereco de retorno no stack
    lw s11, L              #Carrega o numero de iteracoes
    
    #Limpa o ecra e envia mensagem para a consola
    li a7, 4
    la a0, Primeiro
    ecall
    jal cleanScreen

reset_centroids_no_data:
    
    #Inicializa centroids atrav�s de RNG e envia mensagem para a consola
    li a7, 4
    la a0, Segundo
    ecall
    jal initializeCentroids
    
L_iterations:
    blez s11, end_Iteration #Caso o numero de iteracoes acabe, termina o programa
    addi s11, s11, -1       #Decrementa a contagem do numero de iteracoes por um
    
    #Coloca os centroids e envia a mensagem para a consola
    li a7, 4
    la a0, SegundoB
    ecall
    li a2, black           #Da load a cor do centroid para colocar
    jal printCentroids     #Coloca os centroids
    
    #Coloca os Clusters e Calcula os indices e as cores e envia a mensagem para a consola
    li a7, 4
    la a0, Terceiro
    ecall
    jal printClusters
    
    #OTIMIZACAO
    #Remove os centroids para recalcular os novos centroids
    #Assim remove a necessidade em cada iteracao de usar o cleanScreen, sendo uma funcao
    #Demorada. Os clusters irao ser reescritos na proxima chamada da funcao printCentroids
    li a2, lightpurple           #Da load a cor do centroid para remover
    jal printCentroids     #Remove os centroids
    
    jal calculateCentroids
    li a7, 4
    la a0, Quarto
    ecall

    li a2, black           #Da load a cor do centroid para colocar
    jal printCentroids     #Coloca os centroids
    
    j L_iterations
end_Iteration:
    #Evnia mensagem de termino do programa
    li a7, 4
    la a0, Quinto
    ecall
    
    #jal cleanScreen
    lw ra, 0(sp)        #Da load do endereco de retorno
    addi sp, sp, 4      #Liberta memoria do stack
    jr ra               #Retorna para o endereco de retorno
