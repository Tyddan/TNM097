function out=mysnr(in,noise)

out=10*log10(sum(in.^2)/sum(noise.^2));