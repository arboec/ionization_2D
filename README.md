# ionization_2D
Here you can find supplimentary files for the article "Quasiperiodic nondipole ionization dynamics in the x-ray stabilization regime".

# Figures
Folder "Figures" contains all the figures (except fig7 and fig11, they are too large) from the paper as *.fig files. The *.fig files are not just images, yet store all the raw plotted data. If you have MATLAB installed, the you can simply open a *.fig file and use it interactivley (rescale axes, zoom in or out, etc.). 

*Please, send me an e-mail to arboec@gmail.com to receive fig7 and fig 11.

If the raw data are needed, then one can access it with a few MATLAB commands.
1) As a first step, open the corresponding figure (for example, fig1.fig).
2) To access the ionization data for the a_0 case, type 3 lines:
   
    h = findobj(gca,'Type','line') \\
    pulse_length = h(1).XData; \\
    ionization_prob = h(2).YData;

If you do not have MATLAB, then the data can be accessed with an open source alternative Octave. Here is a link on how to open .fig file with Octave:
https://github.com/rsnape/OpenMatlabFigureInOctave/tree/master

# TDSE
Folder "TDSE" contains the code to calculate non-relativistic ionization of a simple one electron system (applicable if the field parameter a_0 is small). There are 3 main files and many supplimentary ones:

launch.m -- sets the parameters of the simulation and launches simulation.m and extractSpectrum.m

simulation.m -- solves a TDSE for n atom, exposed to the nondipole laser field.

extractSpectrum.m -- calculates the spectrum after the end of the simulation.

# Relativistic Foldy-Wouthausen equation
The C++ code to obain results for the large field parameter a_0 is, of course, available upon the request by e-mail. It is somewhat cumbersome and depends on the two external libraries (oneMKL for the parallel calculations and Eigen for matrix calculations).
