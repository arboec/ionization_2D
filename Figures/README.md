# Figures
Fig7 and Fig11 can be accesssed by sending me an e-mail, they are ~ 100 MB large and exceed GitHub quota.

Folder "Figures" contains all the figures (except fig7 and fig11) from the paper as *.fig files. The *.fig files are not just images, yet store all the raw plotted data. If you have MATLAB installed, the you can simply open a *.fig file and use it interactivley (rescale axes, zoom in or out, etc.). 

If the raw data are needed, then one can access it with a few MATLAB commands.
1) As a first step, open the corresponding figure (for example, fig1.fig).
2) To access the ionization data for the a_0 case, type 3 lines:
    h = findobj(gca,'Type','line')
    pulse_length = h(1).XData;
    ionization_prob = h(2).YData;

If you do not have MATLAB, then the data can be accessed with an open source alternative Octave. Here is a link on how to open .fig file with Octave:
https://github.com/rsnape/OpenMatlabFigureInOctave/tree/master
