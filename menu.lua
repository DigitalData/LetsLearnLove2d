local m = {};

function loadMenu(num)
  pClass = 0;
  title = love.graphics.newFont("assets/fonts/titlefont.ttf",150);
  namea = 255;
  nameadown = true;
  mainMenu = true;
  optionsMenu = false;
  startMenu = false;
  startGame = false;
  mouseX = love.mouse.getX();
  mouseY = love.mouse.getY();
  screenX = 800;
  screenY = 600;
  fScreen = false;
  gameV = 100;
  musicV = 100;
  buttonX = (love.graphics.getWidth() / 2) - 110;
  mainButtonY = {};
  pNum = num;
  playerPrev = love.graphics.newQuad(0, 0, 16, 16, 16, 48);
  pPrev = {};
  for i=1,pNum do
    pPrev[i] = {};
  end
  pPrev[1][1] = love.graphics.newImage("assets/playermodels/model1.png");
  pPrev[1][2] = "Red Jacket Kid";

  winW = love.graphics.getWidth();
  winH = love.graphics.getHeight();

  prevX = {};
  for i=1,pNum do
    prevX[i] = (winW / 2) - (252 - (i * 70));
  end
end

function drawMenu()
  love.graphics.setFont(title);
  local shakex = math.random(0, 5);
  local shakey = math.random(0, 5);

  love.graphics.setColor(255, 255, 255, 255);
  love.graphics.print("This Little Game", (winW / 2 + shakex) - 200, 100 + shakey, 0,1,1);

  love.graphics.setColor(255, 255, 255, namea);
  love.graphics.print(" - Xavier Travers", (winW / 2 - 200), 210, 0, 0.5,0.5);

  if(mainMenu)then
    drawMainMenu();
  elseif(optionsMenu) then
    drawoptionsMenu();
  elseif(startMenu)then
    drawstartMenu();
  elseif(quit) then
  end

end

function updateMenu(dt)

  winW = love.graphics.getWidth();
  winH = love.graphics.getHeight();
  adh = love.graphics.getHeight() / 45;

  mouseX = love.mouse.getX();
  mouseY = love.mouse.getY();

  if(mainMenu)then
    updateMainMenu();
  elseif(optionsMenu) then
    updateoptionsMenu();
  elseif(startMenu)then
    updatestartMenu();
  elseif(quit) then
  end

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

function drawMainMenu()
  local hoverNum = -1;
  if (mouseX > buttonX) and (mouseX < buttonX+200) then
    for i=0,2 do
      if(mouseY > mainButtonY[i]) and (mouseY < mainButtonY[i] + 60)then
        if i==0 then
          hoverOver = true;
          hoverNum = i;
        elseif i==1 then
          hoverOver = true;
          hoverNum = i;
        elseif i==2 then
          hoverOver = true;
          hoverNum = i;
        end
      end
    end
  end

  love.graphics.setColor(255, 255, 255, 255);
  for i=0,2 do
    if( i == hoverNum )then
      love.graphics.rectangle("fill", buttonX,mainButtonY[i] ,200 , 60);
    else
      love.graphics.rectangle("line", buttonX,mainButtonY[i] ,200 , 60);
    end
  end

  love.graphics.setColor(255, 255, 255, 255);
  if(hoverNum == 0) then
    love.graphics.setColor(0,0,0,255);
    love.graphics.print("Start", (love.graphics.getWidth() / 2) -40, mainButtonY[0], 0, 0.4, 0.4);
    love.graphics.setColor(255, 255, 255, 255);
    love.graphics.print("Options", (love.graphics.getWidth() / 2) -50, mainButtonY[1], 0, 0.4, 0.4);
    love.graphics.print("Quit", (love.graphics.getWidth() / 2) -40, mainButtonY[2], 0, 0.4, 0.4);
  elseif(hoverNum == 1) then
    love.graphics.print("Start", (love.graphics.getWidth() / 2) -40, mainButtonY[0], 0, 0.4, 0.4);
    love.graphics.setColor(0,0,0,255);
    love.graphics.print("Options", (love.graphics.getWidth() / 2) -50, mainButtonY[1], 0, 0.4, 0.4);
    love.graphics.setColor(255, 255, 255, 255);
    love.graphics.print("Quit", (love.graphics.getWidth() / 2) -40, mainButtonY[2], 0, 0.4, 0.4);
  elseif(hoverNum == 2) then
    love.graphics.print("Start", (love.graphics.getWidth() / 2) -40, mainButtonY[0], 0, 0.4, 0.4);
    love.graphics.print("Options", (love.graphics.getWidth() / 2) -50, mainButtonY[1], 0, 0.4, 0.4);
    love.graphics.setColor(0,0,0,255);
    love.graphics.print("Quit", (love.graphics.getWidth() / 2) -40, mainButtonY[2], 0, 0.4, 0.4);
    love.graphics.setColor(255, 255, 255, 255);
  else
    love.graphics.print("Start", (love.graphics.getWidth() / 2) -40, mainButtonY[0], 0, 0.4, 0.4);
    love.graphics.print("Options", (love.graphics.getWidth() / 2) -50, mainButtonY[1], 0, 0.4, 0.4);
    love.graphics.print("Quit", (love.graphics.getWidth() / 2) -40, mainButtonY[2], 0, 0.4, 0.4);
  end

end

function updateMainMenu()
  for i=0,2 do
    mainButtonY[i] = 310 + (i * 70) + adh;
  end
end

function optionsMenuSwitch()

  optionsMenu = true;

end

function drawoptionsMenu()

  love.graphics.print("Options WIP", 210, 370, 0, 0.8, 0.8);

end

function updateoptionsMenu()



end

function drawstartMenu()

  local hoverNum = -1;
  for i=1,pNum do
    if (mouseX > prevX[i]) and (mouseX < prevX[i] + 68) then
      if(mouseY > 398) and (mouseY < 398 + 68)then
        if i==1 then
          hoverOver = true;
          hoverNum = i;
        end
      end
    end
  end

  love.graphics.setColor(255, 255, 255, 255);
  for i=1,pNum do
    if( i == hoverNum )then
      love.graphics.rectangle("fill", prevX[i], 398, 68, 68);
    else
      love.graphics.rectangle("line", prevX[i], 398, 68, 68);
    end
    love.graphics.draw(pPrev[i][1], playerPrev, prevX[i] + 2, 400,0 , 4, 4);
    love.graphics.print(pPrev[i][2], prevX[i] -8, 474, 0, 0.2,0.2);
  end
end

function updatestartMenu()
  for i=1,pNum do
    prevX[i] = (winW / 2) - (252 - (i * 70));
  end
end

function mousepressed(x, y)
  if(mainMenu) then
    if (x > buttonX) and (x < buttonX+200) then
      for i=0,2 do
        if(y > mainButtonY[i]) and (y < mainButtonY[i] + 60)then
          if i==0 then
            mainMenu = false;
            startMenu = true;

          elseif i==1 then

            mainMenu = false;
            optionsMenu = true;

          elseif i==2 then

            mainMenu = false;
            quit = true;

            return true;

          end
        end
      end
    end
  end
  if(startMenu)then
    for i=1,pNum do
      if (x > prevX[i]) and (x < prevX[i] + 68) then
        if(y > 398) and (y < 398 + 68)then
            startGame = true;
            pClass = i;
            break;
        end
      end
    end
  end
end

function checkStart()
  return pClass, startGame;
end

m.loadMenu = loadMenu;
m.updateMenu = updateMenu;
m.drawMenu = drawMenu;
m.mousepressed = mousepressed;
m.checkStart = checkStart;

return m;
