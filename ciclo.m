%*********************************************************  
%    Desarrollado por: Guillermo Montoya                 *
%                                                        *
%    e-mail: logicasoftware@yahoo.com                    *
%                                                        *
%                                                        *
%*********************************************************
%  Programa para la resolución del *  
%  Problema de Transporte de PL    *
%  Método de la Esquina Noroeste   *
%***********************************

function [y,nueva_basicas]=ciclo(x,fila,col,b)
% [y,nueva_basicas]=ciclo(x,fila,col)
% x: solución actual (m*n)
% b: variables básicas que entran (m*n)
% fila,col: índice para la base del elemento que entra
% y: solución después del ciclo del cambio  (m*n)
% nueva_basicas: nuevas variables básicas después del ciclo del cambio  (m*n)
%

nueva_basicas=b;
y=x;
[m,n]=size(x);
lazo=[fila col]; % describe el ciclo del cambio 
x(fila,col)=Inf; % no incluir (fila, columna) en la búsqueda
b(fila,col)=Inf;
busca_fila=1;    % comenzar a buscar en la misma fila 
while (lazo(1,1)~=fila | lazo(1,2)~=col | length(lazo)==2),
  if busca_fila, % búsqueda en fila 
    j=1;
    while busca_fila 
       if (b(lazo(1,1),j)~=0) & (j~=lazo(1,2))  
         lazo=[lazo(1,1) j ;lazo]; % agregar los índices del elemento encontrado al lazo
         busca_fila=0;  % comenzar a buscar en columnas 
       elseif j==n,    % ningún elemento que se interese en esta fila
         b(lazo(1,1),lazo(1,2))=0;
         lazo=lazo(2:length(lazo),:); % retrocede
         busca_fila=0;
       else
         j=j+1; 
       end
    end
  else  % búsqueda de la columna
    i=1;
    while ~busca_fila
       if (b(i,lazo(1,2))~=0) & (i~=lazo(1,1)) 
         lazo=[i lazo(1,2) ; lazo];
         busca_fila=1;
       elseif i==m
         b(lazo(1,1),lazo(1,2))=0;
         lazo=lazo(2:length(lazo),:);
         busca_fila=1;
       else
         i=i+1;
       end
     end
  end
end
% cálculo máximo - lazo de envío 
l=length(lazo);
val_tmp=Inf;
menor_val=Inf;
for i=2:2:l
 if x(lazo(i,1),lazo(i,2))<val_tmp,
  val_tmp=x(lazo(i,1),lazo(i,2));
  menor_val=i;
 end;
end
% cálculo de nueva matriz de transporte
y(fila,col)=val_tmp;
for i=2:l-1
  y(lazo(i,1),lazo(i,2))=y(lazo(i,1),lazo(i,2))+(-1)^(i-1)*val_tmp;
end
nueva_basicas(fila,col)=1;
nueva_basicas(lazo(menor_val,1),lazo(menor_val,2))=0;
