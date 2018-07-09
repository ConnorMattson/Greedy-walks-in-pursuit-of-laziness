function [mark] = MarkFindPathElevationsAndCost(specifiedFunctionName)
% Marks the FindPathElevationsAndCost function
% note that no marks are awarded if the function returns values of the
% wrong type.
%
% It has an optional argument specifiedFunctionName, which can be used
% to specify a different filename for the function,
% Use the optional argument if the user has mispelt their function name
%
% FindPathElevationsAndCost takes three inputs in the following order:
% 1) a 1D array representing containing the row indices of the path
% 2) a 1D array representing the corresponding column indices of the path
% 3) the elevation data stored in a 2D m x n matrix
% 
% It returns two outputs in the following order:
% 1) a 1D array containing the elevations for the corresponding row and 
% column indices for the path
% 2) the total cost of traversing the path

%
% author: Peter Bier

% default the function name to FindPathElevationsAndCost, if no optional arg specified
if nargin == 0
    functionName = 'FindPathElevationsAndCost';
else
    functionName = specifiedFunctionName;
end

% set up  test data
load TestDataFindPathElevationsAndCost

input1 = FindPathElevationsAndCostInput1;
input2 = FindPathElevationsAndCostInput2;
input3 = FindPathElevationsAndCostInput3;

expectedOutput1 = FindPathElevationsAndCostExpectedOutput1;
expectedOutput2 = FindPathElevationsAndCostExpectedOutput2;

purpose = FindPathElevationsAndCostTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        [output1{i} output2{i}] = feval(functionName,input1{i},input2{i},input3{i});
        % check if result returned closely matches the expected result
        
        if isequal(expectedOutput1{i},output1{i}) && abs(expectedOutput2{i}-output2{i})<1e-8
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


