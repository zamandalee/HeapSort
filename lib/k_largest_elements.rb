require_relative 'heap'

# Given an `array` and an integer `k`
# return the k-largest elements in `O(nlogk)` time.
def k_largest_elements(array, k)
  # O(klogk)
  BinaryMinHeap.heapify_up(array, k-1, k)

  # O((n - k)logk)
  (k..array.length - 1).each do |idx|
    if array[idx] > array[0]
      array[0] = array[idx]
      BinaryMinHeap.heapify_down(array, 0, k)
    end
  end

  # O(k) space complexity
  array[0...k]
end
