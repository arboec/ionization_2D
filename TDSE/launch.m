omega = 14; %laser frequenct, a.u.
Z = 2; % Helium
Nx = 2000; Lx = 100; Ny = 2000; Ly = 100; %size of the simulation box
waitTime = 10; %waiting time after the end of the interaction
a0 = 0.24; %relativistic field parameter
parameter = 50; % numer of cycles in the pulse

simulation(a0,omega,Z,parameter,Nx,Ny,Lx,Ly,waitTime)
