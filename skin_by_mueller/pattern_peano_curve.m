function [X, Y] = pattern_peano_curve(n)
% SUMMARY:
%       This function creates the original Peano curve after n iterations.
%       The function uses the Deterministic Iteation Algorithm for fractal
%       construction (it is given as a function below).
%           plot with: line(X,Y,'Color','b')
% INPUT:
%       n: number of iterations (order)
% OUTPUT:
%       X: vector with the x-coordinates of the points of the Peano curve
%       Y: vector with the y-coordinates of the points of the Peano curve
%   Created by www.mathstudies.eu

W=[ 1/3   0    0   1/3    0     0;
    -1/3   0    0   1/3   1/3   1/3;
    1/3   0    0   1/3    0    2/3;
    1/3   0    0  -1/3   1/3    1;
    -1/3   0    0  -1/3   2/3   2/3;
    1/3   0    0  -1/3   1/3   1/3;
    1/3   0    0   1/3   2/3    0;
    -1/3   0    0   1/3    1    1/3;
    1/3   0    0   1/3   2/3   2/3];
number_of_maps = length(W(:,1));
A0=[1/6   1/6;
    1/6   5/6;
    1/2   5/6;
    1/2   1/6;
    5/6   1/6;
    5/6   5/6
    ];

%with DIA
Pea=MYDIA_R2_fast(A0,W,number_of_maps,n);
X=Pea(:,1);
Y=Pea(:,2);
%    line(X,Y,'Color','b');
%    xlim([0,1]);




%A0 is the initial set represented by a Mx2 matrix
%N is the number of the mappings
%K is the number of iterations
%W is the matrix Nx6 containing the parameters of the mappings
%Each row (i) contains the 6 coefficients of the map w_i. a,b,c,s,d,e
%  /      \   /   \
%  |a    b|   | d |
%w=|      | + |   |
%  |c    s|   | e |
%  \      /   \  /
%The function returns the matrix FP N^K x 2!!!


    function B=MYDIA_R2_fast(A0,W,N,K)

        A=A0;
        [M,~]=size(A0);
        points=M;
        if (K==0)
            B = A0;
        end
        maps = length(W(:,1));

        for i=1:K % iterations
            B = zeros(points*N,2);
            for j=1:maps
                W_map = [W(j,1) W(j,2); W(j,3) W(j,4)]';
                Add_map = repmat([W(j,5) W(j,6)],points,1);
                B(1+(j-1)*points:j*points,:) = A*W_map + Add_map;
                %B(:,1+(j-1)*points:j*points) = bsxfun(@plus,W_map*A,[W(j,5); W(j,6)]);
            end
            points=M*N^i;
            if (i<K)
                A=B;
            end
        end
    end
end