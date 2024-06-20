function plot_cut_list_jpg(cut_list, name, filename)
% SUMMARY:
%       This function plots the given cut_list, i.e. shows us the pattern
%       of the cuts and saves it in an jpg-file in the "images" folder.
% INPUT:
%       cut_list: matrix with all the cuts. one cut is saved per row.
%       name: name of our problem/pattern
%       filename: name that the file should have

close
fig = figure('doublebuffer','off','Visible','Off','Position', [0 0 1500 1500],'DefaultAxesFontSize',18);

hold on
for i = 1:size(cut_list,1)
    x = [cut_list(i,1); cut_list(i,3)];
    y = [cut_list(i,2); cut_list(i,4)];
    % line(x,y,'LineWidth',3);
    plot(x, y, '-b', 'LineWidth', 1);
end
hold off

title(name,'fontsize',50);
%colormap(gray);
%caxis([0 1]);
%colorbar('off');
axis([0.0 1 0 1]);
f = getframe(gcf);

new_cdata = f.cdata;

close(fig);

fig = figure('doublebuffer','on','Visible','on');

close(fig);

ffilename = sprintf('images/%s_shape.jpg',filename);

imwrite(new_cdata, ffilename);

end