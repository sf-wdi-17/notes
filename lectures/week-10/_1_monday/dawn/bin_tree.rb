class BinTree
  attr_reader :left, :right, :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  # This could be cleaned up
  def insert(el)
    if el < @value
      if @left != nil
        @left.insert(el)
      else
        @left = BinTree.new(el)
      end
    else
      if @right != nil
        @right.insert(el)
      else
        @right = BinTree.new(el)
      end
    end
  end

  def max
    bin = self
    while bin.right != nil
      bin = bin.right
    end
    bin.value
  end

  def min
    bin = self
    while bin.left != nil
      bin = bin.left
    end
    bin.value
  end

  # Needs refactoring
  def height
    left_height = 0
    if @left != nil
      left_height = @left.height
    end

    right_height = 0
    if @right != nil
      right_height = @right.height
    end
    return 1 + maximum(left_height, right_height)
  end


  def self.from_a(arr)
    mid = arr.length/2
    center = arr[arr.length/2]

    bin = BinTree.new(center)

    new_arr = arr.slice(0,mid).concat(arr.slice(mid+1, arr.length))
    new_arr.each do |el|
      bin.insert(el)
    end

    bin
  end

  private
    def maximum(x,y)
      if x > y
        x
      else
        y
      end
    end
end
