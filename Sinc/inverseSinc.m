function I = inverseSinc(x)
    maxx = max(x);
    minx = abs(min(x));
    if(maxx>minx)
        I = x;
    elseif(maxx<minx)
        I = -x;
    end

end