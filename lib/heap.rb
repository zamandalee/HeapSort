class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
    @store.count
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop
    @store = self.class.heapify_down(@store, 0, count, &@prc)
    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    child_indices = self.child_indices(len, parent_idx)
    child_vals = self.child_vals(array, child_indices)

    until child_indices.empty? || child_vals.all? { |child_val| prc.call(array[parent_idx], child_val) != 1 }

      smaller_idx = child_vals.length == 1 ? child_indices[0] :
        prc.call(child_vals[0], child_vals[1]) == -1 ?
          child_indices[0] : child_indices[1]

      array[parent_idx], array[smaller_idx] = array[smaller_idx], array[parent_idx]
      parent_idx = smaller_idx

      child_indices = self.child_indices(len, parent_idx)
      child_vals = self.child_vals(array, child_indices)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    parent_idx = self.parent_index(child_idx) unless child_idx.zero?

    until child_idx.zero? || prc.call(array[child_idx], array[parent_idx]) != -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]

      child_idx = parent_idx
      parent_idx = self.parent_index(child_idx) unless child_idx.zero?
    end

    array
  end

  def self.parent_index(child_index)
    child_index <= 0 ? (raise "root has no parent") : (child_index - 1) / 2
  end

  def self.child_indices(len, parent_index)
    children = []
    children << parent_index * 2 + 1 if parent_index * 2 + 1 < len
    children << parent_index * 2 + 2 if parent_index * 2 + 2 < len
    children
  end

  def self.child_vals(array, child_indices)
    child_vals = []
    child_vals << array[child_indices[0]] if child_indices[0]
    child_vals << array[child_indices[1]] if child_indices[1]
    child_vals
  end
end
