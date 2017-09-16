
% Generamos una grafica 3D para ver la distribuci�n de los minimos
puntosa=linspace(a1,a2,pa+1);
puntosb=linspace(b1,b2,pb+1);
for i=1:length(puntosb)
    A3D(i,:)=puntosa;
end

for j=1:length(puntosa)
    B3D(:,j)=puntosb;
end

figure(1)
surfc(A3D,B3D,FS3D)
title('Distribuci�n de FS ','FontName','Arial','FontSize', 14);
xlabel('Centro a(m)','FontName','Arial','FontSize', 14);
ylabel('Centro b(m)','FontName','Arial','FontSize', 14);
zlabel('FS','FontName','Arial','FontSize', 14);

figure(2)
contourf(FS3D)
title('Lineas de contorno del FS ','FontName','Arial','FontSize', 14);
xlabel('Centro a(m)','FontName','Arial','FontSize', 14);
ylabel('Centro b(m)','FontName','Arial','FontSize', 14);

figure(3)
pcolor(A3D,B3D,FS3D)
title('Distribuci�n en color del FS  ','FontName','Arial','FontSize', 14);
xlabel('Centro a(m)','FontName','Arial','FontSize', 14);
ylabel('Centro b(m)','FontName','Arial','FontSize', 14);


