function [] = draw()


S.COL = [0 0 0];  % Start with blue.
S.fh = figure('units','pixels',...
    'position',[500 300 300 300],...
    'menubar','none',...
    'name','Diseñar Letra',...
    'numbertitle','off',...
    'resize','On');
S.ax = axes('units','pixels',...
    'position',[80 80 137 129],...
    'Xlim',[0 1],...
    'YLim',[0 1],...
    'drawmode','fast');
S.cm = uicontextmenu;
% Define the different color menus.
S.um(1) = uimenu(S.cm,'label','Color');  % First menu seen on right-click
S.um(2) = uimenu(S.um(1),'label','Black');
% This select from a palette.
S.um(3) = uimenu(S.um(1),'label','Other','callback',{@paletaColor});
% Now we create a menu for the figure itself.
S.fm = uimenu(S.fh,'label','Guardar y Evaluar');
S.mc = uimenu(S.fh,'label','Limpiar');
S.ff = uimenu(S.fh,'label','Explicar');


set(S.fm(1),'callback',{@SaveDraw})  % To save the drawing.
set(S.mc,'callback',{@clearMainGUI})
set(S.ff,'callback',{@Explica})



axis([0,1,0,1]) % This locks the axes limits to avoid auto-rescaling.
set(S.ax,'xticklabel',[],'yticklabel',[],'xtick',[],'ytick',[])  % Neaten.
% Set the uicontextmenu to point to the axes.
set(S.ax, 'buttondownfcn',@pencil,'uicontextmenu',S.cm)
hold on, box on  % So that we don't overwrite with each new point drawn.
set(S.fh,'windowbuttonupfcn', @stopDraw);

    function [] = pencil(varargin)
        % ButtonDownFcn for the axes.
        % We only want to do something if left clicking.
        if strcmp(get(S.fh,'selectiontype'),'normal')
            % We want to plot dots as long as user holds down mouse button.
            set(S.fh, 'windowbuttonmotionfcn', @pencilDetails)
        end
        
    end

    function [] = pencilDetails(varargin)
        % The windowbuttonmotionfcn for figure, while button is held only.
        pt = get(gca, 'currentpoint');
        plot(pt(2),pt(3),'.','MarkerSize',35,'buttondownfcn',@pencil,'color',S.COL);
    end

    function [] = stopDraw(varargin)
        % WindowButtonUpFcn for the figure.
        % We want to stop drawing dots when user lets mouse button up.
        set(S.fh, 'windowbuttonmotionfcn', '');
    end

    function [] = paletaColor(varargin)
        % Callback for the uicontextmenu number 2.
        c = uisetcolor();  % Call the MATLAB color-getter.
        S.COL = c;  % Set the current color.
    end

    function [] = SaveDraw(varargin)
        % Callback for the figure menu.
        N = inputdlg('Ingresa nombre de archivo','FileName'); % Get a name.
        W = entrenar2('batch.mat');
        F = getframe(S.fh,get(S.ax,'position'));  % Only want to get axes.
        FORMATO='png';
        imwrite(F.cdata,[N{1},'.',FORMATO],FORMATO)  % Write the image.
        letra=convertir([N{1},'.',FORMATO]);
        r=letra*W;
        bandera=true;
        k=1;
        while(bandera==true)
            bandera=false;
            if(r(k)<=0)
               bandera=true; 
               k=k+1;
            end
            if k==8
                bandera=false;
            end
        end
        switch k
            case 1
                msgbox('es una A');
                tts('HE DETECTADO QUE ES UNA AA');
            case 2
                msgbox('es una B');
                tts('HE DETECTADO QUE ES UNA B');
            case 3
                msgbox('es una C');
                tts('HE DETECTADO QUE ES UNA C');
            case 4
                msgbox('es una D');
                tts('HE DETECTADO QUE ES UNA D');
            case 5
                msgbox('es una E');
                tts('HE DETECTADO QUE ES UNA E');
            case 6
                msgbox('es una F');
                tts('HE DETECTADO QUE ES UNA F');
            case 7
                msgbox('es una G');
                tts('HE DETECTADO QUE ES UNA G');
            otherwise
                msgbox('NECESITO MAS ENTRENAMIENTO');
                tts('PARECE QUE NECESITO MAS ENTRENAMIENTO');
                
        end

%         if r(1)>0
%             msgbox('es una A');
%             tts('HE DETECTADO QUE ES UNA AA');
%         end
%         if r(2)>0
%             msgbox('es una B');
%             tts('HE DETECTADO QUE ES UNA B');
%         end
%         if r(3)>0
%             msgbox('es una C');
%             tts('HE DETECTADO QUE ES UNA C');
%         end
%         if r(4)>0
%             msgbox('es una D');
%             tts('HE DETECTADO QUE ES UNA D');
%         end
%         if r(5)>0
%             msgbox('es una E');
%             tts('HE DETECTADO QUE ES UNA E');
%         end
%         if r(6)>0
%             msgbox('es una F');
%             tts('HE DETECTADO QUE ES UNA F');
%         end
%         if r(7)>0
%             msgbox('es una G');
%             tts('HE DETECTADO QUE ES UNA G');
%         end
    end


    function [] = clearMainGUI(varargin)
        
        cla(S.ax);
        
    end
    function [] =Explica(varargin)
        tts('HOLA ME LLAMO OCR Y ESTOY AQUI PARA IDENTIFICAR LAS LETRAS QUE ME BRINDES');
        tts('HE ENTRENADO POR BASTANTE TIEMPO PARA PODER HACERLO');
    end
end



