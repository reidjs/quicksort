require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array[0]
    left = []
    right = []
    i = 1
    while i < array.length 
      if array[i] <= pivot
        left << array[i]
      else 
        right << array[i]
      end 
      i += 1
    end 
    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    p "a: #{array}, s: #{start}, l: #{length}"
    if length <= 1
      # p start, length 
      return array 
    end 
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    # if pivot_idx > 0
    QuickSort.sort2!(array, start, pivot_idx - 1) #sort the left 
    # byebug
    QuickSort.sort2!(array, pivot_idx + 1, array.length - pivot_idx)
  end

  def self.partition(array, start, length, &prc)
    
    barrier = start + 1 #keep track of sorted elements (less than pivot)
    pivot = array[start]
    length.times do |cnt|
      current_idx = start + cnt
      # byebug if array[current_idx].nil?
      if array[current_idx] < pivot
        array[barrier], array[current_idx] = array[current_idx], array[barrier]
        barrier += 1
      end 
    end 
    array[start], array[barrier-1] = array[barrier-1], array[start]
    barrier - 1 #return pivot index
  end
end
# arr = [5, 3, 8, 1, 8, 12, 3, 4, 2, 5, 1, 12, 3, 1, 6]
# p arr
# QuickSort.sort2!(arr)
# p arr
# arr = [4, 3, 2, 1, 7, 5, 8, 6]
# pivot_idx = QuickSort.partition(arr, 4, 4)
# p pivot_idx
# p arr
# arr = [3, 1, 5, 2, 4]

# p QuickSort.partition(arr, 0, 5)

# input = [5,4,6,3,2,2,5,1,10]
# p QuickSort.sort1(input)