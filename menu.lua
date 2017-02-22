local m = {};

function loadMenu()
  title = love.graphics.newFont("assets/fonts/titlefont.ttf",150);
  namea = 255;
  nameadown = true;
end

function drawMenu()
  love.graphics.setFont(title);
local shakex = math.random(0, 5);
local shakey = math.random(0, 5);

love.graphics.setColor(255, 255, 255, 255);
love.graphics.print("This Little Game", (winW / 2 + shakex) - 200, 100 + shakey, 0,1,1);

love.graphics.setColor(255, 255, 255, namea);
love.graphics.print(" - Xavier Travers", (winW / 2 - 200), 210, 0, 0.5,0.5);

love.graphics.setColor(255, 255, 255, 255);
love.graphics.rectangle("line", (love.graphics.getWidth() / 2) -110, 310, 200, 60);
love.graphics.print("Start", (love.graphics.getWidth() / 2) -40, 310, 0, 0.4, 0.4);
love.graphics.rectangle("line", (love.graphics.getWidth() / 2) -110, 380 + adh, 200, 60);
love.graphics.print("Options", (love.graphics.getWidth() / 2) -50, 380 + adh, 0, 0.4, 0.4);
love.graphics.rectangle("line", (love.graphics.getWidth() / 2) -110, 310 + (2*70) + 2*adh, 200, 60);
love.graphics.print("Quit", (love.graphics.getWidth() / 2) -40, 310 + (2*70) + 2*adh, 0, 0.4, 0.4);

end

function updateMenu(dt)

winW = love.graphics.getWidth();
winH = love.graphics.getHeight();

adh = love.graphics.getHeight() / 45;

  if(nameadown)then
    if(namea < 50) then
      nameadown = false;
    else
      namea = namea - 300*dt;
    end
  else
    if(namea > 255) then
      nameadown = true;
    else
      namea = namea + 300*dt;
    end
  end
end

m.loadMenu = loadMenu;
m.updateMenu = updateMenu;
m.drawMenu = drawMenu;

return m;
