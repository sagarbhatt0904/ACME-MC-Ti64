%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code to get temperature field for MC analysis from transient NXsimulation
% author: sagar bhatt
% email: bhatts8@rpi.edu
% date:  August 6, 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;

% physical dimensions
dimX=2.5;
dimY=12;
% size of MC grid
ny=25;
nx=ny*(dimY/dimX)
nMCS=1000;
nSample=25; % number of temp readings for each coordinate
r = floor(nMCS/nSample); % factor to increase the sample rate

data=csvread('tempFieldTi64SampleTransient.csv');
N=max(data(:,1));
nodeCoord=data(:,2:4);
tempField=data(:,5:29);
maxZ=max(nodeCoord(:,3));


k=1;
for i=1:N
    if (nodeCoord(i,1)>=0)&&(nodeCoord(i,1)<=12)
        if nodeCoord(i,3)==maxZ
            nodesCoord2D(k,:)=[nodeCoord(i,1),nodeCoord(i,2)];
            tempField2D(k,:)=tempField(i,:);
            k=k+1;
        end
    end
end

tempStructuredGrid=zeros(25,ny,nx);
for i=1:25
siT=scatteredInterpolant(nodesCoord2D(:,1),nodesCoord2D(:,2),tempField2D(:,i));

x=linspace(0,12,nx);
y=linspace(-1.25,1.25,ny);
[x,y]=meshgrid(x,y);
tempStructuredGrid(i,:,:)=siT(x,y);

% clf;
% tri=delaunay(x,y);
% s=trisurf(tri,x,y,tempStructuredGrid(i,:,:));
%  view([0 0 1]);
% cb = colorbar(); colormap('jet'); 
% caxis([26.85 1200]);
% axis equal;
% % title('MC Grid');
% title(cb,'{^o}C');
% xlabel('x');
% ylabel('y');
% drawnow;
end
tempStructuredGridMCS=zeros(nMCS,nx,ny);

for i=1:nx
    for j=1:ny
        tempStructuredGridMCS(:,i,j)=interp(tempStructuredGrid(:,j,i),r);
    end
end


% axis([0,12,-1.1,1.1]);

% dlmwrite('~/Desktop/tempStructuredGridMCS.txt',tempStructuredGridMCS,'delimiter',' ','precision',12)
% fileID=fopen('~/Desktop/tempStructuredGridMCS.bin','w');
% fwrite(fileID,tempStructuredGridMCS);
hdf5write('tempStructuredGridMCS.h5', '/temp/', tempStructuredGridMCS);