# Ruby Data Structures

Common data structures implemented in Ruby

### Static Array
This is just to mimic the C array that Ruby does not expose. It is of a fixed width and makes no guarantees other than a contiguous allocation of RAM.

```ruby
arr = StaticArray.new(8)

i = 0
while i <= 5
  arr[i] = i
  i += 1
end
```
```ruby
# is effectively:
  [0, 1, 2, 3, 4, 5, nil, nil]
```

### Dynamic Array
This is similar to the base Ruby array, which is dynamically resized and has some useful methods such as push and shift. This implementation is built on top of the static array and makes use a ring-buffer-style wrapping to handle unshifts in an amortized linear time.

```ruby
arr = DynamicArray.new

i = 0
while i <= 9
  arr.push(i)
  i += 1
end

arr.unshift(1)
arr.unshift(0)
```
```ruby
# is effectively:  
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
# but underlying StaticArray looks like:
  [2, 3, 4, 5, 6, 7, 8, 9, nil, nil, nil, nil, nil, nil, 0, 1]
```

### Max Heap
This is a Max Heap Tree that will take in a dynamic array and immediately sort it into a (max) heap. The max element is accessible in linear time and inserts/extracts will trigger sift-ups/downs to maintain heap ordering.

```ruby
MaxHeap.new([5, 12, 64, 1, 37, 90, 91, 97])
```
```ruby
# is effectively:

             97
         ┌----┴----┐
        37         91
      ┌--┴--┐   ┌--┴--┐
     12     5  90     64
   ┌--┘
  97

# but underlying DynamicArray looks like:
  [97, 37, 91, 12, 5, 90, 54, 1]
```
