function [FS,lambda] = mMorgPri( x,y_talud_med,y_circ_med,alfa ,pasovector,gd,C,fi )
% Esta funci�n calcula el FS por el m�todo de Morgenstern-Price
% Inputs
% y_talud_med,y_circ_med,alfa,pasovector: Outputs de la funci�n parametros
% Outputs
% gd: Peso especifico del terreno
% C: Cohesi�n efectica del terreno
% fi: Angulo de rozamiento del terreno
% Outputs
% FS: Factor de seguridad por el m�todo de Morgenstern-Price
% lambda: Factor de correcci�n lambda
%
%
%
%
% Calculo de R,T
altura=y_talud_med-y_circ_med;
area=pasovector.*altura;
W=gd*area;
% R
N=W.*cosd(alfa);
rozamiento=N*tand(fi);
cohesion=C*pasovector.*secd(alfa);
R=rozamiento+cohesion;
% T
T=W.*sind(alfa);
% Elecci�n de f(x)
for mu=1:1:2  %0-5
    for uve=0.5:0.5:2 %0.5-2  
aa=x(1); 
bb=x(end);
argumento=pi*(((x-aa)/(bb-aa)).^uve);
medioseno=(sin(argumento)).^mu;  
f=medioseno;  %f(1)=f0,f(2)=f1,f(i)=fi-1,f(n)=f(n-1)
% Si se quiere plotear la funcuion activar este modulo
%plot(x,f);
% axis([aa bb 0 1.1])

% Metodo para Fi,Psi, Factor de seguridad
[FS,lambda] = ZhuLeeChen(alfa ,pasovector,fi,R,T,f);
% 5) Escogemos el �ltimo puesto como representante
        FS=FS(end); % Nos quedamos con el �ltimo FS
if isnan(FS)==0
    break
end
    end
end   
end

    

