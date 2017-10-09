function n = norm2(A)
    n = sqrt(sum(A(:) .* A(:)));
end