-- axis-aligned bounding box collision detection
function aabb_collide(x1, y1, w1, h1, x2, y2, w2, h2)
  if x1 < x2 + w2 and
     x1 + w1 > x2 and
     y1 < y2 + h2 and
     y1 + h1 > y2 then
    return true
  else
    return false
  end
end

function map_collide(x, y, w, h, dx, dy)
  x = x + dx
  y = y + dy

  s1 = mget(flr(x/8), flr(y/8))
  s2 = mget(flr((x+w-1)/8), flr(y/8))
  s3 = mget(flr(x/8), flr((y+h-1)/8))
  s4 = mget(flr((x+w-1)/8), flr((y+h-1)/8))

  if fget(s1) == 1 then
    return true
  elseif fget(s2) == 1 then
    return true
  elseif fget(s3) == 1 then
    return true
  elseif fget(s4) == 1 then
    return true
  end

  return false
end

function get_pickups(map_w, map_h, flag)
  local pickups = {}

  for i = 0, map_w-1 do
    for j = 0, map_h-1 do
      local tile = mget(i,j)
      if fget(tile) == flag then
        add(pickups, {x=i*8, y=j*8, s=tile})
        mset(i,j,0)
      end
    end
  end

  return pickups
end

-- random int between i and j
function rand(i, j)
  if (j) then
    return flr(rnd(j-i))+i
  else
    return flr(rnd(i))
  end
end
