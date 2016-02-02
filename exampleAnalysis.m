function exampleAnalysis()
% The following two functions require Rigbox (run addRigboxPaths in
% \\zserver\code\rigging\main to add it to your path)
%% obtain a bunch of behavioural blocks for a particular subject
exprefs = dat.listExps('Dale'); % list of all experiment refs of 'Dale'
% map exprefs to a list of paths where a block file should be found if it
% exists
filelist = dat.expFilePath(exprefs, 'block', 'master');
% filter out those that dont exist
filelist = fun.filter(@file.exists, filelist);

blocks = fun.map(@load, filelist(1:10)); % load the first 10 blocks
% for each loaded struct extract the block from the `block` field
blocks = fun.map(@(s)s.block, blocks);
% a tidy alternative for the above line is: blocks = pick(blocks, 'block');
% concatenate all the blocks in the cell array into a struct array
blocks = catStructs(blocks);
trials = catStructs({blocks.trial}); % concatenate all the trials together

%% example for grouping those blocks by day
day =  floor([blocks.startDateTime]); % floor just preserves the date part
byDay = groupBy(blocks, day);
% map each days blocks to their trials concatenated
trialsByDay = fun.map(@(blocks)catStructs({blocks.trial}), byDay);

%% example for very simple event-triggered average
tt = linspace(-5, 5); % row vector of relative time points around an event (used in stimTriggeredWheel)
stw = fun.map(@stimTriggeredWheel, blocks); % stim triggered wheel traces for each block
% offset so wheel is relative to first time point in each event
stwRel = fun.map(@(traces) bsxfun(@minus, traces, traces(:,1)), stw);
% plot an example
figure, plot(tt, stwRel{1});
% compute mean triggered average speed for each session
stwAvgSpeed = fun.map(@(traces) nanmean(abs(diff(traces, [], 2)), 1), stw);
stwAvgSpeed = cell2mat(stwAvgSpeed);
% plot all the session averages
figure, plot(tt(2:end), stwAvgSpeed)

  function wperievt = stimTriggeredWheel(block) % wheel position around each stim onset
    wx = block.inputSensorPositions;
    wt = block.inputSensorPositionTimes;
    % the nice parts are using bsxfun to build a 2D event by relative time array
    % and using interpolation to pick out the interpolated wheel positions
    % at each time point of interest
    evt = [block.trial.stimulusCueStartedTime]'; % column vector of event times
    perievt = bsxfun(@plus, evt, tt); % rows of absolute time points around each event
    wperievt = interp1(wt, wx, perievt); % rows of wheel positions around each event
  end

end

