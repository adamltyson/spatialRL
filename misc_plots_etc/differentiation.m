
as=diff(logposterior);
asd=diff(as);

[maxA,ind] = min(asd(:));

[e1, e2, e3, e4] = ind2sub(size(asd),ind)