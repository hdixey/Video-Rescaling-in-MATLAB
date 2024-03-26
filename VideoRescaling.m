%% Video Rescaling in MATLAB

% Begin by clearing all.
clear, close all, clc

%% Setup
% Create a working folder to store the image sequence.
workingDir = 'C:\Users\b8037405\OneDrive - Newcastle University\Data\Image Downscaling\BDRT_HBT';
mkdir(workingDir,'images');

% Define output video name
OutputVidName = 'BDRT_HBT_1m';

% Define image resize factor
% ImgReSzFct = 1 / (Desired Resolution / Ground Sampling Distance)
ImgReSzFct = 0.048;

%% Create VideoReader
% Create a VideoReader to use for reading frames from the file.
SurfaceFlowVideo = VideoReader('DJI_0051.MP4');

%% Create the Image Sequence
% Loop through the video, reading each frame into a width-by-height-by-3
% array named img.
% Write out each image to a JPEG file with a name in the form imgN.jpg,
% where N is the frame number.

ii = 1;

while hasFrame(SurfaceFlowVideo)
   img = readFrame(SurfaceFlowVideo);
   filename = [sprintf('%04d',ii) '.jpg']; 
   % If the video will total more than 9999 frames, '%04d' will need to be
   % changed to '%05d'.
   fullname = fullfile(workingDir,'images',filename);
   
   % Convery frame to greyscale. 
   % By uncommenting the next line, the frames will be converted to
   % greyscale.
   % imgGrey = rgb2gray(img);
    
   % Resize Image
   imgReSz = imresize(img, ImgReSzFct);
   
   % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   imwrite(imgReSz,fullname)    
   ii = ii+1;
end

%% Find Image File Names
% Find all the JPEG file names in the images folder. Convert the set of image names to a cell array.
imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = {imageNames.name}';

%% Create New Video with the Image Sequence
% Construct a VideoWriter object, which creates a Motion-JPEG AVI file by default.
outputVideo = VideoWriter(fullfile(workingDir, OutputVidName));
outputVideo.FrameRate = SurfaceFlowVideo.FrameRate;
open(outputVideo)

% Loop through the image sequence, load each image, and then write it to the video.
for ii = 1:length(imageNames)
    img = imread(fullfile(workingDir,'images',imageNames{ii}));
    writeVideo(outputVideo,img)
end


%% Finalize the video file.

% Close Output Video
close(outputVideo)

% Display completion message.
disp('COMPLETED');
