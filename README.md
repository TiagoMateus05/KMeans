# KMeans
KMeans Assembly

## This is a Assembly RISC-V based project

  The objective of this project is to be able to run a kmeans algorithm, thus, calculating n clusters of n points within a provided data.
  While the code is written in RISC-V, it is fairly easy to change the input in the .data section.

### Inputs:
  Points:
  - n_points: "number of points"
  - id_points: "fill with 0 the number of points"
  - points: "points, starting with x then y"
    
  Centroids:
  - centroids: "fill with 0 (x,y) the number of centroids
  - K: "number of centroids"
  - L: "number of iterations"

## How to run:
  You need to setup a display and put the configurations inside the code. The display can contain any size you want. Running on a emulator such as Ripes is recommended for the simplicity. Either way, just set up the inputs (explained in the top) and run the program. It should be noted that there is no "step-by-step" runner, so, once you press it. It will calculate the final clusters.
  The program is only stoped when the number of iterations is done. Since the centroids are randomly chosen (using the clock time), there will be certain calculations wich a cluster ends up not having any points. Note that the base Kmeans algorithm has this situation in mind.

