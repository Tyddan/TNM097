function plot_chrom_sRGB(XYZ)

%Plots the chromaticity diagram for the XYZ. The CIEXYZ values of each
%primary are supposed to be put in each column of XYZ.
%col is a string specifying the color of the graph.

%the first part is to plot the horse shoe plot 
load xyz;

x=xyz(:,1)./(xyz(:,1)+xyz(:,2)+xyz(:,3));
y=xyz(:,2)./(xyz(:,1)+xyz(:,2)+xyz(:,3));
plot(x,y)
hold on
xsRGB=[0.64,0.3,0.15];
ysRGB=[0.33,0.6,0.06];
plot([xsRGB,xsRGB(1)],[ysRGB,ysRGB(1)],'k')

%your code from here

x=XYZ(1,:)./sum(XYZ);
y=XYZ(2,:)./sum(XYZ);

plot([x,x(1)],[y,y(1)],'b')



