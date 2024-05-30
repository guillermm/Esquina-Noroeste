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

function balancear(opcion)

global a b c oferta demanda;

mas_demanda=0;
mas_oferta=0;

sum_b=0;
sum_c=0;
band_a=0;

if(opcion==1)

    [h,g] = size(a);
    for i = 1:h
        for j = 1:g
            x_a(i,j)=str2num( get( a(i,j) ,'String'));
        end
    end

    for k = 1:g
        x_b(1,k)=str2num( get( b(1,k) ,'String'));
        sum_b=sum_b+x_b(1,k);
    end

    for t = 1:h
        x_c(t,1)=str2num( get( c(t,1) ,'String'));
        sum_c=sum_c+x_c(t,1);
    end

    if sum_b~=sum_c
        
        if sum_b > sum_c
            
            mas_oferta=1;
            valbal=sum_b-sum_c;
            CLF(gcf);
            cuadro(oferta , demanda , mas_oferta, 0);
            band_a=1;
        end
         if sum_c > sum_b
           
            mas_demanda=1; 
            valbal=sum_c-sum_b;
            CLF(gcf);
            cuadro(oferta , demanda , 0, mas_demanda);
            band_a=2;
        end
    end

end


 

