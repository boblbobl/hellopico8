function showgame()
  scene.update = update_game
  scene.draw = draw_game

  limes={}
  repeat
    new_lime()
  until count(limes) == 5

  hero_score = 0
  hero_anim_time = 0
  hero_amin_wait = .08
  hero_speed = 2
  hero={
    x = 63,
    y = 63,
    dir = 0,
    sprite = 0,
    sid = 0,
    flipped = false,
    dx = 0,
    dy = 0,
  }
end

function new_lime()
  add(limes, {x=rand(20, 108), y=rand(20, 108)})
end

function step()
  if time() - hero_anim_time > hero_amin_wait then
    if hero.sid < 3 then
      hero.sid = hero.sid+1
    elseif hero.sid == 3 then
      hero.sid = 0
      hero.flipped = not hero.flipped
    end

    if hero.dir == 0 or hero.dir == 1 then
      hero.sprite = hero.sid+4
      if hero.dir == 0 then
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
    hero.dir = 0
    step()
  elseif btn(1) then
    hero.dx = hero_speed
    hero.dir = 1
    step()
  elseif btn(2) then
    hero.dy = -hero_speed
    hero.dir = 2
    step()
  elseif btn(3) then
    hero.dy = hero_speed
    hero.dir = 3
    step()
  end

  if map_collide(hero.x, hero.y, 8, 16, hero.dx, hero.dy) then
    hero.dx = 0
    hero.dy = 0
  end

  if hero.dx ~= 0 or hero.dy ~= 0 then
    hero.x = hero.x + hero.dx
    hero.y = hero.y + hero.dy

    for lime in all(limes) do
      if aabb_collide(hero.x, hero.y, 8, 16, lime.x, lime.y, 8, 8) then
        hero_score = hero_score + 1
        del(limes, lime)
        new_lime()
      end
    end
  end
end

function draw_game()
  cls(1)
  map(0,0,0,0,16,16)
  spr(hero.sprite,hero.x,hero.y,1,2,hero.flipped)
  print("score " .. hero_score, 10, 10)
  for lime in all(limes) do
    spr(8, lime.x, lime.y)
  end
end
