function [mark] = MarkGreedyWalk(specifiedFunctionName)
% Marks the GreedyWalk function
% note that no marks are awarded if the function returns values of the
% wrong type.
%
% It has an optional argument specifiedFunctionName, which can be used
% to specify a different filename for the function,
% Use the optional argument if the user has mispelt their function name
%
% GreedyWalk takes three inputs in the following order
% 1) a 2 element 1D array representing the starting position for the walk,
% with the first element representing the row number and the second the column 
% number
% 2) an integer representing the direction to head in, with a value of +1 
% for heading east and -1 for heading west 
% 3) the elevation data stored in a 2D m x n matrix
% It should return two outputs in the following order
% 1) a 1D array representing containing the row indices of the path
% 2) a 1D array representing the corresponding column indices of the path
% the second element is the column number.
%
% author: Peter Bier

% default the function name to GreedyWalk, if no optional arg specified
if nargin == 0
    functionName = 'GreedyWalk';
else
    functionName = specifiedFunctionName;
end

% set up  test data
load TestDataGreedyWalk

input1 = GreedyWalkInput1;
input2 = GreedyWalkInput2;
input3 = GreedyWalkInput3;

expectedOutput1 = GreedyWalkExpectedOutput1;
expectedOutput2 = GreedyWalkExpectedOutput2;

purpose = GreedyWalkTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        [output1{i} output2{i}] = feval(functionName,input1{i},input2{i},input3{i});
        % check if result returned closely matches the expected result
        
        if isequal(expectedOutput1{i},output1{i}) && isequal(expectedOutput2{i},output2{i})
            totalPassed = totalPassed + 1;
            disp([m 'Passed test']);
        else
            disp([m 'FAILED test']);
        end
        
    catch ex
        disp([m 'FAILED test']);
        ProcessMarkingException(ex, functionName)
    end
    
end

% display marks summary
allocatedMarks = 3;
mark = ProcessMarksSummary(functionName,totalPassed,numTests,allocatedMarks);


