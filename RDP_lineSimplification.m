function RDP_lineSimplification

% Input:    X, Y and epsilon
% Output:   Simplified line points
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%  Author:  Shahab Eshghi Sahraei
%  PhD Student (Functional Morphology and Biomechanics)
%  Christian Albrecht's University(CAU) in Kiel, Germany
%  Email:   eshghi.shahab@gmail.com
%           sh.eshghi@zoologie.uni-kiel.de
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%  Version: 1.0  5/12/2019
%  Info:    Ramer-Douglas-Peucker Line Simplification Algorithm

close all
clc

global allPoints
X = linspace(0,20*pi);
Y = sin(X)./X;
epsilon = 0.1;
id= isnan(Y);
X(id) = [];
Y(id) = [];
H = zeros(1,length(X));
for i = 1 : length(X)
    H(i)=findHight([X(1) X(i) X(end)],[Y(1) Y(i) Y(end)]);
end
epsilon =epsilon*(max(max(H)));
allPoints = [X' Y'];
plot(X,Y,'b-','linewidth',2)
hold on
fPid = [1 length(X)]; %Final Points ID
n = 2;
e=1;
while e~=0
    newPoints = [];
    for i=1:length(fPid)-1
        hID=findPoint(fPid(i),fPid(i+1),epsilon);
        newPoints =[newPoints hID]; %#ok
    end
    fPid = [fPid newPoints];    %#ok
    fPid = sort(fPid);
    e = abs(length(fPid)-n);
    n = length(fPid);
end
plot(X(fPid),Y(fPid),'ro','linewidth',2,'markersize',10)

xSMP = X(fPid);
ySMP = Y(fPid);

save Output.mat xSMP ySMP

end
function hID=findPoint(idP1,idP2,epsilon)
global allPoints
CPs = idP1+1 : idP2-1;
H = zeros(1,length(CPs));
for i = 1 : length(CPs)
    H(i)=findHight([allPoints(idP1,1) allPoints(CPs(i),1) allPoints(idP2,1)],[allPoints(idP1,2) allPoints(CPs(i),2) allPoints(idP2,2)]);
end
if ~isempty(H) && max(max(H))>epsilon
    [~,id] = max(H);
    hID = CPs(id(1));
else
    hID = [];
end
end
function H=findHight(X,Y)
% X is a 1 by 3 matrix
% Y is a 1 by 3 matrix
X = [X X(1)];
Y = [Y Y(1)];
A = (sum(X(1:end-1).*Y(2:end))-sum(X(2:end).*Y(1:end-1)))/2;
d = sqrt(((X(3)-X(1))^2)+((Y(3)-Y(1))^2));
H = 2*A/d;
H = abs(H);
end






