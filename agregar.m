%*********************************************************  
%    Desarrollado por: Guillermo Montoya                 *
%                                                        *
%    e-mail: logicasoftware@yahoo.com                    *
%                                                        *
%                                                        *
%*********************************************************
%  Programa para la resolución del *  
%  Problema de Transporte de PL    *
%                                  *
%***********************************

function agregar(opcion)

global a b c oferta demanda;

Cx1='Agregar Ofertas...';
Cx2='Agregar Demandas...';
Cxa='Cantidad de Ofertas:';
Cxb='Cantidad de Demandas:';
mas_demanda=0;
mas_oferta=0;

if(opcion==1)

    resp_1=inputdlg({Cxa},Cx1,1,{'0'});
    if(size(resp_1)~=0)
        mas_oferta=str2num(char(resp_1(1)));
    end
    
    [h,g] = size(a);
    for i = 1:h
        for j = 1:g
            x_a(i,j)=str2num( get( a(i,j) ,'String'));
        end
    end

    for k = 1:g
     x_b(1,k)=str2num( get( b(1,k) ,'String'));
    end

    for t = 1:h
     x_c(t,1)=str2num( get( c(t,1) ,'String'));
    end

    CLF(gcf);
    cuadro(oferta , demanda , mas_oferta, 0);
end
if(opcion==2)
    
    resp_1=inputdlg({Cxb},Cx2,1,{'0'});
    if(size(resp_1)~=0)
        mas_demanda=str2num(char(resp_1(1)));
    end
    
    
    [h,g] = size(a);
    for i = 1:h
        for j = 1:g
            x_a(i,j)=str2num( get( a(i,j) ,'String'));
        end
    end

    for k = 1:g
     x_b(1,k)=str2num( get( b(1,k) ,'String'));
    end

    for t = 1:h
     x_c(t,1)=str2num( get( c(t,1) ,'String'));
    end

    
    CLF(gcf);
    cuadro(oferta , demanda , 0, mas_demanda);
end


[i_top,j_top]=size(a);
for i = 1:i_top-mas_oferta
    for j = 1:j_top-mas_demanda
        set(a(i,j),'String',x_a(i,j));%num2str(cz(i,j)
    end
end
for k = 1:j_top-mas_demanda
    set(b(1,k),'String',x_b(1,k));      
end

for t = 1:i_top-mas_oferta
    set(c(t,1),'String',x_c(t,1));     
end




