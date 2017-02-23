p = {};

function playerLoad(img)
playerX = 0;
playerY = 0;
playerImg = img; 

player = {playerX,playerY,playerImg}


end

function playerUpdate()
end

function playerDraw()
end

p.playerLoad = playerLoad;
p.playerUpdate = playerUpdate;
p.playerDraw = playerDraw;

return p;
