function smallestPosition = FindSmallestElevationChange(height, endHeight)
    % Outputs the position of the element in endHeight which has the
    % smallest difference with the start height
    % Input: an initial height followed by an array of potential end
    % heights
    % Output: the position(s) of which element in endHeight gives the
    % smallest change in height
    % Author: Connor Mattson
    % Version: 1
    % Date: 25/08/2017
    % ENGGEN 131, Matlab Project
    
    % Create an array of the changes in height for each corresponding
    % endheight
    heightChanges = abs(endHeight - height);
    smallestChange = min(heightChanges);
    smallestPosition = find(heightChanges == smallestChange);
end