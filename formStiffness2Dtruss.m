function [stiffness]=...
    formStiffness2Dtruss(GDof,numberElements,...
    elementNodes,nodeCoordinates,E,A)

stiffness = zeros(GDof);
% computation of the system stiffness matrix

for e=1:numberElements
    
    % elementDof: element degrees of freedom (Dof)
    indice = elementNodes(e,:);
    
    elementDof = [indice(1)*2-1 indice(1)*2 indice(2)*2-1 indice(2)*2] ;

    xx = nodeCoordinates(:,1);
    yy = nodeCoordinates(:,2);
    
    xa = xx(indice(2))-xx(indice(1));
    ya = yy(indice(2))-yy(indice(1));
    
    length_element = sqrt(xa*xa+ya*ya);
    
    C = xa/length_element;
    S = ya/length_element;
   
    k1 = E(e)*A(e)/length_element * [C*C C*S -C*C -C*S; 
                                     C*S S*S -C*S -S*S;
                                     -C*C -C*S C*C C*S;
                                    -C*S -S*S C*S S*S];

    stiffness(elementDof,elementDof) = stiffness(elementDof,elementDof)+k1;
end