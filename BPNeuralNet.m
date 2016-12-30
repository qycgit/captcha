function [ netV,netW,netR,netA,trainE] = BPNeuralNet( x,y,v,w,r,a,eta,maxIte,targetE)
%[ netV,netW,netR,netA ]=BPNeuralNet(x,y,v,w,r,a,eta,maxIte,minE) 
%   Three-layer backpropagation neural network function.The activation
%   functions of hidden layer and output layer are sigmoid function.
%   x -- The input data;
%   y -- The real output data;
%   v -- The initial weight from input layer to hidden layer;
%   w -- The initial weight from hidden layer to output layer;
%   r -- The initial threshold of hidden layer;
%   a -- The initial threshold of output layer;
%   eta -- The learning rate;
%   maxIte -- The maximum number of iterations;
%   targetE -- Stop iterating when error less than minE ;
%   netV -- The weight from input layer to hidden layer after training;
%   netW -- The weight from hidden layer to output layer after training;
%   netR -- The bias of hidden layer after training;
%   netA -- The bias of output layer after training.
%   trainE -- The training error.
% 

n=size(x,1);
for i=1:maxIte
    for j=1:n
%    The forward phase
        x1=x(j,:)*v;
%     output of hidden layer
        y1=1./(1+exp(-(x1-r)));
        x2=y1*w;
%     output of output layer
        y2=1./(1+exp(-(x2-a)));
%     The backward phase, gradient descent 
        g=y2.*(1-y2).*(y(j,:)-y2);
        deltaW=eta*y1'*g;
        deltaA=-eta*g;
        h=y1.*(1-y1).*(w*g')';
        deltaV=eta*x(j,:)'*h;
        deltaR=-eta*h;
        w=w+deltaW;
        a=a+deltaA;
        v=v+deltaV;
        r=r+deltaR;
    end
    x1=x*v;
    y1=1./(1+exp(-(x1-r)));
    x2=y1*w;
    y2=1./(1+exp(-(x2-a)));
    trainE=mean(0.5*sum(((y-y2).^2),2));
    %prompt per 100 times
    if rem(i,100)==0
        disp(trainE);
        disp(i);
    end
%   if training error attains the target error, then return.
    if(trainE<=targetE)
        netV=v;
        netW=w;
        netR=r;
        netA=a;
        disp(['Taining error attains the target error, traning error is ',num2str(trainE),', iterate ',num2str(i),' times']);
        return;
    end
end
netV=v;
netW=w;
netR=r;
netA=a;
disp(['Attain the Maximum iteration,',' traning error is ',num2str(trainE)]);
end

