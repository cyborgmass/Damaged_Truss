function [stiffness, Mass, Damping] = single_Damaged_Structure(el,d)

Es = 7e9;                               % Initial Elasticity of Elements 
rho = 2770;                             % Density

% Import coordinate of nodes
Nodes = load('node_coordinates.mat');
nodeCoordinates = Nodes.nodeCoordinates;

% Import Element node connectivity
Elements = load('element_nodes.mat');
elementNodes = Elements.elementNodes;

numberElements = size(elementNodes,1);  % Number of Elements
numberNodes = size(nodeCoordinates,1);  % Number of Elements

Area = repmat(0.05, numberElements,1);  % Area of elements

E = repmat(Es, numberElements,1);       % Elasticity

if ~isnan(el)
  E(el) = (1-d)*Es;                       % Set Damage to Specific Element
end

GDof = 2*numberNodes;                   % Number of Degree of Freedom

% calculate Stiffness-Mass-Damper matrix after damage to element 1
stiffness = formStiffness2Dtruss(GDof,numberElements,elementNodes,nodeCoordinates,E,Area);

% Compoute Mass Matrix of 2D Truss Sysytem (Lumped Mass Model)
Mass = formMass2Dtruss(GDof,numberElements,elementNodes,nodeCoordinates,rho,Area);

prescribedDof = [1 2 26]; % Boundary Condition (Supports of Truss) 

stiffness(prescribedDof,:) = [];
stiffness(:,prescribedDof) = [];

Mass(prescribedDof,:) = [];
Mass(:,prescribedDof) = [];

% Compute Proportional Damping Of Dynamic Linear System
Damping = 1.1*Mass + 0.00079*stiffness;

end