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

function [x,b]=noroeste(s,d)
% [x,b]=noroeste(s,d)
% x: envíos usando noroeste-regla (m*n)
% b: 1 para cada variables básicas 0 para no básica (m*n)
% s: ofertas  (m*1)
% d: demandas (n*1)
%

if (sum(s)~=sum(d)), 
  disp('ERROR: El total de la oferta no es igual al total de la demanda.');
  return; 
end
m=length(s);
n=length(d);
i=1;
j=1;
x=zeros(m,n);
b=zeros(m,n);

