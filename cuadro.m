%*********************************************************  
%    Desarrollado por: Guillermo Montoya                 *
%                                                        *
%    e-mail: logicasoftware@yahoo.com                    *
%                                                        *
%                                                        *
%*********************************************************
%  Programa de Optimización y Búsqueda  *
%  Optimización Clásica vs. Heurísticas *
%  Método de la Esquina Noroeste        *
%****************************************

function cuadro(n_ofe ,n_dem , m_ofe, m_dem)
%
%   entradas:
%             n_ofe: cantidad de ofertas
%             n_dem: cantidad de demandas
%             m_ofe: cantidad de nueva oferta
%             m_dem: cantidad de nueva demanda
%


global a b c band1 calculo Calcular oferta demanda;

oferta=n_ofe + m_ofe;
demanda=n_dem + m_dem;

arr_size = [oferta,demanda];

rz=zeros(oferta,demanda);
bz=zeros(1,demanda);
cz=zeros(oferta,1);

a=zeros(oferta,demanda);
b=zeros(1,demanda);
c=zeros(oferta,1);


if arr_size(2) < 2 & arr_size(1) < 2
    fig_dim = [arr_size(1)*25+150, 420];
else  
    fig_dim = [arr_size(1)*25+150, arr_size(2)*60+160]; %[y,x]
end

%-----------------------------------------------------
% DISEÑO DE LA INTERFACE
%------------------------------------------------------
whitebg([1 1 1]); % Coloca las letras en negro
set(gcf,'Name' ,'Transporte - Guillermo Montoya               - Versión: 1.0 Beta');
set(gcf,'MenuBar','none');
set(gcf,'Resize','off');
set(gcf,'NumberTitle','off');
set(gcf,'Units', 'pixels');
set(gcf,'position',[100 100 fig_dim(2) fig_dim(1)]);
set(gcf,'Color',[0 0.50 0.50]);


%%%%%%%%%%%%%%%%%%%%%
%  Matriz de costos
%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %border size
posx = bd_size+70; %posicion horizontal
posxb = posx;
posy = fig_dim(1)-50-bd_size;

%TITULO DE LOS COSTOS
TITULO1 = uicontrol(gcf,...
    'Style','text',...
    'BackgroundColor',[0.3 0.7 0.3],...
    'FontSize',8,'FontName','ARIAL',...
    'FontWeight','bold',...
    'ForegroundColor', [1 1 1],...
    'String','c o s t o s :',...
    'Units', 'pixels',...
    'Position',[posx posy+22 (55*demanda)-bd_size  15]);

for i = 1:arr_size(1)
    for j = 1:arr_size(2)
        a(i,j)=uicontrol('Style','edit','BackgroundColor',[1 1 0],'String',num2str(rz(i,j)),'unit','pixels','position', [posx posy 50 20]); %[posx posy 50 20]
        tol_a=sprintf(' X %d,%d ',i,j);
        set(a(i,j),'TooltipString',tol_a);
        posx = posx+50+bd_size;                                            %num2str(rz(i,j))
    end
    posx = posxb;
    posy = posy-20-bd_size;
end

%%%%%%%%%%%%%%%%%%%%%%%
%  Renglon de Demandas
%%%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %border size
posx_b = bd_size+70; %posicion horizontal
posxb_b = posx_b;
posy_b = posy-10-bd_size;%+posy

%TITULO DEL RENGLON DEMANDA
TITULO2 = uicontrol(gcf,...
    'Style','text',...
    'BackgroundColor',[0.3 0.7 0.3],...
    'FontSize',8,'FontName','ARIAL',...
    'FontWeight','bold',...
    'ForegroundColor', [1 1 1],...
    'String','Demandas:',...
    'Units', 'pixels',...
    'Position',[posx_b-65 posy_b 65 15]);

