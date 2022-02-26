function METs = k2METs(ks)
METs = [];
[m,n] = size(ks);

if m>n
    ks = ks';
end

for k = ks
    if k >=-0.04
        METs = [METs, -97.1290-72.62/(k-0.7)];
    else
        METs = [METs, 1];
    end
end
end