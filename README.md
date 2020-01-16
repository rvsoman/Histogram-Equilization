# Histogram-Equilization
% date-5/1/2020; Renuka Soman; 
% to do histogram equilisation of an image and display it

% %A=[52 55 61 59 79 61 76 61;62 59 55 104 94 85 59 71;63 65 66 113 144 104 63 72;64 70 70 126 154 109 71 69;67 73 68 106 122 88 68 68 ;68 79 60 70 77 66 58 75;69 85 64 58 55 61 65 83; 70 87 69 68 65 73 78 90];

clc;clear all;close all;
ip=input('enter name of image');
image=imread(ip); %to get the input image
figure;
imshow(image);
gray_image=rgb2gray(image);  %converting original image to grayscale
figure;
imshow(uint8(gray_image)); %modifying image array to 8 bit unsigned integer form
arr=gray_image'; %transpose of the modified image matrix
arr=arr(:);  %converting matrix to array
trans_arr=arr';  %transpose of the array

sorted_arr=sort(trans_arr); %sort array in ascending order
unique_arr=unique(sorted_arr); %gives only single occurrence of an element
zero_arr=zeros(1,length(unique_arr)); %array of zeros having length equal to unique_arr
var_1=1; count=0;

for j=1:1:length(unique_arr)
    for k=1:1:length(sorted_arr)
        if unique_arr(1,j)==sorted_arr(1,k)
            count=count+1;       %getting the count of all unigue elements from original array         
            k=k+1; 
            continue
        end
    end
         zero_arr(1,var_1)=count;
         var_1=var_1+1;
         count=0;
end
trans_unique_arr=unique_arr'; %gives values of pixel intensities
trans_zero_arr=zero_arr'; 
cdf=cumsum(trans_zero_arr);   %cdf of the count of pixel intensity
val_cdf=[trans_unique_arr cdf];  %appending the pixel intensity and cdf arrays

[rows,cols] = size(gray_image); %rows and columns of the image
L=256;
cdf_min=cdf(1,1);  %minimum value in cdf array 
hv=[];
for i=1:length(trans_unique_arr)
    intermediate=round(((cdf(i,1)-cdf_min)/((rows*cols)-cdf_min))*(L-1));
    hv=[hv intermediate];
end
final_hv=hv'; %equalised values
pixel_cdf_hv=[val_cdf hv'];  %the matrix of pixel values, cdf and equalised values

copy_arr=zeros(rows*cols,1); %array of zeros of length equal to rows*columns of image
for j=1:length(pixel_cdf_hv)
    for i=1:length(arr)
        if arr(i,1)==pixel_cdf_hv(j,1)
            copy_arr(i,1)=pixel_cdf_hv(j,3); %replacing original image array with equalised values
        end
    end
end

final_mat=uint8(vec2mat(copy_arr',cols)); %converting the array to matrix 

figure;
final_img=uint8(final_mat); 
imshow(final_img);  %displaying final equalised image
