module Directions

  KEYS = {
    'N' => [0, -1],
    'E' => [1, 0],
    'S' => [0, 1],
    'W' => [-1, 0],
  }

  def direction(key)
    KEYS[key]
  end

end