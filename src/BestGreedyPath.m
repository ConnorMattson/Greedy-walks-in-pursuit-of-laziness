function [finalRows, finalCols, finalElevations] = BestGreedyPath(elevationData)
% Given elevation data, finds the best greedy path originating at any
% point, if multiple paths have the best cost, the first path
% discovered is returned.
% Input: A matrix containing elevation data
% Output: the rows, columns, and elevations for the best greedy path.
% Author: Connor Mattson
% Version: 1
% Date: 25/08/2017
% ENGGEN 131, Matlab Project

bestCostSoFar = -1;
sizeOfElevationData = size(elevationData);
% Loop for each column
for i = 1:sizeOfElevationData(2)
    % Loop for each value within the column
    for j = 1:sizeOfElevationData(1)
        % If this is the first or last column (if it is, then there is
        % only one direction that the path can take).
        if i == 1 || i == sizeOfElevationData(2)
            % Sets direction = -1 if i == sizeOfElevationData(2)
            direction = mod(i, sizeOfElevationData(2)) * 2 - 1;
            [pathRows, pathCols] = GreedyWalk([j, i], direction, ...
                elevationData, sizeOfElevationData);
            
            % An inline version of FindPathElevationsAndCost (to reduce
            % function call overhead). Finds the elevations and total
            % cost of the calculated path
            elevations = zeros(1, length(pathRows));
            totalCost = 0;
            % Find the first elevation (since cost requires i-1)
            elevations(1) = elevationData(pathRows(1), pathCols(1));
            for k = 2:length(pathRows)
                temp = elevationData(pathRows(k), pathCols(k));
                elevations(k) = temp;
                totalCost = totalCost + (abs(temp-elevations(k-1)));
            end
            
            % If this is not the first or last column and the path could go
            % in either direction.
        else
            [pathRowsLeft, pathColsLeft] = GreedyWalk([j, i], -1, ...
                elevationData, sizeOfElevationData);
            % flips pathRowsLeft and pathColsLeft because for some
            % reason GreedyWalk wants them to be reversed  ¯\_(?)_/¯
            pathRowsLeft = pathRowsLeft(end:-1:1);
            pathColsLeft = pathColsLeft(end:-1:1);
            [pathRowsRight, pathColsRight] = GreedyWalk([j, i], 1, ...
                elevationData, sizeOfElevationData);
            % Combines the left and right paths
            pathRows = [pathRowsLeft pathRowsRight(2:end)];
            pathCols = [pathColsLeft pathColsRight(2:end)];
            
            % An inline version of FindPathElevationsAndCost (to reduce
            % function call overhead). Finds the elevations and total
            % cost of the calculated path
            elevations = zeros(1, length(pathRows));
            totalCost = 0;
            % Find the first elevation (since cost requires i-1)
            elevations(1) = elevationData(pathRows(1), pathCols(1));
            for k = 2:length(pathRows)
                temp = elevationData(pathRows(k), pathCols(k));
                elevations(k) = temp;
                totalCost = totalCost + (abs(temp-elevations(k-1)));
            end
        end
        
        % If a better path has already been found, discards the data; if
        % not, saves the data.
        if (totalCost < bestCostSoFar) || (bestCostSoFar == -1)
            [finalRows, finalCols, finalElevations, bestCostSoFar] =...
                deal(pathRows, pathCols, elevations, totalCost);
        end
    end
end
end