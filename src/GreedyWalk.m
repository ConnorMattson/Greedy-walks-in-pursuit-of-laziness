function [pathRows, pathCols] = GreedyWalk(currentPosition, direction, elevationData, ~)
    % Finds the best path through an array for a particular starting
    % position, using the greedy algorithm
    % Input: A starting position, the direction (-1 for left, 1 for
    % right), and a matrix of the elevation data
    % Output: Two arrays, the y and x coordinates of each point
    % respectively
    % Author: Connor Mattson
    % Version: 1
    % Date: 25/08/2017
    % ENGGEN 131, Matlab Project
    
    % Analyse input
    elevationDataSize = size(elevationData);
    pathData = zeros(2,elevationDataSize(2));
    
    % Record the starting position
    pathData(:, 1) = [currentPosition(2); currentPosition(1)];

    % find the next best position and record it, set this position as the
    % starting position, and repeat until a full path is made
    for i = 2:elevationDataSize(2)
        newPosition = GreedyPick(currentPosition, direction, elevationData);
        pathData(:, i) = rot90(newPosition);
        currentPosition = newPosition;
    end
    
    % Format the recorded coordinates for output
    pathRows = pathData(1, :);
    pathCols = pathData(2, :);
end
        
        
        
        
        
        
        
        
        
        
        
        