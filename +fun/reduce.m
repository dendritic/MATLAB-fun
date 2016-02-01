function res = reduce(f, arr, init)
%fun.reduce Iteratively boils down an array of values into a single value
%
%   res = fun.reduce(f, A, initval) applies function `f` to each element in
%   the array `A` together with the result of its last application, as in
%   newval = f(elem, lastval). It returns the final return value after
%   iterating over all the array elements. `initval` determines the initial
%   value used for the application of `f` with the first element.
%
% E.g. sum the values in an array
%   total = fun.reduce(@plus, 1:10, 0) % total = 55

res = init;

if iscell(arr)
  for ai = 1:numel(arr)
    res = f(arr{ai}, res);
  end
else
  for ai = 1:numel(arr)
    res = f(arr(ai), res);
  end
end

end

