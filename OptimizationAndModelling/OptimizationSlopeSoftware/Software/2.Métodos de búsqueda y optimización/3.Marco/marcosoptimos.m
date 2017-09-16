function [FSRabmin,FRab,npmt,et,p,npt] = marcosoptimos(ca,cb,l1,pn,fe,C,PT,gd,fi,B,H,rebanadas,Met,Metodo )
% Esta funci�n calcula el m�nimo FS asociado a un talud aplicando t�cnicas
% de optimizaci�n.
% Inputs
% ca,cb: punto alrededor del cual se dibujar� un marco cuadrado
% l1: mitad del largo de cada lado de cuadrado
% pn : precisi�n final con la que se quiere dar el resultado
% fe: factor de ensanchamiento a aplicar a los marcos sucesivos
% Resto de variables: ver funcion FSP
% Outputs
% FSRabmin: Es el factor de seguridad m�nimo global.
% Resto de variable: Ver memoria descriptiva
%
%
%
%
pregunta=questdlg('�Desea  dibujar los marcos?','SALIR','Si','No','No'); 
if strcmp(pregunta,'Si') 
dibujarmarco=1;
else
dibujarmarco=0;
end
% Calculamos los par�metros de optimizaci�n
po=l1/2;
et=round(log(po/pn)); % n�mero de etapas o marcos optimo
% Definimos el vector p=(p1,p2...pet)
p=0*(1:et-1); % Restamos 1 porque el �ltimo el primero son dato
    for q=1:et-1
        p(q)=nthroot((pn^q)*po^(et-q),et);
    end
p=[po p pn]; % Conjunto de pasos optimo
npt=round(2*fe*nthroot((po/pn),et)+1);% El n�mero de puntos a repartir en cada tramo ser�
pa=npt;pb=npt;
%
repeticiones=0; % Esta variable informar� las veces que se tuvo que repetir una operaci�n porque el centro qued� en el borde
hold on
for q=1:et
a1=ca-fe*p(q);
a2=ca+fe*p(q);
b1=cb-fe*p(q);
b2=cb+fe*p(q);
        if dibujarmarco==1
            hold on
            vp=[a1 b1];vf=[a2 b2];
            rectangulo
            rectang(q)=plot([a1,a2,a2,a1,a1],[b1,b1,b2,b2,b1]);   
        end      
   [FSRabmin] = Rastreo(a1,a2,b1,b2,pa,pb,C,PT,gd,fi,B,H,rebanadas,Met,Metodo );
        if isnan(FSRabmin(1,1))        
            return
        end
   % El centro encontrado no puede estar en el borde
   w=0;
  while FSRabmin(3)==a1 || FSRabmin(3)==a2 || FSRabmin(4)==b1 || FSRabmin(4)==b2
      w=w+1;
      if w>10
          break
      end
        a1=FSRabmin(3)-fe*p(q); 
        a2=FSRabmin(3)+fe*p(q);
        b1=FSRabmin(4)-fe*p(q);
        b2=FSRabmin(4)+fe*p(q);
        repeticiones=repeticiones+1;
             if dibujarmarco==1
                 hold on
                vp=[a1 b1];vf=[a2 b2];
                rectangulo
                 rectang(q+repeticiones)=plot([a1,a2,a2,a1,a1],[b1,b1,b2,b2,b1],'g');
             end
        [FSRabmin] = Rastreo(a1,a2,b1,b2,pa,pb,C,PT,gd,fi,B,H,rebanadas,Met,Metodo );
        if isnan(FSRabmin(1,1))        
            continue
        end 
   end
   % Asignamos los nuevos centros sobre los que dibujar el marco
   ca=FSRabmin(3);
   cb=FSRabmin(4); 
 % Guardamos todos los valores en un vector
   FRab(q,:)=FSRabmin;
end
npmt=(et+repeticiones)*(npt+1)^2; % Calculamos el n�mero total de simulaciones
end

