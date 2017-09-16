function [ derivadaprimera,derivadasegunda ] = FSderivada( a,b,R,pr,C,gd,fi,B,H,rebanadas,Met,Metodo )
% Esta funci�n calcula la derivada de un punto de la gr�fica FS(R)
% Inputs
% pr: Avance del radio de una iteraci�n a otra
% otras: idem a la funci�n FSP
% Outputs
% derivadaprimera: La derivada primera de la funci�n FS(R)
%


[ FSRjuntos(1)] = FSP( a,b,R-pr,C,gd,fi,B,H,rebanadas,Met,Metodo);
[ FSRjuntos(2)] = FSP( a,b,R,C,gd,fi,B,H,rebanadas,Met,Metodo);
[ FSRjuntos(3)] = FSP( a,b,R+pr,C,gd,fi,B,H,rebanadas,Met,Metodo);

     derivadaprimera= (FSRjuntos(3)-FSRjuntos(1))/(2*pr);
     derivadasegunda=(FSRjuntos(3)-2*FSRjuntos(2)+ FSRjuntos(1))/pr^2;
end

