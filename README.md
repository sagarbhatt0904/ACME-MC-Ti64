# Monte Carlo grain growth Code

Here are two versions of grain growth code availble in this repository:
- ```mcCode_staticTemp```:   This code can model grain growth under static temperature for a single phase material.
- ```mcCode_tempGradient```: This code can model grain growth under a temperature field provided in an external file. An additional MATLAB file is provided as an example to map temperature field from finite element simulation to a structured monte carlo grid. 
- A third version of this code is under development with capability to model grain growth for multiple phases with strain energy from crystal plasticity finite element deformation simulations.


### Usage notes:

- Needs an MPI compiler, BLAS and Pthreads.
- Use ```make parallelmc``` to build the executable
- Run the code using the following command:
``` mpirun -n <num_procs> ./parallel_mc.out --nonstop <dimensions> <fileName.00000.dat> <number_of_steps> <intervals_to_write_files> <steps_to_nonuniform_temp> <number_of_threads> <temp1> <temp2>

**This Work is derived from https://github.com/ACME-Project/ACMEmc**
Some of this work was supported by the National Science Foundation under Grant No. CMMI-1729336.