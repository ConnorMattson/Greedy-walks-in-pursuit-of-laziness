function [mark] = MarkBestPath(specifiedFunctionName)
% Marks the BestPath function
% note that no marks are awarded if the function returns values of the
% wrong type.
%
% It has an optional argument specifiedFunctionName, which can be used
% to specify a different filename for the function,
% Use the optional argument if the user has mispelt their function name
%
% BestPath takes a single input, the elevation data stored in a 2D m x n matrix

% It returns three outputs in the following order:
% 1)	a 1D array representing containing the row indices of the best path
% 2)	a 1D array representing the corresponding column indices of the best path
% 3)	a 1D array containing the elevations for the corresponding row and column indices for the path
%
% If there is a tie for the path with the lowest cost, you mary return any valid lowest cost path
%
% author: Peter Bier

% default the function name to BestPath, if no optional arg specified
if nargin == 0
    functionName = 'BestPath';
else
    functionName = specifiedFunctionName;
end

% set up  test data
load TestDataBestPath

input1 = BestPathInput1;

expectedOutput1 = BestPathExpectedOutput1;
expectedOutput2 = BestPathExpectedOutput2;
expectedOutput3 = BestPathExpectedOutput3;


purpose = BestPathTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
%     try
        
        [output1{i} output2{i} output3{i}] = feval(functionName,input1{i});
        % check if result returned closely matches the expected result
        
        % calculate cost rather than comparing outputs directly
        % also check column numbers increase and row numbers don't differ
        % by more than 1
        [~,cost{i}] = FindPathElevationsAndCost(output1{i},output2{i},input1{i});
        r = output1{i};
        invalidRows = sum(abs(r(2:end)-r(1:(end-1)))>1);
        if isequal(expectedPathCost{i},cost{i}) && isequal(expectedOutput2{i},output2{i}) && invalidRows == 0
            totalPassed = totalPassed + 1;
            disp([m 'Passed test']);
        else
            disp([m 'FAILED test']);
        end
        
%     catch ex
%         disp([m 'FAILED test']);
%         ProcessMarkingException(ex, functionName)
%     end
    
end

% display marks summary
allocatedMarks = 3;
mark = ProcessMarksSummary(functionName,totalPassed,numTests,allocatedMarks);


