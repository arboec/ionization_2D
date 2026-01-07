load('Z=2_bound_states.mat'); %load bound states
load('Z=2_size_of_bound_states.mat'); %load a size of bound states

%normalize wave function
%------------------------------------------
f = psi;
f = f / max(max(abs(f)));
norm = sqrt(hx*hy*simps(simps((abs(f)).^2)));
f = f / norm; %normalize wave function
w = f;

rr = sqrt(x.^2 + y.^2);
theta = atan2(y,x);

coefSum = 0;
coefSum2 = 0;
wS = w;
%------------------------------------------

investigate(30,30) = 0;

for m=-15:1:15 % orbital quantum bumber
for j=1:1:30 % principal quantum number
    xx(1:sizeOfSpectrum(abs(m)+1,j)) = xCordinate(abs(m)+1,j,1:sizeOfSpectrum(abs(m)+1,j));
    yy(1:sizeOfSpectrum(abs(m)+1,j)) = yValues(abs(m)+1,j,1:sizeOfSpectrum(abs(m)+1,j));
        
    valuesR = interp1(xx,yy,rr,'spline');
    values = valuesR .* exp(1j*theta*m);
    values = values / sqrt(2*pi); 
    coef = hx*hy*simps(simps(w .* conj(values)));
    coefSum = coefSum + abs(coef);
    coefSum2 = coefSum2 + abs(coef).^2;
    investigate(m+16,j) = abs(coef).^2; % save what was a coefficient^2 for the projection on (m,j) state 
    
    wS = wS - coef*values; %substract the bpund state
end

clear xx;
clear yy;
end

1-coefSum2 % ionization coefficient
