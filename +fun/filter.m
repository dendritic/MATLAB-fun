function [passed, failed] = filter(predicateFun, arr)
%fun.filter Returns array elements for which a predicate function returns true
%
%   [passed, failed] = fun.filter(pred, A) applies function `pred` to each
%   element in the array `A`. It returns the array `passed` with all the
%   elements for which `pred` returned `true`, and `failed` with those for
%   which it returned `false`.
%
% E.g. Keep only the odd numbers in an array
%   odd = fun.filter(@(v)mod(v, 2) == 1, -5:5) % returns [-5 -3 -1  1  3  5]

if iscell(arr)
  indicator = cellfun(predicateFun, arr);
else
  indicator = arrayfun(predicateFun, arr);
end

passed = arr(indicator);

if nargout > 1
  failed = arr(~indicator);
end

end

