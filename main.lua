--This is a new Game I made using tutorials from SockMunkee.com ...

function love.load()
music = love.audio.newSource("assets/sound/music/lmc.mp3", "stream");
love.audio.play(music);

  pNum = 1;

  onMenu = true;
  menu = require("menu");
  menu.loadMenu(pNum);

  willQuit = false;
end

function love.update(dt)
  if(onMenu)then
    menu.updateMenu(dt);
  end
end

function love.draw()
  if(onMenu)then
    menu.drawMenu();
  else

  end
end

function love.focus(focus)
  if not focus then
    onMenu = true;
  end
end

function love.mousepressed(x, y, button, isTouch)
  if button == 1 then
    if onMenu then
      willQuit = menu.mousepressed(x,y);
      if(willQuit)then
        love.event.quit(exitstatus)
      end
    end
  end
end

function love.keypressed(key, scancode, isrepeat)

end

function love.quit()
  -- body...
end
