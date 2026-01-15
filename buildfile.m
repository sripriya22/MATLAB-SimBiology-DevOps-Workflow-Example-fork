function plan = buildfile

import matlab.buildtool.tasks.*

plan = buildplan(localfunctions);

% Set default task
plan.DefaultTasks = "test";


% CodeIssues task
plan("check") = CodeIssuesTask();

% Test task
tTask = TestTask("tests", ...
    SourceFiles = "code", ...
    IncludeSubfolders = true,...
    TestResults = fullfile("results","tests","index.html"), ...
    Dependencies = "check");
tTaskWithMatlabTest = tTask.addCodeCoverage( ...
    fullfile("results","coverage","index.html"), ...
    MetricLevel = "condition"); % Note: Change MetricLevel to "statement" 
                                % if you do not have MATLAB Test
plan("test") = tTaskWithMatlabTest;

% Clean task
plan("clean") = CleanTask();

end
