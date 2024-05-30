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

function [x,costo]=m_transporte(s,d,c);
% function [x,cost]=transporte(s,d,c)
%
% s = ofertas          (m*1)
% d = demanda          (n*1)
% c = costos           (m*n)
% x = solución óptima  (m*n)
% cost = costo de transporte mínimo

global vs us cuadro nb b2 c2 costo TITULUS TITULVS Calcular;
cost=[];

% Introducir b como una matriz con unos para las variables básicas
% y ceros para las variables no básicas.
%clc
disp(' La regla del noroeste da una solución básica inicial.');
disp(' Cuadro del transporte [x s;d'' 0]')
[x,b]=noroeste(s,d);
[x s;d' 0]
disp(' ')
costo_ini=num2str(sum(sum(c.*x)));
disp([' Costo de transporte = ',num2str(sum(sum(c.*x)))]);
disp(' ')
%%%%
[tamx,tamy]=size(x);
resultado(tamx,tamy);
%%%%
set(nb,'visible','off');
set(vs,'visible','off');
set(us,'visible','off');
set(TITULUS,'visible','off');
set(TITULVS,'visible','off');
vbc=0;%acumulador para imprimir
for i = 1:tamx
    for j = 1:tamy
        if (x(i,j)~=0)
            set(cuadro(i,j),'String',num2str(x(i,j)));
            vals1=sprintf('%d',x(i,j));
            vals2=sprintf('%d',c(i,j));
            vbas{i+j}=sprintf('X %d,%d = %s',i,j,vals1);
            mult=sprintf('%d',x(i,j)*c(i,j));
            cosbas{i+j}=sprintf('%s x %s = %s',vals1,vals2,mult);
        end
        set(costo(i,j),'String',num2str(c(i,j)));
    end

end
%%%%
tp=d';
for j = 1:tamy
    set(b2(1,j),'String',num2str(tp(1,j)));
end
%%%%
for i = 1:tamx
    set(c2(i,1),'String',num2str(s(i,1)));
end
%%%%
solbasica(vbas,cosbas,costo_ini);
%pause
waitfor(warndlg('Solución Básica Inicial...Precione (OK) para continuar','Cuadro de Transporte'));
iter=0;
while 1
    [u,v]=multiplicadores(x,c,b);
    disp(' Cuadro de costos [c u;v'' 0]');
    [c u;v' 0]
    %%%%%
    set(TITULUS,'visible','on');
    set(TITULVS,'visible','on');
    set(vs,'visible','on');
    set(us,'visible','on');
    %%%%%
    %%%%
    tk=v';
    for j = 1:tamy
        set(vs(1,j),'String',num2str(tk(1,j)));
    end
    %%%%
    for i = 1:tamx
        set(us(i,1),'String',num2str(u(i,1)));
    end
    %%%%

    %%%%%
    %pause
    waitfor(warndlg('Método de Multiplicadores Aplicado...Precione (OK) para continuar','Cuadro de Transporte'));
    disp(' ')
    disp(' Costos reducidos ')
    r=(c-u*ones(size(v'))-ones(size(u))*v')*(-1);
    %%%
    set(nb,'visible','off');
    %%%%
    for i = 1:tamx
        for j = 1:tamy
            if (r(i,j)~=0)
                set(nb(i,j),'visible','on');
                set(nb(i,j),'String',num2str(r(i,j)));
            end
        end
    end
    %%%%

    %%%
    if any(any(r<0))
        disp(' ')
        [maxv,i,j] = maspos(r);
        if(maxv==0)
            break
        end
    else
        break
    end;
    disp(' ')
    disp(' Cuadro del transporte [x s;d'' 0]');
    var_ent=sprintf('Entra X %d,%d con valor= %d',i,j,maxv);
    waitfor(warndlg(var_ent,'Variable más positiva que Entra'));
    [x,b]=ciclo(x,i,j,b);
    [x s;d' 0]
    %%%%
    for i = 1:tamx
        for j = 1:tamy
            if (b(i,j)==1)
                set(cuadro(i,j),'String',num2str(x(i,j)));
            else
                set(cuadro(i,j),'String','');
            end
        end
    end
    %%%%
    disp(' ')
    %pause
    waitfor(warndlg('Construcción de Ciclo Aplicado...Precione (OK) para continuar','Cuadro de Transporte'));
    cost=[cost ; sum(sum(c.*x))];
    fprintf('Costo de transporte = %g\n\n',cost(length(cost)));
    etiq=sprintf('Costo de Transporte = %g para la Iteración Nº %d',cost(length(cost)),iter+1);
    waitfor(warndlg(etiq,'Costo de Transporte'));
    cost_iter{iter+1}=sprintf('\n%d )- %d',iter+1,cost(length(cost)));
    iter=iter+1;
end
%%%%%
for i = 1:tamx
    for j = 1:tamy
        if (~isempty(get(cuadro(i,j),'String')))
            valsb1=sprintf('%d',x(i,j));
            valsb2=sprintf('%d',c(i,j));
            vbasc{j,i}=sprintf('X %d,%d = %s',i,j,valsb1);
            multb=sprintf('%d',x(i,j)*c(i,j));
            costbas{j,i}=sprintf('%s x %s = %s',valsb1,valsb2,multb);
        end
    end
end

%%%%%
disp(' ')
%pause
waitfor(warndlg('Cálculo Terminado...Precione (OK) para continuar','Cuadro de Transporte'));
fprintf('Costos de transporte para todas las iteraciones:\n');
cost
if(isempty(cost))
else
    solcosto(cost_iter,cost(length(cost)),vbasc,costbas);
end

set(Calcular,'enable','on');
