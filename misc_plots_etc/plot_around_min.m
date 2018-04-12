

factor=10;
a=estparam(1);
b=estparam(2);
c=estparam(3);
d=estparam(4);

gamma=c;
q=d;
for alpha=(2*a/3):(1/factor):(4*a/3)
for beta=(2*b/3):(1/factor):(4*b/3)
        proba(b,g)=minimise_function([alpha beta gamma q]);
end
end

figure;
surfc(proba)
xlabel('alpha');
ylabel('beta');
zlabel('-ve log likelihood');
set(gca,'YTickLabel',{'0';'0.25';'0.5';'0.75';'1'})
title('Negative log likelihood-alpha & b');