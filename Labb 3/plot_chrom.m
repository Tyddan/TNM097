function plot_chrom(XYZ,col)

%Plots the chromaticity diagram for the XYZ. The CIEXYZ values of each
%primary are supposed to be put in each column of XYZ.
%col is a string specifying the color of the graph.

%the first part is to plot the horse shoe plot 
load xyz;

x=xyz(:,1)./(xyz(:,1)+xyz(:,2)+xyz(:,3));
y=xyz(:,2)./(xyz(:,1)+xyz(:,2)+xyz(:,3));

plot(x,y)
hold on

%your code from here

x=XYZ(1,:)./sum(XYZ);
y=XYZ(2,:)./sum(XYZ);

plot([x,x(1)],[y,y(1)],col)