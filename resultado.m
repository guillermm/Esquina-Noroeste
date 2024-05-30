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

function resultado(n_ofe ,n_dem)
%
%  Entrada:
%          n_ofer: cantidad de ofertas 
%          n_dem: cantidad de demandas
%
%
%%%%%%%%---------
global vs us cuadro nb b2 c2 costo TITULUS TITULVS band1 calculo Calcular oferta demanda;


oferta=n_ofe;
demanda=n_dem;

arr_size = [oferta,demanda];

rz=zeros(oferta,demanda);
bz=zeros(1,demanda);
cz=zeros(oferta,1);

a=zeros(oferta,demanda);
b=zeros(1,demanda);
c=zeros(oferta,1);


if arr_size(2) < 2
    fig_dim = [arr_size(1)*25+400, 650];
else  
    fig_dim = [arr_size(1)*25+400, arr_size(2)*60+360]; 
end

%-----------------------------------------------------
% DISEÑO DE LA INTERFACE
%------------------------------------------------------
t2=figure;
whitebg([1 1 1]); % Coloca las letras en negro
set(gcf,'Name' ,'Resultado:.');
set(gcf,'MenuBar','none');
set(gcf,'Resize','off');
set(gcf,'NumberTitle','off');
set(gcf,'Units', 'pixels');
set(gcf,'position',[2 2 fig_dim(2) fig_dim(1)]);
set(gcf,'Color',[0 0.50 0.50]);



%%%%%%%%%%%%%%%%%%%%%%%
%  Renglon de Vs
%%%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %borde size
posx_b = bd_size+100; %posicion horizontal
posxb_b = posx_b;
posy_b = fig_dim(1)-80-bd_size;

[xt_b,yt_b] = size(bz);
ren_dem_size = [1,yt_b];

for j = 1:ren_dem_size(2)
    vs(1,j)=uicontrol('Style','edit','BackgroundColor',[1 1 1],'String','','unit','pixels','position', [posx_b posy_b 80 30]);
    tol_b=sprintf('V%d:',j);
    set(vs(1,j),'TooltipString',tol_b);
    %%
    TITULVS(1,j) = uicontrol(gcf,'Style','text','BackgroundColor',[0.3 0.7 0.3],'FontSize',10,'FontName','ARIAL','FontWeight','bold','ForegroundColor', [1 1 1],...
      'String',tol_b,'Units', 'pixels','Position',[posx_b posy_b+30 80 15]);
    %%
    posx_b = posx_b+70+bd_size;              
end


%%%%%%%%%%%%%%%%%%%%%%%
%  Columna de Us
%%%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %borde size
posx_c = bd_size+500;
posxb_c = posx_c;
posy_c = fig_dim(1)-150-bd_size;


[xt_c,yt_c] = size(cz);
col_ofer_size = [xt_c,1];
for i = 1:col_ofer_size(1)
    us(i,1)=uicontrol('Style','edit','BackgroundColor',[1 1 1],'String','','unit','pixels','position', [posx_c-475 posy_c 70 30]); 
    tol_c=sprintf('U%d:',i);
    set(us(i,1),'TooltipString',tol_c);
    TITULUS(i,1) = uicontrol(gcf,'Style','text','BackgroundColor',[0.3 0.7 0.3],'FontSize',10,'FontName','ARIAL','FontWeight','bold','ForegroundColor', [1 1 1],...
      'String',tol_c,'Units', 'pixels','Position',[posx_c-475 posy_c+30 70 15]);
    %%
    posx_c = posxb_c;
    posy_c = posy_c-45-bd_size;
end



%%%%%%%%%%%%%%%%%%%%%
%  Matriz de asignacion
%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %borde size
posx = bd_size+100; %posicion horizontal
posxb = posx;
posy = fig_dim(1)-150-bd_size;



for i = 1:arr_size(1)
    for j = 1:arr_size(2)                                                                                                      
        cuadro(i,j)=uicontrol('Style','edit','BackgroundColor',[0.75 0.75 0.75],'String','','unit','pixels','ForegroundColor',[0.25 0.25 1] ,'HorizontalAlignment','center','position', [posx posy 80 50]); 
        tol_a=sprintf(' X %d,%d ',i,j);
        set(cuadro(i,j),'TooltipString',tol_a);
        posx = posx+70+bd_size;                                            
    end
    posx = posxb;
    posy = posy-45-bd_size;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%  Matriz de variables no basicas
