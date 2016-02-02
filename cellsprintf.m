function strarr = cellsprintf(formatSpec, varargin)
%cellsprintf Generate formatted cell string array from cell array inputs
%
%   strArr = cellsprintf(formatspec, C1, ...)
%
% Part of Burgbox

strarr = fun.map(@(varargin) sprintf(formatSpec, varargin{:}), varargin{:});

end