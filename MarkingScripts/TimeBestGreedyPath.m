% Time BestPath by running it on a 100x100 elevation array
% Timing standards are based on execution time when code is run on the 
% university lab machines
% Timing will be done by running this script three times and averaging the
% result
% Note you can only earn timing marks if your BestPath function
% earned full functionality marks, i.e. you need a working BestPath
% function to be eligible for the timing marks.
% If the average time is less than 10 seconds you get 2 marks
% If the average time is more than 10 but less than 20 seconds you get 1 mark
% if the average time is more than 20 seconds you do not earn a timing mark
% author: Peter Bier

% Set up an array using the peaks function to generate elevation data

E = peaks(100);
tic % start the clock
[PathRows,PathCols, PathElev]=BestGreedyPath(E);
toc % stop the clock
