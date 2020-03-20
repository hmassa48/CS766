function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
    
    %we need to find size of both original and hough
    [len_theta,len_rho] = size(hough_img);
    [height, width] = size(orig_img);
    
    %main diagonal length rho and then steps in rho
    diag_len = sqrt(height^2 + width^2);
    drho =  2*diag_len/(len_rho-1);
    
    %steps in theta 
    dtheta = 180/ len_theta;
    
    %set up figure to draw on 
    fh = figure; imshow(orig_img);
    hold on;
    
    for theta = 1 : len_theta
        for rho = 1 : len_rho
            if (hough_img(theta, rho) > hough_threshold) %use thresholding method 
                %get theta and rho values
                test_theta = theta * dtheta; %test each step of theta
                test_rho = drho* (rho - len_rho/2); %test each step of rho
                
                %convert back to cartesian coordinates
                %equations explained in the read me file 
                x = 1 : height;
                m = sind(test_theta) / cosd(test_theta);
                b = test_rho / cosd(test_theta);
                y = m*x + b;
                x = 1 : height;
                y = x * tand(test_theta) + test_rho * secd(test_theta);
                
                %plot the line
                plot(y, x, 'Color', 'g', 'LineWidth', 1);
            end
        end
    end
    
    line_detected_img = saveAnnotatedImg(fh);
end
