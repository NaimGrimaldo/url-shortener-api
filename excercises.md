
# 1. Write a function that returns product of all numbers of an array/range
```ruby
def get_product(vector)
  vector.reduce(:*)
rescue StandardError
  nil
end
```

# 2. Compare if two strings are anagrams (assume input consists of ASCII alphabets only)
```ruby
# first way
def str_anagram?(str1, str2)
  return unless str1.is_a?(String) && str2.is_a?(String)
  
  sorted_str1 = sort_string(str1)
  sorted_str2 = sort_string(str2)
  sorted_str1.eql?(sorted_str2)
end

def sort_string(str)
  str.chars.sort(&:casecmp).join('').downcase
end

# 2
def anagram?(str1, str2)
  return unless str1.is_a?(String) && str2.is_a?(String)

  return unless str1.size.eql?(str2.size)

  str1.chars.difference(str2.chars).empty?
end

```
# 3. Compare if two strings are same irrespective of case
```ruby
def str_comparison(str1, str2)
  return unless str1.is_a?(String) && str2.is_a?(String)
  
  str1.downcase.eql?(str2.downcase)
end
```
