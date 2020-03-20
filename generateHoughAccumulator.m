function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
    
    %needs to be integer valued 
    num_rho = int64(2* rho_num_bins); %We want -rho to rho
    num_thetas = theta_num_bins; %we set the number of thetas 
    
    d_theta = 180 / theta_num_bins;
    
    %Hough accumulator array of theta vs rho
    accumulator = zeros(num_thetas, num_rho);
    
    % (row, col) indexes to edges
     [y_idxs, x_idxs] = find(img);
     
     for i = 1:numel(x_idxs)
         for t_idx = 1:num_thetas
             theta = d_theta*t_idx;
             %polar coordinates plus the diagonal length
             rho = round(x_idxs(i)*sind(theta)-y_idxs(i)*cosd(theta)) + rho_num_bins; 
             %equation in general from notes not line specific section
             %equation explained in readme file 
             %rho = round(x_idxs(i)*cosd(theta)+y_idxs(i)*sind(theta)) + int64(rho_num_bins);
             
             accumulator(t_idx,rho) = accumulator(t_idx,rho) + 1;
             
         end
     end
     
    accumulator = (accumulator - min(min(accumulator))) *255 / max(max(accumulator));
    hough_img = accumulator;
    hough_img(hough_img<0) = 0;
    
end
