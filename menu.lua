function showmenu()
  scene.update = update_menu
  scene.draw = draw_menu
  col1 = 7
  col2 = 10

  m={}
  m.x=28
  m.y=40
  m.options={"start","settings","credits"}
  m.amt=count(m.options)
  m.sel=1
  cx=m.x
end

function lerp(startv,endv,per)
  return(startv+per*(endv-startv))
end

function update_cursor()
  if (btnp(2)) then
    m.sel = m.sel - 1
    cx=m.x
    -- sfx(0) 
  end
  if (btnp(3)) then
    m.sel = m.sel + 1
    cx=m.x
    -- sfx(0) 
  end
  if (btnp(4)) then
    cx=m.x
    -- sfx(1) 
  end
  if (m.sel > m.amt) then
    m.sel=1
  end
  if (m.sel<=0) then
    m.sel=m.amt
  end
  cx = lerp(cx, m.x + 5, 0.5)
end

function update_menu()
  update_cursor()
  if btnp(4) then
    if m.options[m.sel]=="start" then
      showgame()
    end
  end
end

function draw_menu()
  cls(1)
  for i=1, m.amt do
    oset=i*8
    if i==m.sel then
      print(m.options[i], cx, m.y + oset, col2)
    else
      print(m.options[i], m.x, m.y + oset, col1)
    end
  end
end
