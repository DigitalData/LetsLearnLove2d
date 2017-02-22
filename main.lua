--This is a new Game I made using tutorials from SockMunkee.com ...

function love.load()
onMenu = true;
menu = require("menu");
menu.loadMenu();
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
