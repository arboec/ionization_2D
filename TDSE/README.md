# TDSE
Folder "TDSE" contains the code to calculate non-relativistic ionization of a simple one electron system (applicable if the field parameter a_0 is small). There are 3 main files and many supplimentary ones:

launch.m -- sets the parameters of the simulation and launches simulation.m and extractSpectrum.m

simulation.m -- solves a TDSE for n atom, exposed to the nondipole laser field.

extractSpectrum.m -- calculates the spectrum after the end of the simulation.

-----------------------
myshape.m -- a shape of the laser pulse A(z,t)

Z=2_bound_states.mat -- data file, contains bound states with orbital quantum numbers m=-15...15 and principal quantum number n=0..14. It is 27 MB large and thus cannot be uploaded to github. Please, send me an e-mail to arboec@gmail.com to get it.

Z=2_size_of_bound_states.mat -- size of the file "Z=2_bound_states.mat"
