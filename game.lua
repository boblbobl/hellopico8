function showgame()
  scene.update = update_game
  scene.draw = draw_game

  map_w = 32
  map_h = 16

  limes=get_pickups(map_w, map_h, 2)

  cx=0
  cy=0

  start_x = 60
  start_y = 56

  hero_score = 0
  hero_anim_time = 0
  hero_amin_wait = .08
  hero_speed = 2
  hero={
    x = start_x,
    y = start_y,
    h = 16,
    w = 8,
    sprite = 0,
    sid = 0,
    flipped = false,
    dx = 0,
    dy = 0,
  }
end

function step()
  if time() - hero_anim_time > hero_amin_wait then
    if hero.sid < 3 then
      hero.sid = hero.sid+1
    elseif hero.sid == 3 then
      hero.sid = 0
      hero.flipped = not hero.flipped
    end

    if hero.dx ~= 0 then
      hero.sprite = hero.sid+4
      if hero.dx == -hero_speed then
        hero.flipped = true
      else
        hero.flipped = false
      end
    else
      hero.sprite = hero.sid
    end

    hero_anim_time = time()
  end
end

function update_game()
  hero.dx=0
  hero.dy=0

  if btn(0) then
    hero.dx = -hero_speed
  end
  if btn(1) then
    hero.dx = hero_speed
  end
  if btn(2) then
    hero.dy = -hero_speed
  end
  if btn(3) then
    hero.dy = hero_speed
  end

  if map_collide(hero.x, hero.y, hero.w, hero.h, hero.dx, hero.dy) then
    hero.dx = 0
    hero.dy = 0
  end

  if hero.dx ~= 0 or hero.dy ~= 0 then
    step()
    hero.x = hero.x + hero.dx
    hero.y = hero.y + hero.dy

    for lime in all(limes) do
      if aabb_collide(hero.x, hero.y, hero.w, hero.h, lime.x, lime.y, 8, 8) then
        hero_score = hero_score + 1
        del(limes, lime)
      end
    end

    -- adjust camera to player position
    if hero.x >= start_x and hero.x <= 256-(start_x+hero.w) then
      cx = hero.x-start_x
    end

    if hero.y >=start_y and hero.y <= 128-(start_y+hero.h) then
      cy = hero.y-start_y
    end
  end

end

function draw_game()
  cls(1)
  map(0, 0, 0, 0, map_w, map_h)
  camera(cx, cy)
  spr(hero.sprite,hero.x,hero.y,1,2,hero.flipped)
  for lime in all(limes) do
    spr(8, lime.x, lime.y)
  end

  print("score " .. hero_score, 10+cx, 10+cy)
end
