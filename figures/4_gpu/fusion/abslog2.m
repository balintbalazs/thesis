function B = abslog2(A)
    A(A==0) = 1;
    B = log2(double(abs(A)));
end