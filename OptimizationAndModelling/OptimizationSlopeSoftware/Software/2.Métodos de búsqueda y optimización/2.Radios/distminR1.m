function [D,R2max,D1,D2,D3,zona]=distminR1(B,H,a,b)
% Esta funci�n calcula algunos par�metros �tiles para reducir el n�mero de
% iteraciones in�tiles.
% Inputs
% B,H: Base y altura del talud.
% a,b: Centro de la circunferencia.
% Outputs
% D: Distancia mas corta entre el centro y el talud.
% R2max: Radio m�ximo cuando b<H.
% D1: Distancia del centro al v�rtice izquierdo
% D2: Distancia perpendicular entre el centro y la recta k1
% D3: Distancia del centro al v�rtice derecho
% zona: Vector que contiene la zona en la que se encuentra el centro
%
%
%
% Variables necesarias
m=H/B;
beta=atand(m);
% 1) Matriz de transformaci�n de coordenadas
MTC=[cosd(beta) sind(beta);-sind(beta) cosd(beta)];
% 2) Vertice superior 
Vs=[sqrt(B^2+H^2); 0];
L=Vs(1,1);
% 3) Centro C'(a',b') en coordenadas OX'Y'
Cp=MTC*[a b]';
ap=Cp(1,1);
bp=Cp(2,1);
% 4) Localizaci�n de zonas (zona=[zona izquierda zona central zona derecha])
zona=[ap<=0 ap>0 && ap<L ap>=L]'; 
% 5)Calculo de distancias
D1=sqrt(a^2+b^2);
D2=bp;
D3=sqrt(((a-B)^2)+((b-H)^2));
Dvect=[D1 D2 D3];
% 6) Asignaci�n de la distancia segun la zona
D=Dvect*zona;
%7) Radio mazimo si b<H
R2max=-a+(b/m);
end