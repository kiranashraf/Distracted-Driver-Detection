function ll =  llfun(act, pred)
    epsilon = 1e-15;
    pred = max(epsilon, pred)
    pred = min(1-epsilon, pred)
    ll = sum(act.*log(pred) + minus(1,act).*log(minus(1,pred)))
    ll = ll * -1.0/length(act)
    end

