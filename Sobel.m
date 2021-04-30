I= imread('\TestImageMorphological\d1.jpg');

G = imresize(I, [480 640]);

H = rgb2gray(G);


H1 = edge(H, 'sobel');
H1 = double(H1); %Converting it to double
H1 = conv2(H1, [1 1:1 1]);

%figure
%imshow(H1);

se1 = strel('line',1, 0); %Structuring Element of shape line
sr2 = strel('line',1,90);

H2 = imdilate(H1, sr2); %Dilating to give proper structure
H2 = imdilate(H2, se1);

H2 = imfill(H2, 'holes'); %Filling holes if present

H2 = bwareaopen(H2, 100);
H2 = imclearborder(H2, 8);
se = strel('disk',1); %Structuring element of radius 1

H3 = imerode(H2, se); %Erosion using the above structural element
H4 = imerode(H3, se);

%size(H)
%size(H4)

H4 = H4(:,2:641);
H4 = medfilt2(H4); %Filtering the Noice present

%figure
%imshow(H4);

H4 = immultiply(H4, H);
imshow(H4);
level = graythresh(H4);
H4 = im2bw(H4, level); %Coverting RGB image to Black and White
H4 = bwareaopen(H4, 100);
H4 = ~H4; %Inverting the pixel values present in the matrix

%imshow(H4);

H4 = bwareaopen(H4, 100);

%figure
%imshow(H4);

I2=regionprops(H4,'BoundingBox','Image');

for i = 1:length(I2)
   s = 'segment';
 %   s1 = 'Images\';
    s = strcat(s, int2str(i));
    %s1 = strcat(s1,s);
    figure('name', s)
    s = strcat(s,'.jpg');
    imshow(I2(i).Image)
    %imwrite(Iprops(i).Image, s,'jpg');
    % Above command will save the created Images
end