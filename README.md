# Heaps and Heapsort

## BinaryMinHeap
- Use array to store items
- Uses default prc for the MinHeap property
  - Can pass in different prc to make it behave like a MaxHeap.

`::child_indices`
- Returns up to 2 children: ```[parent_index * 2 + 1, parent_index * 2 + 2]```

`::parent_index`
- Returns up to 1 parent: ```(child_index - 1) / 2```

`::heapyify_down`
- Swap parent and children until 1. all children are (default) > parent or 2. there are no children

`::heapify_up`
- Whenever adding a new element to the heap
- Swap until current node is the root node or child is valid against its parent

`#push`
`#peek`
`#extract`

## Heapsort
- Monkey patch the `Array` class with the `#heap_sort!`
- Sort IN-PLACE!
- Create a Max-Heap -> sort from right to left by heapifying down for a length equal to the current index

## K-largest Elements
Example interview question:
Given an `array` and an integer `k`, return the k-largest elements in `O(nlogk)` time.