[xt_b,yt_b] = size(bz);
ren_dem_size = [1,yt_b];
for i = 1:ren_dem_size(1)
    for j = 1:ren_dem_size(2)
        b(i,j)=uicontrol('Style','edit','BackgroundColor',[1 1 1],'String',num2str(bz(i,j)),'unit','pixels','position', [posx_b posy_b 50 20]); %[posx posy 50 20]
        tol_b=sprintf('Demanda nº: %d',j);
        set(b(i,j),'TooltipString',tol_b);
        posx_b = posx_b+50+bd_size;              %num2str(rz(i,j))
    end
    posx_b = posxb_b;
    posy_b = posy_b-20-bd_size;
end


%%%%%%%%%%%%%%%%%%%%%%%
%  Columna de Ofertas
%%%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %border size
posx_c = posx+50*demanda+bd_size*demanda;%posx+(posx*yt_c)+(bd_size*yt_c); %posicion horizontal
posxb_c = posx_c;
posy_c = fig_dim(1)-50-bd_size;

%TITULO DE LA CCOLUMNA DE OFERTAS
TITULO3 = uicontrol(gcf,...
    'Style','text',...
    'BackgroundColor',[0.3 0.7 0.3],...
    'FontSize',8,'FontName','ARIAL',...
    'FontWeight','bold',...
    'ForegroundColor', [1 1 1],...
    'String','Ofertas:',...
    'Units', 'pixels',...
    'Position',[posx_c posy_c+22 50 15]);

[xt_c,yt_c] = size(cz);
col_ofer_size = [xt_c,1];
for i = 1:col_ofer_size(1)
    for j = 1:col_ofer_size(2)
        c(i,j)=uicontrol('Style','edit','BackgroundColor',[1 1 1],'String',num2str(cz(i,j)),'unit','pixels','position', [posx_c posy_c 50 20]); %[posx posy 50 20]
        tol_c=sprintf('Oferta nº: %d',i);
        set(c(i,j),'TooltipString',tol_c);
        posx_c = posx_c+50+bd_size;              %num2str(rz(i,j))
    end
    posx_c = posxb_c;
    posy_c = posy_c-20-bd_size;
end


%%%%%%%%%%%%%%%%%%%%%%%%%
%  Boton de Agregar fila Oferta
%%%%%%%%%%%%%%%%%%%%%%%%%
Addfil = uicontrol(gcf,...
   'Style','pushbutton',...
   'FontSize',8,'FontName','Arial',...
   'Units', 'pixels',...
   'Position',[posx_c-165 posy_c-55  105 20],...
   'String','Agregar Oferta',...
   'CallBack','agregar(1);');
 
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Boton de Calculo Colomna Demanda
%%%%%%%%%%%%%%%%%%%%%%%%%%%
Addcol = uicontrol(gcf,...
   'Style','pushbutton',...
   'FontSize',8,'FontName','Arial',...
   'Units', 'pixels',...
   'Position',[posx_c-55 posy_c-55  105 20],...
   'String','Agregar Demanda',...
   'CallBack',['agregar(2);']); 

% %%%%%%%%%%%%%%%%%%%%%%%%%
% %  Boton de Balancear 
% %%%%%%%%%%%%%%%%%%%%%%%%%
Balan = uicontrol(gcf,...
   'Style','pushbutton',...
   'FontSize',8,'FontName','Arial',...
   'Units', 'pixels',...
   'Position',[posx_c-165 posy_c-75  105 20],...
   'String','Balancear',...
   'CallBack','balancear(1);');


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Boton de Calculo Colomna Demanda
%%%%%%%%%%%%%%%%%%%%%%%%%%%
Salir = uicontrol(gcf,...
   'Style','pushbutton',...
   'FontSize',8,'FontName','Arial',...
   'Units', 'pixels',...
   'Position',[posx_c-55 posy_c-75  105 20],...
   'String','< Salir >..',...
   'CallBack', 'close;');    



%%%%%%%%%%%%%%%%%%%%%%%
%  Boton de Calculo
%%%%%%%%%%%%%%%%%%%%%%%
Calcular = uicontrol(gcf,...
    'Style','pushbutton',...
    'FontSize',8,'FontName','Arial',...
    'Units', 'pixels',...
    'Position',[posx_c posy_c-17  52 20],...
    'String','Calcular');%,...
  
 set(Calcular,'callback','calculo;');   
 
