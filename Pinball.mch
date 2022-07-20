MACHINE Pinball
    
CONSTANTS         
    jogador, nBolas, valorMaquina, empty, jogadores, bumpers, bonus
    
PROPERTIES
    jogador = 0..7
    & nBolas = 5 
    & valorMaquina = 5 
    & empty = 0
    & empty : jogador
    & jogadores = 1..7
    & bumpers = 1..7
    & bonus = {0 |-> 0, 1 |-> 9, 2 |-> 10, 3 |-> 14, 4 |-> 4, 5 |-> 13, 6 |->  12, 7 |-> 15}
    
    
    
VARIABLES
    jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records, sequenciaAcertos
    
INVARIANT
    jogadorAtual : jogador 
    & bolasAtuais : NAT 
    & bolasAtuais < 6
    & pontuacaoAtual : NAT 
    & estado : 0..5  
    & ranking : iseq( jogadores)  
    & cartao : jogadores --> NAT 
    & records : jogadores +-> NAT  
    & sequenciaAcertos : seq(NAT) 
    & !xx.(xx: NAT1 & xx < size(ranking) & estado=0 => records(ranking(xx)) >= records(ranking(xx+1)))
    
INITIALISATION
    jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records, sequenciaAcertos:= empty, 0, 0, 0, [], jogadores*{0},{}, []
    
    
OPERATIONS
    adicionarCredito(jj, cc) =
    PRE jj : jogadores & cc : NAT & cc > 0 & estado = 0 & cartao(jj) < MAXINT
    THEN  cartao :=  cartao <+ {jj |-> min({cc + cartao(jj), MAXINT})}
    END ;
    
    transferirCredito(j1, j2, cc) = 
    PRE j1 : jogadores & j2 : jogadores & cc : NAT1 & cc <= cartao(j1) & not (j1=j2) & estado =0 & cartao(j2) < MAXINT
    THEN  cartao :=  (cartao <+ {j1 |-> (cartao(j1) - cc)}) <+ {j2 |-> min({cc + cartao(j2), MAXINT})}
    END ;
    
    iniciarPartida(jj) = 
    PRE jj : jogadores & cartao(jj) >= valorMaquina & jogadorAtual = empty & estado =0 
    THEN jogadorAtual := jj 
        || bolasAtuais := nBolas 
        || cartao :=  cartao <+ {jj |-> (cartao(jj) - valorMaquina)} 
        || estado := 1 
        || pontuacaoAtual := 0
    END ;
    
    pontuar(pp) = 
    PRE pp : bumpers & not(jogadorAtual=empty) & bolasAtuais > 0 & pontuacaoAtual < MAXINT
    THEN     sequenciaAcertos := sequenciaAcertos <- pp ||
        IF size(sequenciaAcertos) >= 4 THEN 
            IF SIGMA (xx) . (xx : ran(rev(sequenciaAcertos) /|\ 4) | xx) = bonus(pp) THEN
                pontuacaoAtual := min({pontuacaoAtual + pp*10 + 100, MAXINT})
            ELSE  pontuacaoAtual := min({pontuacaoAtual + pp*10, MAXINT}) END 
        ELSE  pontuacaoAtual := min({pontuacaoAtual + pp*10, MAXINT}) END
    END; 
    
    
    
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
    
    rk <-- posicaoRanking(pp)=
    PRE pp : jogadores & pp : ran(ranking) & estado /= 2
    THEN rk := ranking~(pp)
    END;
    
    ordenarRanking = 
    PRE estado = 2
    THEN ANY oranking WHERE oranking : iseq( jogadores) & dom(oranking) = dom(ranking) & ran(ranking) = ran(oranking) & ! (ii, jj) . ( ii: ran(ranking) & jj: ran(ranking) & records(ii) > records(jj) => oranking~(ii ) < oranking~(jj)) 
        THEN ranking := oranking END || 
        estado := 0
    END
    
END