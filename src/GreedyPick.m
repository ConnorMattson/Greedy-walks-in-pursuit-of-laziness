function newPosition = GreedyPick(currentPosition, direction, elevationData)
    % Returns the coordinates of the next position to move to in order to
    % continue the greedy path
    % Input: The current position (x, y), the direction (-1 for left, 1 for
    % right), and a matrix of the elevation data
    % Output: the coordinates of the next position in the greedy path
    % Author: Connor Mattson
    % Version: 1
    % Date: 25/08/2017
    % ENGGEN 131, Matlab Project
    
    % Analyse input
    currentX = currentPosition(2);
    currentY = currentPosition(1);
    elevationDataSize = size(elevationData);
    
    % Assign new coordinate locations
    newX = currentX + direction;
    newY = [currentY-1, currentY, currentY+1];
    % Creates a logical array of whether coordinates are inside the data
    newYLogic = (newY > 0) & (newY < elevationDataSize(1)+1);
    % Remove elemnts of newY that are outside of the coordinate range
    newY = newY(newYLogic);
    
    % Retrieve the elevations at the new coordinates as a 1d array
    newElevations = rot90(elevationData(newY, newX));
    % Find the position of the element that would result in the smallest
    % change in elevation
    smallestPosition = FindSmallestElevationChange(elevationData(currentY, currentX), newElevations);
    % Return the coordinates of the next position, if multiple y values
    % result in the same change in elevation, the minimum y (northenmost
    % point) is selected
    newPosition = [newY(min(smallestPosition)), newX];
    













