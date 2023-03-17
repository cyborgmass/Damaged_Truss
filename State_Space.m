function acc = State_Space(stiffness,Mass,Damping,force)

n = size(stiffness,1); 
% State Transition Matrix
A = zeros(2*n);
A(1:n,n+1:2*n) = eye(n);
A(n+1:2*n,1:n) = -inv(Mass)*stiffness;
A(n+1:2*n,n+1:2*n) = -inv(Mass)*Damping;


% Excitation Localization Matrix
locator = zeros(n,1);
DOF = (1:2:25);
locator(DOF) = 1.0;
B = zeros(2*n,1);
B(n+1:2*n) = Mass\locator;

X0 = zeros(2*n,1);   % initial conditions
t = force(:,1);
ff = force(:,2);
[Y,X] = lsim(A,B,A,B,ff,t,X0);

% Acceleration at degree of freedom
acc=Y(:,n+1:2*n);

end