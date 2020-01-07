function Zhang_Suen_ThinningMethod

% Input:    A Desired Imgae
% Output:   Skeletonized Image (saved in the mat-File named as "Output.mat")
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%  Author:  Shahab Eshghi Sahraei
%  PhD Student (Functional Morphology and Biomechanics)
%  Christian Albrecht's University(CAU) in Kiel, Germany
%  Email:   eshghi.shahab@gmail.com
%           sh.eshghi@zoologie.uni-kiel.de
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%  Version: 1.0  18/12/2019
%  Info:    Zhang-Suen Thinning Algorithm for skeletonization
clc
close all
[file,path] = uigetfile('*.*');
w= imread([path file]);
w= rgb2gray(w);
w= double(w)/255;
id1 = w>0.5  ;
id2 = w<=0.5 ;
s = size(w);
w(id1) = 0;
w(id2) = 1;
wOrg = w;
IdB = w==0;
sIdBlackOld = sum(sum(IdB));
e=2;
i=0;
while e~=0
    [w2,w3,w4,w5,w6,w7,w8,w9] = imBreakDown(w);
    B = w2+w3+w4+w5+w6+w7+w8+w9;
    id1 = B>=2 & B<=6;
    % (b) A( p1) =1
    id21 = (w2-w3) == -1;
    id22 = (w3-w4) == -1;
    id23 = (w4-w5) == -1;
    id24 = (w5-w6) == -1;
    id25 = (w6-w7) == -1;
    id26 = (w7-w8) == -1;
    id27 = (w8-w9) == -1;
    id28 = (w9-w2) == -1;
    A = id21+id22+id23+id24+id25+id26+id27+id28;
    id2 = A==1;
    if rem(i,2)==0
        % (c) P2*P4*P6 = 0
        C = w2.*w4.*w6;
        id3 = C==0;
        % (d) P4*P6*P8 = 0
        D = w4.*w6.*w8;
        id4 = D==0;
    else
        % (c) P2*P4*P6 = 0
        C = w2.*w4.*w8;
        id3 = C==0;
        % (d) P4*P6*P8 = 0
        D = w2.*w6.*w8;
        id4 = D==0;
    end
    idAll = id1.*id2.*id3.*id4;
    id = idAll==1;
    id = [zeros(1,s(2)-2); id ; zeros(1,s(2)-2)];   %#ok
    id = [zeros(s(1),1) id zeros(s(1),1)];          %#ok
    w (logical(id)) = 0;
    IdB = w==0;
    sIdBlack = sum(sum(IdB));
    e = sIdBlack-sIdBlackOld;
    sIdBlackOld = sIdBlack;
    i = i+1;
end
subplot(1,2,1)
imshow(wOrg)
subplot(1,2,2)
imshow(w)
save Output.mat w
end

function [w2,w3,w4,w5,w6,w7,w8,w9] = imBreakDown(w)

w2 = w(1:end-2,2:end-1);
w3 = w(1:end-2,3:end);
w4 = w(2:end-1,3:end);
w5 = w(3:end,3:end);
w6 = w(3:end,2:end-1);
w7 = w(3:end,1:end-2);
w8 = w(2:end-1,1:end-2);
w9 = w(1:end-2,1:end-2);
end



