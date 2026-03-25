clear all
clc

%-------------------------------------------------------------------------%
%This function computes the optimal value of the correlation functions S_1,S_2 and S_3 the adaptive
%prepare-and-measure scenario using four-dimensional shared entanglement
%and a bit message

%Inputs:
% - d = 4: local dimension
% - nM = 2: message alphabet
% - nX: number of Alice's settings
% - nB: number of Bob's mesurement outputs
% - rho(d,d): shared entangled state
% - A(d,d,nM,nX): Alice' local measurements
% - B(d,d,nB,2): Bob's local adaptive measurements


nM = 2;
d = 2;

nX = 4;
nB = 4;



%%
%-------------------------------------------------------------------------%
%COEFFICIENTS of S_1: (nM,nX,nB) = (2,3,4)

cxb = [[2,0,0,1];
        [0,2,0,1];
        [0,0,2,1]]/4;

%%
%-------------------------------------------------------------------------%
%COEFFICIENTS of S_2:  (nM,nX,nB) = (2,4,4)

cxb = [[0,1,1,0];
       [1,0,1,0];
       [1,1,0,0];
       [0,0,0,1]]/3;


%%
%-------------------------------------------------------------------------%
%COEFFICIENTS associated of S_3 (nM,nX,nB) = (2,4,4) 

cxb =   [[2,0,1,0];
            [0,2,1,0];
            [0,0,1,1];
            [0,0,0,1]]/4;


%%
%Build objective function
%-------------------------------------------------------------------------%
obj = 0;
for x = 1:nX
    for b = 1:nB
        p{b,x} = 0;
        for m = 1:nM
            p{b,x} = p{b,x} + trace(Tensor(A(:,:,m,x),B(:,:,b,m))*rho);
        end
        obj = obj + cxb(x,b)*p{b,x};
    end
end
    

%-------------------------------------------------------------------------%
%Violation of inequality
S = obj