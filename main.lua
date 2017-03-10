--This is a new Game I made using tutorials from SockMunkee.com ...

function love.load()

  love.graphics.setDefaultFilter("nearest","nearest");
  music = love.audio.newSource("assets/sound/music/lmc.mp3", "stream");
  love.audio.play(music);

  pNum = 1;
  pClass = 0;

  onMenu = true;
  menu = require("menu");
  menu.loadMenu(pNum);
  beginGame = false;

  game = require("game");
  game.loadGame();

  willQuit = false;
end

function love.update(dt)
  if(onMenu)then
    menu.updateMenu(dt);
    pClass, beginGame = menu.checkStart();

    if beginGame then
      onMenu = false;
    end
  else
    game.updateGame(dt);
  end
end

function love.draw()
  if(onMenu)then
    menu.drawMenu();
  else
    love.audio.stop();
    game.drawGame();
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
  if(key == "esc")then
    if (onMenu) then
      onMenu = false;
    else
      onMenu = true;
    end
  end

  function love.quit()
    -- body...
  end
end
