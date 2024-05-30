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

function [u,v]=multiplicadores(x,c,b)
% [u,v]=multiplicadores(x,c,b)
% x: solución actual (m*n)
% b: 1 para cada variables básicas 0 para no básicas (m*n)
% c: costos (m*n)
% u: multiplicadores de lagrange para las filas (m*1)
% v: multiplicadores de lagrange para las columnas (n*1)
     
