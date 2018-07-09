function [elevations, totalCost] = FindPathElevationsAndCost(pathRows, pathCols, elevationData)
    % Given a path and a matrix of elevation data, returns the elevation of
    % each point in the path and the path's total cost
    % Input: The rows in the path, the columns in the path and a matrix of
    % the elevation data
    % Output: Each coordinate's elevation and the path's total cost
    % Author: Connor Mattson
    % Version: 1
    % Date: 25/08/2017
    % ENGGEN 131, Matlab Project
    
    
    
    
%     for i = 1:length(pathRows)
%         elevations(i) = elevationData(pathRows(i), pathCols(i));
%     end
    

    rawElevations = elevationData(pathRows, pathCols);
    % Uses a logical indentity matrix to 
    elevations = rot90(rawElevations(logical(eye(length(pathRows)))));
    
    
    
    
    totalCost = sum(elevations);
end






