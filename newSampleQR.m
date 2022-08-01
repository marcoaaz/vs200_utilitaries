%written by Marco Acevedo Z., QUT. 2-Aug-2022
%modified by

close all;
clear
clc

workingDir = 'C:\Users\n10832084\Alienware_March 22\current work\encode_qr';
cd(workingDir)

generatorPath = fullfile(workingDir, 'qr_code_JensRichter');
addpath(generatorPath)
% qrcode_gen('DownloadJars',1); %run once

%%

fileName = 'VS200 ASW_v2.xlsx';
sampleList = readtable(fileName, 'Sheet', 'newSamples', 'NumHeaderLines', 1, 'VariableNamingRule', 'preserve');

str1 = string(sampleList.("Slide Barcode"));
str2 = sampleList.("Slide Name");
str3 = sampleList.Description;
str4 = sampleList.("Rock type");
str5 = sampleList.("Geological environment");
str6 = sampleList.Literature;
str7 = sampleList.Preparation;
str8 = string(sampleList.("Date sent"));

infoStr = strcat(str1, ';', str2, ';', str3, ';', str4, ';', ...
    str5, ';', str6, ';', str7, ';', str8);

%% Saving QR codes

from= 8; %modify depending on the samples of interest
to=12;

N=25;
sizeQR = 17+4*N;

destDir = 'qrFigures';
mkdir(destDir)

infoStr1 = infoStr(from:to); %rows
n_slides = length(infoStr1);

barCode = str1(from:to);
for i = 1:n_slides
    
    %help qrcode_gen    
    qr = qrcode_gen(infoStr1{i}, 'CharacterSet', 'UTF-8', ...
        'ErrQuality','H', 'Version', 10, 'QuietZone', 12); % Returns a matrix
    %, 'Size',[sizeQR, sizeQR] %version has priority

    qr2 = uint8(rescale(qr, 0, 255));
    
    imageName = strcat('slide_', barCode(i), '.png');
    imwrite(qr2, fullfile(destDir, imageName));

end
% msg = readBarcode(img_test, '2D');


%% Older readers

path3 = 'C:\Users\n10832084\OneDrive - Queensland University of Technology\Desktop\encode_qr';
javaaddpath(fullfile(path3, 'core.jar'))
javaaddpath(fullfile(path3, 'javase.jar'))

qr = encode_qr(test(1), [31, 31]);
 figure,
 imshow(qr, [], 'InitialMagnification',1600)

 img = imread('test.jpeg');
 img2 = imresize(img, 0.1);
 message = decode_qr(img2);