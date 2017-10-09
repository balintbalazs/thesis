function entropy = DCTS_perSlice(A,lOTFSupportX,lOTFSupportY)

entropy = zeros(1,size(A,3));
    for i = 1:size(A,3)
        slice = double(A(:,:,i));
        dSlice = dct2(slice);
        ndSlice = dSlice ./ norm2(dSlice);
        entropy(i) = entropyShannonSubTriangle(ndSlice, lOTFSupportX, lOTFSupportY);
    end
end
