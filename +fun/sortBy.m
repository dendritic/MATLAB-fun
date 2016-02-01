function arr = sortBy(key, arr)
%fun.sortBy Sorts an array according to corresponding key values
%
%   sorted = fun.sortBy(keyFun, A) applies function `keyFun` to each
%   element in the array `A` to obtain a keys for ordering the values.
%   Returns those elements sorted according to the key values.
%
%   sorted = fun.sortBy(keys, A) returns the elements of `A` sorted
%   according to the corresponding values in the `keys` array.
%
% E.g. sort some random numbers in descending order:
%   reverse = fun.sortBy(@uminus, randi(10, [1 5]))
%
% Sort a struct array according to a subject field:
%   s = struct('subject', {'d' 'e' 'c' 'a' 'b'})
%   sorted = fun.sortBy({s.subject}, s)

if isa(key, 'function_handle')
  if iscell(arr)
    key = cellfun(key, arr);
  else
    key = arrayfun(key, arr);
  end
end % otherwise assume key is sortable array of the same size as arr

[~, order] = sort(key);
arr = arr(order);

end

