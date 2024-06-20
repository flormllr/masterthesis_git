function [model, dl] = create_geometry_stretch_everywhere(model, cut_list)
% SUMMARY:
%       This function creates the geometry and adds it to the model 
%       container, which tells us where we have which shapes we need to
%       construct our pattern.
%       This is a special version where we don't have edges around the
%       corner where we don't pull. Here we pull along the entire edges of
%       the domain.
% INPUT:
%       model: model of our PDE (here structural and static-planestress)
%       cut_list: matrix with all the cuts. one cut is saved per row.
% OUTPUT:
%       model: model of our PDE containing the geometry
%       dl: geometry matrix

geom_outer_edges = [0, 0; 1, 0; 1, 1; 0, 1];
cut_count = size(cut_list,1);

gd = zeros(10,cut_count+1);
% this is the outer edge of our geometry
gd(:,1) = [3; 4; geom_outer_edges(:)];
sf = 'R001'; % set formula
ns = char(nan(cut_count+1,0)); % allocate space for namespace matrix
ns(1,1:4) = char('R001');

% now add the inner rectangles for the cuts.
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