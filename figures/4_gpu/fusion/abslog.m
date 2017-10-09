function B = abslog(A)
    A(A==0) = 1;
    B = log(double(abs(A)));
end