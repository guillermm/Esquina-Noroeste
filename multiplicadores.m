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

function [u,v]=multiplicadores(x,c,b)
% [u,v]=multiplicadores(x,c,b)
% x: soluci�n actual (m*n)
% b: 1 para cada variables b�sicas 0 para no b�sicas (m*n)
% c: costos (m*n)
% u: multiplicadores de lagrange para las filas (m*1)
% v: multiplicadores de lagrange para las columnas (n*1)
     
