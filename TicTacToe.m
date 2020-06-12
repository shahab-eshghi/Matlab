function TicTacToe
%%%%%%%%%%%%%%%%
% Developed by:  Shahab Eshghi
% PhD student, Kiel University, Germany
% Email: eshghi.shahab@gmail.com
%        sh.eshghi@zoologie.uni-kiel.de
% website: shahabeshghi.com
% github:  https://github.com/shahab-eshghi
%%%%%%%%%%%%%%%
close all
clc
hold on
fill([-1 -1 2 2 -1],[-1 2 2 -1 -1],[1 1 1],'edgecolor','k')
axis('off')
axis equal
title("'O' Turn",'fontsize',15,'fontweight','bold')
plot([-1 2],[0 0],'color',[0.5 0.5 0.5])
plot([-1 2],[1 1],'color',[0.5 0.5 0.5])
plot([0 0],[-1 2],'color',[0.5 0.5 0.5])
plot([1 1],[-1 2],'color',[0.5 0.5 0.5])
Player1= zeros(3);      % circle
Player2= zeros(3);      % cross
for i=1:9
    if mod(i,2)==1
        Turn = 1;
    else
        Turn = 2;
    end
    position=findPlace;
    drawSign(position,Turn)
    if Turn==1
        title("'X' Turn",'fontsize',15,'fontweight','bold')
        Player1(position) = 1;
        [win,line] = checkWinner(Player1);
        if win
            title("'O' is the winner",'fontsize',15,'fontweight','bold')
            hold on
            for j = 1: length(line)
                for k=1:30
                    plot(line{j}(1,1:k),line{j}(2,1:k),'k','linewidth',2,'marker','o','markersize',5)
                    pause(0.005)
                end
            end
            return
        end
    else
        title("'O' Turn",'fontsize',15,'fontweight','bold')
        Player2(position) = 1;
        [win,line]= checkWinner(Player2);
        if win
            title("'X' is the winner",'fontsize',15,'fontweight','bold')
            hold on
            for j = 1: length(line)
                for k=1:30
                    plot(line{j}(1,1:k),line{j}(2,1:k),'k','linewidth',2,'marker','o','markersize',5)
                    pause(0.005)
                end
            end
            return
        end
    end
end
title("No winner",'fontsize',15,'fontweight','bold')
end
function [win,line] = checkWinner(Player)
c=zeros(1,8);
c(1) = sum(Player(1,:));
c(2) = sum(Player(2,:));
c(3) = sum(Player(3,:));
c(4) = sum(Player(:,1));
c(5) = sum(Player(:,2));
c(6) = sum(Player(:,3));
c(7) = sum(diag(Player));
c(8) = sum(diag(Player(:,end:-1:1)));
line=0;
if sum(c==3)>=1
    win = 1;
    ID = find(c==3);
    line=cell(1,length(ID));
    for i=1:length(ID)
        id= ID(i);
        if id==1
            line{i} = [linspace(-1,2,30);ones(1,30)*1.5];
        elseif id==2
            line{i} = [linspace(-1,2,30);ones(1,30)*0.5];
        elseif id==3
            line{i} = [linspace(-1,2,30);ones(1,30)*-0.5];
        elseif id==4
            line{i} = [ones(1,30)*-0.5;linspace(2,-1,30)];
        elseif id==5
            line{i} = [ones(1,30)*0.5;linspace(2,-1,30)];
        elseif id==6
            line{i} = [ones(1,30)*1.5;linspace(2,-1,30)];
        elseif id ==7
            line{i} = [linspace(-1,2,30);linspace(2,-1,30)];
        elseif id ==8
            line{i} = [linspace(2,-1,30);linspace(2,-1,30)];
        end
    end
else
    win = 0;
end
win = logical(win);
end
function drawSign(Position,Turn)
t = linspace(0,2*pi);
x1=cos(t)*0.3;   y1=sin(t)*0.3;
p = [ -0.5 1.5 ; -0.5 0.5 ; -0.5 -0.5 ; 0.5 1.5 ; 0.5 0.5 ; 0.5 -0.5 ; 1.5 1.5 ; 1.5 0.5 ; 1.5 -0.5 ];
if Turn == 1
    plot(x1+p(Position,1),y1+p(Position,2),'b','linewidth',3)
else
    hold on
    plot([-0.3 0.3]+p(Position,1),[-0.3 0.3]+p(Position,2),'r','linewidth',3)
    plot([-0.3 0.3]+p(Position,1),[0.3 -0.3]+p(Position,2),'r','linewidth',3)
end
axis equal
end
function position=findPlace
p = ginput(1);
if p(1)>1
    if p(2)>1
        position = 7;
        return
    elseif p(2)>0
        position = 8;
        return
    else
        position = 9;
        return
    end
elseif p(1)>0
    if p(2)>1
        position = 4;
        return
    elseif p(2)>0
        position = 5;
        return
    else
        position = 6;
        return
    end
else
    if p(2)>1
        position = 1;
        return
    elseif p(2)>0
        position = 2;
        return
    else
        position = 3;
        return
    end
end
end