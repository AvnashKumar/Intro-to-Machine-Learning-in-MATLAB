function Xnew= fun1rgb(X)
Xnew=[];
 for i = 1:length(X)
    CurrImage = imread(fullfile(X(i).folder, X(i).name));
    os=size(CurrImage);
    im=imresize(CurrImage,[64 64]);
    size(im);
    reshapedImage = reshape(im,1,64*64*3);
    size(reshapedImage);
    Xnew(i,:) = reshapedImage;
 end

 %Adding one column of ones in X
 Xnew = [ones(size(Xnew,1), 1) Xnew];

end