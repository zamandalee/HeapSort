require_relative "heap"

class Array
  def heap_sort!
    # heapify into max-heap
    prc = Proc.new { |el1, el2| -1 * (el1 <=> el2) }

    self.each_index do |idx|
      BinaryMinHeap.heapify_up(self, idx, idx + 1, &prc)
    end

    # sort from right to left
    (self.length - 1).downto(1) cdo |idx|
      self[0], self[idx] = self[idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, idx, &prc)
    end

  end
end
