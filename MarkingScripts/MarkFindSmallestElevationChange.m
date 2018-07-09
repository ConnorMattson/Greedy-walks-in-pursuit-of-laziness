function [mark] = MarkFindSmallestElevationChange(specifiedFunctionName)
% Marks the FindSmallestElevationChange function
% note that no marks are awarded if the function returns values of the
% wrong type.
%
% It has an optional argument specifiedFunctionName, which can be used
% to specify a different filename for the function,
% Use the optional argument if the user has mispelt their function name
%
% FindSmallestElevationChange takes as Inputs (in order)
% 1)	A number representing the current elevation
% 2)	A 1D array of new elevations to choose from
%
% FindSmallestElevationChange should return a single output, a 1D array containing a list of indices 
% that identify the array element(s) that correspond to the smallest 
% change in elevation (the change will be measured as a positive number 
% regardless of whether the elevation change is an increase or decrease).  
%
% The output array will have at least one element but may have multiple
% elements if there are multiple elements in the new elevations that 
% produce a tie for the smallest elevation
%
% author: Peter Bier

% default the function name to FindSmallestElevationChange, if no optional arg specified
if nargin == 0
    functionName = 'FindSmallestElevationChange';
else
    functionName = specifiedFunctionName;
end

% set up  test data
load TestDataFindSmallestElevationChange

input1 = FindSmallestElevationChangeInput1;
input2 = FindSmallestElevationChangeInput2;

expectedOutput = FindSmallestElevationChangeExpectedOutput;

purpose = FindSmallestElevationChangeTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output{i} = feval(functionName,input1(i),input2{i});
        % check if result returned closely matches the expected result
        
        if isequal(expectedOutput{i},output{i})
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


