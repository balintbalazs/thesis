function entropy = entropyShannonSubTriangle(P,xh,yh)
	
    width = size(P,2);
    height = size(P,1);
    x = 1:width;
    y = 1:height;
    [X,Y] = meshgrid(x, y);

    Z = (X <= (xh - Y * xh / yh));

    P = P .* Z;
    P = P(:);
    entropy = -2 / (xh * yh) * sum(abs(P) .* abslog2(P));
    

	
end