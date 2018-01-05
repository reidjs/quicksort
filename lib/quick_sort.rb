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
  def self.sort2!(array, first=0, last=array.length-1, &prc)
    # p "a: #{array}, s: #{start}, l: #{length}"
    # if length <= 1
    #   # p start, length 
    #   return array 
    # end
    if first < last
      p_index = partition(array, first, last)
      QuickSort.sort2!(array, first, p_index - 1)
      QuickSort.sort2!(array, p_index + 1, last)
    end 
    array
    # pivot_idx = partition(array, start, length, &prc)
    # # if pivot_idx > 0
    # # byebug
    # QuickSort.sort2!(array, start, pivot_idx - 1) #sort the left 
    # # byebug
    # QuickSort.sort2!(array, pivot_idx + 1, array.length - pivot_idx)
  end

  def self.partition(array, start, length, &prc)
    byebug
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


#https://medium.com/@andrewsouthard1/quicksort-implementation-in-ruby-92de12470efd
def quicksort(arr, first=0, last=arr.length-1)
  if first < last
    p_index = partition(arr, first, last)
    quicksort(arr, first, p_index - 1)
    quicksort(arr, p_index + 1, last)
  end

  arr
end

def partition(arr, first, last)
  # first select one element from the list, can be any element. 
  # rearrange the list so all elements less than pivot are left of it, elements greater than pivot are right of it.
  pivot = arr[last]
  p_index = first
  
  i = first
  while i < last
    if arr[i] <= pivot
      temp = arr[i]
      arr[i] = arr[p_index]
      arr[p_index] = temp
      p_index += 1
    end
    i += 1
  end
  temp = arr[p_index]
  arr[p_index] = pivot
  arr[last] = temp
  return p_index
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