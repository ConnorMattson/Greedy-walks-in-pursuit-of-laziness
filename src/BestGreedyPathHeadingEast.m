function [finalRows, finalCols, finalElevations] = BestGreedyPathHeadingEast(elevationData)
% Given elevation data, finds the best greedy path originating from the
% west (left hand side)
% Input: A matrix containing elevation data
% Output: the rows, columns, and elevations for the best path
% originating in the west.
% Author: Connor Mattson
% Version: 1
% Date: 25/08/2017
% ENGGEN 131, Matlab Project

bestCostSoFar = -1;
sizeOfElevationData = size(elevationData);
for i = 1:sizeOfElevationData(1)
    [pathRows, pathCols] = GreedyWalk([i, 1], 1, elevationData);
    [elevations, totalCost] = FindPathElevationsAndCost(pathRows, ...
        pathCols, elevationData);
    
    % If a better path has already been found, discards the data; if
    % not, saves the data.
    if (totalCost < bestCostSoFar) || (bestCostSoFar == -1)
        [finalRows, finalCols, finalElevations, bestCostSoFar] = ...
            deal(pathRows, pathCols, elevations, totalCost);
    end
end
end