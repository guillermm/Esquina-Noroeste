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

function [maxv,fil,col] = maspos(vargin);
%Esta función encuentra el valor máximo 
%y la posición (fila, columna) de la matriz de entrada
%
% Salida: maxv valor máximo de la matriz de entrada
%         fil  fila donde existe el valor máximo
%         col  columna donde existe el valor máximo
%

dim = size(vargin);
if length(dim)~=2
    error('Matriz Inválida!');
end

maxv=0;
fil=0;
col=0;


% maxv valor máximo de la matriz de entrada
maxv = max(vargin(:));
if(maxv>0)
    % find: encuentra el valor máximo y la posición de la matriz de entrada 
    % 1 indica que encotrara un solo valor el primero que encuentre
    [fil,col] = find(vargin==maxv,1);
end
