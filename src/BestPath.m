function [pathRows,pathCols,pathElevation] = BestPath(E)
% By working backwards, provides the path from the left side to the
% right side of an elevation matrix which has the smallest variation in
% elevation.
% Input: A matrix containing elevation data
% Output: The rows, columns, and elevations for the best path
% Author: Connor Mattson
% Version: 1
% Date: 25/08/2017
% ENGGEN 131, Matlab Project

sizeOfElevationData = size(E);
nodeCosts = zeros(sizeOfElevationData);
nextNode = zeros(sizeOfElevationData);

for columns = sizeOfElevationData(2)-1:-1:1
    for nodeInColumn = 1:sizeOfElevationData(1)
        % Finds the possible next coordinates from this point
        newColumn = columns + 1;
        
        
        % The following code is equivalent to:
        
        % newRow = [currentY-1, currentY, currentY+1];
        % newYLogic = (newRow > 0) & (newRow < elevationDataSize(1)+1);
        % newRow = newRow(newYLogic);
        % newElevations = elevationData(newRow, newColumn);
        % cost = abs(E(nodeInColumn, columns) - newElevations);
        % cost = cost + nodeCosts(newRow, newColumn);
        
        % but written in this (much harder to read) way it is 3 times
        % faster
        % each cost(x) line takes the absolute of E - new E (the change in
        % elevation and adds nodeCosts (the minimum cost from that point to
        % the end of the array) to find the 
        
        if nodeInColumn == 1
            cost(1) = abs(E(nodeInColumn, columns) - E(nodeInColumn, ...
                newColumn)) + nodeCosts(nodeInColumn, newColumn);
            cost(2) = abs(E(nodeInColumn, columns) - E(nodeInColumn+1, ...
                newColumn)) + nodeCosts(nodeInColumn+1, newColumn);
            newRow(1) = nodeInColumn;
            newRow(2) = nodeInColumn+1;
            if numel(newRow) == 3
                cost(3) = [];
                newRow(3) = [];
            end
        elseif nodeInColumn == sizeOfElevationData(1)
            cost(1) = abs(E(nodeInColumn, columns) - E(nodeInColumn-1, ...
                newColumn)) + nodeCosts(nodeInColumn-1, newColumn);
            cost(2) = abs(E(nodeInColumn, columns) - E(nodeInColumn, ...
                newColumn)) + nodeCosts(nodeInColumn, newColumn);
            newRow(1) = nodeInColumn-1;
            newRow(2) = nodeInColumn;
            if numel(newRow) == 3
                cost(3) = [];
                newRow(3) = [];
            end
        else
            cost(1) = abs(E(nodeInColumn, columns) - E(nodeInColumn-1, ...
                newColumn)) + nodeCosts(nodeInColumn-1, newColumn);
            cost(2) = abs(E(nodeInColumn, columns) - E(nodeInColumn, ...
                newColumn)) + nodeCosts(nodeInColumn, newColumn);
            cost(3) = abs(E(nodeInColumn, columns) - E(nodeInColumn+1, ...
                newColumn)) + nodeCosts(nodeInColumn+1, newColumn);
            newRow(1) = nodeInColumn-1;
            newRow(2) = nodeInColumn;
            newRow(3) = nodeInColumn+1;
        end
        
        % This is the equivalent of calling min(cost) but because
        % it is called so many times, it is faster to avoid function
        % overhead despite the fact that the original is written in C
        smallestCost = -1;
        smallestPosition = 1;
        for i = 1:length(cost)
            if (cost(i) < smallestCost) || (smallestCost == -1)
                smallestCost = cost(i);
                smallestPosition = i;
            end
        end
        
        
        % Notes the cost of taking this node as a path and the shortest
        % path which follows it
        nodeCosts(nodeInColumn, columns) = smallestCost;
        nextNode(nodeInColumn, columns) = newRow(smallestPosition);
    end
end

% Find the node with the smallest path
[~, nextPosition] = min(nodeCosts(:,1));

% Follow nextNode values to create path
pathCols = 1:sizeOfElevationData(2);
pathRows = zeros(1, sizeOfElevationData(2));
for i = pathCols
    pathRows(i) = nextPosition;
    try
        nextPosition = nextNode(nextPosition, i);
    catch error
        % This ignores the error caused by trying to find the next
        % position after a final node
    end
end

% Format the path data for returning
pathElevation = zeros(1, sizeOfElevationData(2));
for i = 1:length(pathRows)
    pathElevation(i) = E(pathRows(i), pathCols(i));
end
end