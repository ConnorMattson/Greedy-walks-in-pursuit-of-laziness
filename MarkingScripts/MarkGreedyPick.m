function [mark] = MarkGreedyPick(specifiedFunctionName)
% Marks the GreedyPick function
% note that no marks are awarded if the function returns values of the
% wrong type.
%
% It has an optional argument specifiedFunctionName, which can be used
% to specify a different filename for the function,
% Use the optional argument if the user has mispelt their function name
%
% The GreedyPick element takes three inputs in the following order:
% 1)	a 2 element 1D array representing the current position, 
% where the first element is the row number of the current position and the 
% second element is the column number
% 2)	an integer representing the direction to head in, with a value of +1 
% for heading east and -1 for heading west 
%3)	the elevation data stored in a 2D m by n matrix (where m is the number 
% of rows and n the number of columns).
%
% It should return a single output, a 2 element 1D array representing the 
% new position that has been picked, where the first element is the row 
% number of the new position and the second element is the column number.
%
% author: Peter Bier

% default the function name to GreedyPick, if no optional arg specified
if nargin == 0
    functionName = 'GreedyPick';
else
    functionName = specifiedFunctionName;
end

% set up  test data
load TestDataGreedyPick

input1 = GreedyPickInput1;
input2 = GreedyPickInput2;
input3 = GreedyPickInput3;

expectedOutput = GreedyPickExpectedOutput;

purpose = GreedyPickTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output{i} = feval(functionName,input1{i},input2{i},input3{i});
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


