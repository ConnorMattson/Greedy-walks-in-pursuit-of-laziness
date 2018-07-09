function [mark] = MarkReverse(specifiedFunctionName)
% Marks the Reverse function
% note that no marks are awarded if the function returns values of the
% wrong type.
%
% It has an optional argument specifiedFunctionName, which can be used
% to specify a different filename for the function,
% Use the optional argument if the user has mispelt their function name
%
% Reverse takes a single input, a 1D array to reverse.
% Reverse should return a single output, a 1D array with the elements in reverse 
% order to those of the array that was passed in as an input.
%
% author: Peter Bier

% default the function name to Reverse, if no optional arg specified
if nargin == 0
    functionName = 'Reverse';
else
    functionName = specifiedFunctionName;
end

% set up  test data
load TestDataReverse

input1 = ReverseInput;

expectedOutput = ReverseExpectedOutput;

purpose = ReverseTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output{i} = feval(functionName,input1{i});
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


