function simulation(a0,omega,Z,parameter,Nx,Ny,Lx,Ly,waitTime)

c = 137;
A0 = c * a0; % A0(z,t) laser field

hx = 2 * Lx / Nx;
hy = 2 * Ly / Ny;
hpx = pi / Lx; %step size for the corresponding grid in a Fourier space
hpy = pi / Lx;
x(Nx,Nx) = 0;
y(Nx,Nx) = 0;
for i = 0:1:Nx-1
    for j = 0:1:Ny-1
            x(i+1,j+1) = -Lx + hx * i;
            y(i+1,j+1) = -Ly + hy * j;
            px(i+1,j+1) = pi * (i - 0.5 * Nx) / Lx;
            py(i+1,j+1) = pi * (j - 0.5 * Ny) / Ly;
    end
end

V = -1.5 * Z ./ sqrt((x.*x+y.*y) + 3.0/(Z*Z)); % Soft-Coulomb potential

VAbsorb = ones(Nx);
VAbsorb(Nx*0.1:0.9*Nx,Nx*0.1:0.9*Nx) = 0;
rectCone = (abs(x+y)+abs(x-y));
VAbsorb = VAbsorb .* (rectCone- rectCone(Nx*0.1,Nx*0.1)); % Absorbing potential on the boundaries
V = V + 1j*VAbsorb; %Total potential

tau = 2.5*2*pi/omega; % a parameter of the laser turn on stage, a.u.
maxT = 6; % maxT/2 = how many taus are in the turn on or turn off stage 
dt = 1e-3; 
counter = 1; 
counterTraj = 0;
xAverage(1500) = 0; yAverage(1500) =0;  timeTraj(1500) = 0;
kick1(1500) = 0; kick2(1500) = 0; kickx(1500) = 0; kicky(1500) = 0;

%initial wave function
psi = 2*exp(sqrt(3))*Z/(3*pi*(10*sqrt(3)+13)) * (1.0 + sqrt(3.0 + (x.*x+y.*y)*Z*Z)) .* exp(-sqrt(3.0 + (x.*x + y.*y)*Z*Z));

px = fftshift(px);
py = fftshift(py);

tauOm = parameter * 2*pi/omega; %how long a flat stage of the pulse is, a.u.     

for t=0:dt:maxT*tau+tauOm

    nu = t - y/c; % nondipole case. for the dipole case set: nu = t - 0*y/c;
    A = A0 * myshape(nu,tau,maxT,tauOm,omega); % calc laser field at each time step
    
    T0 = 0.5*(px.*px + py.*py); % free kinetic energy 
    T2 = 0.5*A.*A; % contribtion A^2
    T1 = -0.5*2*A.*px; %contribution A*px

    psi = exp(dt*0.5*1j*V) .* psi; %propogate with potential energy
    
    psi = exp(dt*1j*T2) .* psi; %propogate with T2 energy

    psiPx = fft(psi,Nx,1);
    psiPx = exp(dt*1j*T1) .* psiPx; %propogate with T1 energy
    psi = ifft(psiPx,Nx,1);

    psiP = fft2(psi);
    psiP = exp(dt*1j*T0) .* psiP; %propogate with T0 energy
    psi = ifft2(psiP);

    psi = exp(dt*0.5*1j*V) .* psi; %propogate with potential energy

    counter = counter + 1;
    if (mod(counter,20)==0) %calc different properties at every 20-th time step
        t
        counterTraj = counterTraj + 1;
        xAverage(counterTraj) = trapz(trapz(x.*abs(psi).*abs(psi))) / trapz(trapz(abs(psi).*abs(psi)));
        yAverage(counterTraj) = trapz(trapz(y.*abs(psi).*abs(psi))) / trapz(trapz(abs(psi).*abs(psi)));
        timeTraj(counterTraj) = t;

        r = sqrt(x.*x+y.*y);
        Vdr = -1.5*Z * (-0.5) * 2 * r ./ (r.^2 + 3.0/(Z*Z)).^(3/2);
        Vdx = -1.5*Z * (-0.5) * 2 * x ./ (r.^2 + 3.0/(Z*Z)).^(3/2);
        Vdy = -1.5*Z * (-0.5) * 2 * y ./ (r.^2 + 3.0/(Z*Z)).^(3/2);
        kick1(counterTraj) = trapz(trapz(Vdr.*abs(psi).*abs(psi))) / trapz(trapz(abs(psi).*abs(psi)));
        kick2(counterTraj) = trapz(trapz(Vdr./(r+1e-12).*abs(psi).*abs(psi))) / trapz(trapz(abs(psi).*abs(psi)));
        kickx(counterTraj) = trapz(trapz(Vdx.*abs(psi).*abs(psi))) / trapz(trapz(abs(psi).*abs(psi)));
        kicky(counterTraj) = trapz(trapz(Vdy.*abs(psi).*abs(psi))) / trapz(trapz(abs(psi).*abs(psi)));
    end
         
end

textFileName = ['data_a0=' num2str(a0) '_wait_time=' num2str(waitTime) '_num_of_cycles=' num2str(parameter) '_.mat'];
save(textFileName);

end
