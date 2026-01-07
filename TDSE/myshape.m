function shape = myshape(nu,tau,maxT,tauOm,omega)
% Laser pulse shape

    eps = 1e-8;

    shape = heaviside(nu+20*tau) .* heaviside(-nu+tau*maxT/2) .* exp(-2*log(2).*(nu/tau - maxT/2).*(nu/tau - maxT/2)) .* sin(omega * nu);
    shape = shape + heaviside(nu-(tau*maxT/2+eps)) .* heaviside(-nu+tau*(maxT/2)+tauOm+2*eps) .* sin(omega * nu);
    shape = shape + heaviside(nu-(3*eps+tau*(maxT/2)+tauOm)) .* heaviside(-nu+(eps+tau*(maxT/2)+tauOm+20*tau)) .* exp(-2*log(2).*(nu/tau - (3*eps+tau*(maxT/2)+tauOm)/tau).*(nu/tau - (3*eps+tau*(maxT/2)+tauOm)/tau)) .* sin(omega .* nu);

end
