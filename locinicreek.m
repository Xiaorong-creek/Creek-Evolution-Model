function [y_grid,x_grid] = locinicreek(m,n,point)
 
 x_grid=[];y_grid=[];
 a=length(m); b=length(n); c=size(point,1);
   
for i=1:a-1
    m1(i)=(m(i)+m(i+1))/2;
end

for j=1:b-1
    n1(j)=(n(j)+n(j+1))/2;
end

for i=1:c
x_grid_tmp = find(m1 <= point(i,1), 1, 'last');
y_grid_tmp = find(n1 <= point(i,2), 1, 'last');
x_grid=[x_grid x_grid_tmp];
y_grid=[y_grid y_grid_tmp];
end

x_grid = x_grid+1;
y_grid = y_grid+1;

end