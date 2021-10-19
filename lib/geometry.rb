module Geometry

  def range_to_proportion(start, target, current)
    range = start - target
    prop = (current - start).to_f / range.abs
    return 1 if prop > 1
    return 0 if prop < 0
    prop
  end

  def proportion_to_step(start, target, proportion)
    range = target.to_f - start
    slice = range * proportion.to_f
    start + slice
  end

end

