
# Choose an image first.
% im = rgb2gray(imread("~/Downloads/Emory_test.jpg"))
im = rgb2gray(imread("./Linear-Algebra-Cartoon.png"))
[U,S,V] = svd(im);
subplot(1,3,1)
% Show all eigenvalues.
plot(diag(S),"linewidth",40,"color", "red")
set(gca,"linewidth", 20,"fontsize",40)
title("Singular Values of the image")
set(gca,'Color','k')
subplot(1,3,2)
% Show original image
imagesc(im)
title("Original image")
set(gca,"linewidth", 20,"fontsize",40)
set(gca,'Color','k')
subplot(1,3,3)
imagesc(U*S*V')
title("Compressed image")
set(gca,"linewidth", 20,"fontsize",40)

# Fix a threshold and filter the diagonal matrix
threshold=600
subplot(1,3,1)
plot(diag(S.*(S>threshold)),"linewidth",40,"color","red")
set(gca,"linewidth", 20,"fontsize",40)
title(strcat("top: ",int2str(sum(sum(S>threshold)))," with threshold: ", int2str(threshold)))
set(gca,'Color','k')
subplot(1,3,2)
imagesc(im)
title("Original image")
set(gca,"linewidth", 20,"fontsize",40)
subplot(1,3,3)
imagesc(U*(S.*(S>threshold))*V')
title("Compressed image")
set(gca,"linewidth", 20,"fontsize",40)

# Pick out the top modes
top=100
subplot(1,3,1)
plot(diag(S(1:top,1:top)),"linewidth",40,"color","red")
set(gca,"linewidth", 20,"fontsize",40)
title(strcat("top~ ",int2str(top), " Singular Values"))
set(gca,'Color','k')
subplot(1,3,2)
imagesc(im)
title("Original image")
set(gca,"linewidth", 20,"fontsize",40)
subplot(1,3,3)
imagesc(U(:,1:top)*S(1:top,1:top)*V(:,1:top)')
title("Compressed image")
set(gca,"linewidth", 20,"fontsize",40)

# The following is to save image files for slides presentation.
for top = [3,10,36,100]
    subplot(1,3,1)
    plot(diag(S(1:top,1:top)),"linewidth",20,"color","red")
    set(gca,"linewidth", 10,"fontsize",10)
    title(strcat("top~ ",int2str(top), " Singular Values"))
    set(gca,'Color','k')
    subplot(1,3,2)
    imagesc(im)
    title("Original image")
    set(gca,"linewidth", 10,"fontsize",10)
    subplot(1,3,3)
    imagesc(U(:,1:top)*S(1:top,1:top)*V(:,1:top)')
    title("Compressed image")
    set(gca,"linewidth", 10,"fontsize",10)
    print("-tight", strcat("Svd-ImageCompression-top",int2str(top),".png"))
endfor
