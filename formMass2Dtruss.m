function [Mass]=formMass2Dtruss(GDof,numberElements,elementNodes,nodeCoordinates,rho,A)
Mass = zeros(GDof);

for e = 1:numberElements
    indice=elementNodes(e,:);

    elementDof = [indice(1)*2-1 indice(1)*2 indice(2)*2-1 indice(2)*2] ;
    xx = nodeCoordinates(:,1);
    yy = nodeCoordinates(:,2);
    
    xa = xx(indice(2))-xx(indice(1));
    ya = yy(indice(2))-yy(indice(1));
    
    length_element = sqrt(xa*xa+ya*ya);

    Mass(elementDof,elementDof) = Mass(elementDof,elementDof) + (rho*A(e)*length_element/2)*eye(4);
                                                                                           
                                                                                          
end

end

