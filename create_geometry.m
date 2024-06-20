function [model, dl] = create_geometry(model, cut_list, cs)
% SUMMARY:
%       This function creates the geometry and adds it to the model 
%       container, which tells us where we have which shapes we need to
%       construct our pattern.
% INPUT:
%       model: model of our PDE (here structural and static-planestress)
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       cs: corner size, i.e. how far the corner can be stretched in
% OUTPUT:
%       model: model of our PDE containing the geometry
%       dl: geometry matrix

% these are the points of the boundary where we have diferent line segments
% (is needed so we can stretch and the corners are fine). there are 12
% points.
geom_outer_edges = [0, 0;
    cs, 0;
    1-cs, 0;
    1, 0;
    1, cs;
    1, 1-cs;
    1, 1;
    1-cs, 1;
    cs, 1;
    0, 1;
    0, 1-cs;
    0, cs];

cut_count = size(cut_list,1);
% allocate space for our geometry description matrix
% note: gd is a geometry desciption matrix. Each column corresponds to a
% shape. First row tells us what kind of shape (2 for polygon, 3 for
% rectangle) and the second row tells us how many line segments (here
% for polygon 12, for rectangle 4). The following rows contain first
% the x-coordinates of the edge-points and then the corresponding
% y-coordinates.
gd = zeros(26,cut_count+1);
% this is the outer edge of our geometry
gd(:,1) = [2; 12; geom_outer_edges(:)];

sf = 'R001'; % set formula
ns = char(nan(cut_count+1,0)); % allocate space for namespace matrix
ns(1,1:4) = char('R001');

%now add the inner rectangles for the cuts.
for i = 1:cut_count
    % adds a rectangle (for a cut) to the geometry description matrix, i.e.
    % 4 points. Each cut should be 2*0.001 wide.
    gd(1:10,i+1) = generate_cut(cut_list(i,:), 0.001);
    % to specify the name of the shape
    cut_name = sprintf('C%03d',i);
    % add '-...' to the set formula. this tells us that we want to
    % take the set difference for the inner cuts, i.e. want there to be a
    % hole.
    sf = strcat(sf,'-',cut_name);
    ns(i+1,1:numel(cut_name)) = cut_name;
end

% decomposes the geometry description matrix gd into the geometry matrix dl
% and returns the minimal regions that satisfy the set formula sf
[dl,bt] = decsg(gd,sf,ns');
% this deletes all boundaries between subdomains
[dl,~] = csgdel(dl,bt);

% adds the 2-D geometry described in dl to the model container
geometryFromEdges(model, dl);

end