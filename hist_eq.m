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
comp_arr=arr';  %transpose of the array

sorted_arr=sort(comp_arr); %sort array in ascending order
unique_arr=unique(sorted_arr); %gives only single occurrence of an element
zero_arr=zeros(1,length(unique_arr)); %array of zeros having length equal to unique_arr
var_1=1; count=0;

for j=1:1:length(E)
    for k=1:1:length(sorted_arr)
        if E(1,j)==sorted_arr(1,k)
            count=count+1;
            k=k+1;
            continue
        end
    end
         zero_arr(1,var_1)=count;
         var_1=var_1+1;
         count=0;
end
comp_E=E'; comp_zero_arr=zero_arr'; cdf=cumsum(comp_zero_arr); val_cdf=[comp_E cdf];

[rows,cols] = size(gray_image);
L=256;
cdf_min=cdf(1,1);
hv=[];
for i=1:length(comp_E)
    intermediate=round(((cdf(i,1)-cdf_min)/((rows*cols)-cdf_min))*(L-1));
    hv=[hv intermediate];
end
final_hv=hv';
final_mat=[val_cdf hv'];

copy_arr=zeros(rows*cols,1);
for j=1:length(final_mat)
    for i=1:length(arr)
        if arr(i,1)==final_mat(j,1)
            copy_arr(i,1)=final_mat(j,3);
        end
    end
end

final_mat=uint8(vec2mat(copy_arr',cols));

figure;
final_img=uint8(final_mat);
imshow(final_img);