%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %borde size
posx = bd_size+100; %posicion horizontal
posxb = posx;
posy = fig_dim(1)-150-bd_size;

for i = 1:arr_size(1)
    for j = 1:arr_size(2)
        nb(i,j)=uicontrol('Style','edit','BackgroundColor',[1 1 1],'String','','unit','pixels','ForegroundColor',[1 0.25 0.25] ,'HorizontalAlignment','center','position', [posx posy 55 15]); 
        tol_a=sprintf(' X %d,%d ',i,j);
        set(nb(i,j),'TooltipString',tol_a);
        posx = posx+70+bd_size;                                            
    end
    posx = posxb;
    posy = posy-45-bd_size;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%  Matriz de costos
%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %borde size
posxc = bd_size+100; %posicion horizontal
posxbc = posxc;
posyc = fig_dim(1)-150-bd_size;

for i = 1:arr_size(1)
    for j = 1:arr_size(2)
        costo(i,j)=uicontrol('Style','edit','BackgroundColor',[1 1 0],'String','','unit','pixels','ForegroundColor',[0 0 0] ,'HorizontalAlignment','center','position', [posxc+23 posyc+34 55 15]);
        tol_a=sprintf(' X %d,%d ',i,j);
        set(costo(i,j),'TooltipString',tol_a);
        posxc = posxc+70+bd_size;                                            
    end
    posxc = posxbc;
    posyc = posyc-45-bd_size;
end



%%%%%%%%%%%%%%%%%%%%%%%
%  Renglon de Demandas
%%%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %borde size
posx_b = bd_size+100; %posicion horizontal
posxb_b = posx_b;
posy_b = posy-10-bd_size;

%TITULO DEL RENGLON DEMANDA
TITULO2 = uicontrol(gcf,...
    'Style','text',...
    'BackgroundColor',[0.3 0.7 0.3],...ojo
    'FontSize',8,'FontName','ARIAL',...
    'FontWeight','bold',...
    'ForegroundColor', [1 1 1],...ojo
    'String','Demandas:',...
    'Units', 'pixels',...
    'Position',[posx_b-65 posy_b 65 25]);

[xt_b,yt_b] = size(bz);
ren_dem_size = [1,yt_b];
for i = 1:ren_dem_size(1)
    for j = 1:ren_dem_size(2)
        b2(i,j)=uicontrol('Style','edit','BackgroundColor',[1 1 1],'String',num2str(bz(i,j)),'unit','pixels','position', [posx_b posy_b 80 30]);
        tol_b=sprintf('Demanda nº: %d',j);
        set(b2(i,j),'TooltipString',tol_b);
        posx_b = posx_b+70+bd_size;              
    end
    posx_b = posxb_b;
    posy_b = posy_b-25-bd_size;
end


%%%%%%%%%%%%%%%%%%%%%%%
%  Columna de Ofertas
%%%%%%%%%%%%%%%%%%%%%%%
bd_size = 5; %borde size
posx_c = posx+75*demanda+bd_size*demanda;
posxb_c = posx_c;
posy_c = fig_dim(1)-150-bd_size;

%TITULO DE LA COLUMNA DE OFERTAS
TITULO3 = uicontrol(gcf,...
    'Style','text',...
    'BackgroundColor',[0.3 0.7 0.3],...
    'FontSize',8,'FontName','ARIAL',...
    'FontWeight','bold',...
    'ForegroundColor', [1 1 1],...
    'String','Ofertas:',...
    'Units', 'pixels',...
    'Position',[posx_c posy_c+50 80 15]);

[xt_c,yt_c] = size(cz);
col_ofer_size = [xt_c,1];
for i = 1:col_ofer_size(1)
    for j = 1:col_ofer_size(2)
        c2(i,j)=uicontrol('Style','edit','BackgroundColor',[1 1 1],'String',num2str(cz(i,j)),'unit','pixels','position', [posx_c posy_c 80 50]); 
        tol_c=sprintf('Oferta nº: %d',i);
        set(c2(i,j),'TooltipString',tol_c);
        posx_c = posx_c+70+bd_size;              
    end
    posx_c = posxb_c;
    posy_c = posy_c-45-bd_size;
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Boton de Salir
%%%%%%%%%%%%%%%%%%%%%%%%%%%
Salir = uicontrol(gcf,...
   'Style','pushbutton',...
   'FontSize',8,'FontName','Arial',...
   'Units', 'pixels',...
   'Position',[posx_c posy_c-17  80 30],...
   'String','< Salir >..',...
   'CallBack', 'close;');    


