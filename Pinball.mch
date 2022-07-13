MACHINE Pinball
    
SETS
    JOGADOR
    
CONSTANTS         
    nBolas, valorMaquina, empty, jogadores, bonus
    
PROPERTIES
    nBolas = 5 
    & valorMaquina = 5 
    & empty : JOGADOR 
    & jogadores = (JOGADOR - {empty}) 
    & bonus = {1 |->  [3,2,4], 2 |->  [1,4,5], 3 |->  [2,1, 4, 7], 4 |->  [3,2,1], 5 |->  [5,2,6], 6 |->  [4,7,1], 7 |->  [5,4,1,2,3]} // Na prática  { [3,2,4, 1], [1,4,5, 2], [2,1, 4, 7, 3], [3,2,1, 4], [5,2,6, 5], [4,7,1, 6], [5,4,1,2,3, 7] }
    
VARIABLES
    jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records, sequenciaAcertos
    
INVARIANT
    jogadorAtual : JOGADOR 
    & bolasAtuais : NAT 
    & pontuacaoAtual : NAT &estado : 0..5  
    & ranking : iseq( jogadores)  
    & cartao : jogadores --> NAT 
    & records : jogadores +-> NAT  
    & sequenciaAcertos : seq(NAT) 
    & !xx.(xx: NAT1 & xx < size(ranking) & estado=0 => records(ranking(xx)) >= records(ranking(xx+1)))
    
INITIALISATION
    jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records, sequenciaAcertos:= empty, 0, 0, 0, [], jogadores*{0},{}, []
    
OPERATIONS
    
    adicionarCredito(jj, cc) =
    PRE jj : jogadores & cc : NAT & cc > 0 & estado = 0
    THEN  cartao :=  cartao <+ {jj |-> (cc + cartao(jj))}
    END ;
    
    transferirCredito(j1, j2, cc) = 
    PRE j1 : jogadores & j2 : jogadores & cc : NAT1 & cc <= cartao(j1) & not (j1=j2) & estado =0 
    THEN  cartao :=  (cartao <+ {j1 |-> (cartao(j1) - cc)}) <+ {j2 |-> (cc + cartao(j2))}
    END ;
    
    iniciarPartida(jj) = 
    PRE jj : jogadores & cartao(jj) >= valorMaquina & jogadorAtual = empty & estado =0 
    THEN jogadorAtual := jj 
        || bolasAtuais := nBolas 
        || cartao :=  cartao <+ {jj |-> (cartao(jj) - valorMaquina)} 
        || estado := 1 
        || pontuacaoAtual := 0
    END ;
    
    finalizar = 
    PRE not(jogadorAtual = empty) & estado = 1 
    THEN jogadorAtual, estado, bolasAtuais, sequenciaAcertos:= empty, 2, 0, [] 
        || IF jogadorAtual /: dom(records)  THEN 
            records(jogadorAtual) := pontuacaoAtual 
        ELSE 
            records(jogadorAtual) := max({records(jogadorAtual), pontuacaoAtual}) 
        END 
        || IF jogadorAtual /: ran(ranking) THEN 
            ranking := ranking  <+ { size(ranking) +1 |-> jogadorAtual} 
        ELSE 
            ranking := ranking  <+ { ranking~(jogadorAtual) |-> jogadorAtual} 
        END
    END;
    
    perderBola = 
    PRE not(jogadorAtual = empty) & estado = 1 & bolasAtuais > 0
    THEN  
        bolasAtuais, sequenciaAcertos :=  bolasAtuais -1, []
    END;
    // Adicionar e ordenar o ranking
    
    pontuar(pp) = 
    PRE pp : 1..7 & not(jogadorAtual=empty) & bolasAtuais > 0
    THEN 	sequenciaAcertos := sequenciaAcertos <- pp ||
        IF size(sequenciaAcertos) >= card(bonus(pp)) THEN 
            IF rev(rev(sequenciaAcertos) /|\ card(bonus(pp))) = bonus(pp) THEN 
                pontuacaoAtual := pontuacaoAtual + pp*10 + 100 
            ELSE  pontuacaoAtual := pontuacaoAtual + pp*10  END 
        ELSE  pontuacaoAtual := pontuacaoAtual + pp*10 END
    END;
    
    rk <--  topN(nn)=
    PRE  nn : NAT1 & size(ranking) >= nn & estado /= 2
    THEN rk := % jg . (jg : NAT & jg : dom(ranking)  & jg <= nn | ranking(jg) ) // ranking /|\ nn
    END ;
    
    rk <-- posicaoRanking(pp)=
    PRE pp : jogadores & pp : ran(ranking) & estado /= 2
    THEN rk := ranking~(pp)
    END ;
    
    ordenarRanking = 
    PRE estado = 2
    THEN ANY oranking WHERE oranking : iseq( jogadores) & dom(oranking) = dom(ranking) & ran(ranking) = ran(oranking) & ! (ii, jj) . ( ii: ran(ranking) & jj: ran(ranking) & records(ii) >= records(jj) => oranking~(ii ) <= oranking~(jj)) 
        THEN ranking := oranking END || 
        estado := 0
    END
    
END
