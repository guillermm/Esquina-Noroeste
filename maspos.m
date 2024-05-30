%*********************************************************  
%    Desarrollado por: Guillermo Montoya                 *
%                                                        *
%    e-mail: logicasoftware@yahoo.com                    *
%                                                        *
%                                                        *
%*********************************************************
%  Programa para la resoluci�n del *  
%  Problema de Transporte de PL    *
%  M�todo de la Esquina Noroeste   *
%***********************************

function [maxv,fil,col] = maspos(vargin);
%Esta funci�n encuentra el valor m�ximo 
%y la posici�n (fila, columna) de la matriz de entrada
%
% Salida: maxv valor m�ximo de la matriz de entrada
%         fil  fila donde existe el valor m�ximo
%         col  columna donde existe el valor m�ximo
%

dim = size(vargin);
if length(dim)~=2
    error('Matriz Inv�lida!');
end

maxv=0;
fil=0;
col=0;


% maxv valor m�ximo de la matriz de entrada
maxv = max(vargin(:));
if(maxv>0)
    % find: encuentra el valor m�ximo y la posici�n de la matriz de entrada 
    % 1 indica que encotrara un solo valor el primero que encuentre
    [fil,col] = find(vargin==maxv,1);
end
