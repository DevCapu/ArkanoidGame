-- title:  arkanoid
-- author: Apoio Educacional
-- desc:  	Classic game
-- script: lua

SCREEN_X = 240
SCREEN_Y = 136
TX = 16
TY = 8

vida = 3

carrinho = {
	x=96,
	y=120
}

bolinha = {
    x = 96, 
    y = 118, 
    dx = 1, 
    dy = 1
}

blocos = {}

for posicao	= 0, 14	do
	for posicaoy = 0, 5 do
	bloco = {
 	    x = posicao * TX, y = posicaoy * 8 , tx = TX, ty = TY
    }
	table.insert(blocos,bloco)
	end
end

function gameloop() 
    mostraVida()
    verificaSeCarrinhoEstaMexendo()
    desenhaBlocos()
    desenhaCarrinho()
    desenhaBolinha()
    moveBolinha()
	colidiuComParede()
    verificaColisaoComCarrinho()
    verificaColisaoComBlocos()
	verificaSeMorreu()
end

function verificaVida()
    if(vida > 0) then
		return true
    end
    return false
end


function verificaSeCarrinhoEstaMexendo()
    if btn(2) then 
        carrinho.x = carrinho.x - 2 
    end
    if btn(3) then 
        carrinho.x = carrinho.x + 2 
    end
end

function mostraVida()
    print("Vida: "..vida, 0, 130, 15)
end

function desenhaCarrinho()
    spr(257,carrinho.x,carrinho.y,0,1,0,0,2,1)
end

function desenhaBolinha()
    spr(256,bolinha.x,bolinha.y,0,1,0,0,1,1)
end

function desenhaBlocos()
    for posicao,bloco in pairs(blocos) do
        spr(259, bloco.x, bloco.y,0,1,0,0,2,1)
    end
end

function moveBolinha()
    bolinha.y = bolinha.y + bolinha.dy
	bolinha.x = bolinha.x + bolinha.dx
end

function verificaColisaoComBlocos()
    for posicao,bloco in ipairs(blocos) do
        if colisaoBloco(bloco) then
            table.remove(blocos,posicao)
            break
        end	
	end
end

function verificaSeMorreu()
    if bolinha.y == 136 then
		vida = vida - 1
		bolinha.x = carrinho.x + 8
		bolinha.y = 118
	end
end

function verificaColisaoComCarrinho()
    if bolinha.y + 1 == carrinho.y then
	    if bolinha.x >= carrinho.x and bolinha.x <= carrinho.x+15 then
		    bolinha.dy = bolinha.dy * -1
		end
    end
end

function verificaColisaoEmCima(bloco)
    if bolinha.x == bloco.x + bloco.tx and bolinha.y >= bloco.y and bolinha.y <= bloco.y + bloco.ty	then
        bolinha.dx = bolinha.dx * -1
        return true
    end
    return false
end

function verificaColisaoNaDireita(bloco)
    if bolinha.x == bloco.x + bloco.tx and bolinha.y >= bloco.y and bolinha.y <= bloco.y + bloco.ty	then
		bolinha.dx = bolinha.dx * -1
		return true
    end
    return false
end

function verifcaColisaoEmbaixo(bloco)
    if bolinha.y == bloco.y + bloco.ty and bolinha.x >= bloco.x and  bolinha.x <= bloco.x + bloco.tx	then
		bolinha.dy = bolinha.dy * -1
		return true
    end
    return false
end

function verificaColisaoNaEsquerda(bloco)
    if bolinha.y == bloco.y + bloco.ty and bolinha.x >= bloco.x and bolinha.x <= bloco.x + bloco.tx	then
		bolinha.dy = bolinha.dy * -1
		return true
	end
    return false
end
function colisaoBloco(bloco)
    if(verificaColisaoEmCima(bloco)) then
        return true
    elseif (verificaColisaoNaDireita(bloco)) then
    
    elseif (verifcaColisaoEmbaixo(bloco)) then
        return true
    elseif (verificaColisaoNaEsquerda(bloco)) then
        return true
    end
    return false
end

function verificaColisaoComParedeDireita()
    if bolinha.x < 0 or bolinha.x > SCREEN_X then
		bolinha.dx = bolinha.dx * -1
	end
end

function verificaColisaoComParedeEsquerda()
    if bolinha.y < 0 then
		bolinha.dy = bolinha.dy * -1
	end
end

function colidiuComParede()
    verificaColisaoComParedeDireita()
    verificaColisaoComParedeEsquerda()
end

function TIC()
	cls(03)
    
    if verificaVida() then
        gameloop()
    else
        print("Perdeu mermao", SCREEN_X/2, SCREEN_Y/2, 15)
    end

end
