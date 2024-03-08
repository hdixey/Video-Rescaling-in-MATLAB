# Video-Rescaling-in-MATLAB
Rescales video by a numerical factor.

This was orignially used to rescale UAS video for performing large scale image velocimetry. As such, the resoluton/Ground Sampling Distance could be downscaled to resemble that of commercial satellite imagery.

The script essentially works by reading a video and splitting it into individual frames, resizing those frames by a numerical factor, before stitiching the frames back together at their original frame rate.
