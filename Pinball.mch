MACHINE Pinball

SETS
    JOGADOR

CONSTANTS         
    nBolas, valorMaquina, empty, jogadores, bonus

PROPERTIES
    nBolas = 5 & valorMaquina = 5 & empty : JOGADOR & jogadores = (JOGADOR - {empty}) 
	& bonus = {1 |->  [3,2,4], 2 |->  [1,4,5], 3 |->  [2,1, 4, 7], 4 |->  [3,2,1], 5 |->  [5,2,6], 6 |->  [4,7,1], 7 |->  [5,4,1,2,3]} // Na prática  { [3,2,4, 1], [1,4,5, 2], [2,1, 4, 7, 3], [3,2,1, 4], [5,2,6, 5], [4,7,1, 6], [5,4,1,2,3, 7] }

VARIABLES
   jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records, sequenciaAcertos

INVARIANT
    jogadorAtual : JOGADOR & bolasAtuais : NAT & pontuacaoAtual : NAT &estado : 0..5  & ranking : iseq( jogadores)  
	& cartao : jogadores --> NAT & records : jogadores +-> NAT  & sequenciaAcertos : seq(NAT)

INITIALIZATION
    jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records, sequenciaAcertos:= empty, 0, 0, 0, [ ], jogadores*{0},{}, []

OPERATIONS

adicionarCredito(jj, cc) =
	PRE jj : jogadores & cc : NAT & cc > 0
	THEN  cartao :=  cartao <+ {jj |-> (cc + cartao(jj))}
	END ;

transferirCredito(j1, j2, cc) = 
	PRE j1 : jogadores & j2 : jogadores & cc : NAT1 & cc <= cartao(j1) & not (j1=j2)
	THEN  cartao :=  (cartao <+ {j1 |-> (cartao(j1) - cc)}) <+ {j2 |-> (cc + cartao(j2))}
	END ;

iniciarPartida(jj) = 
	PRE jj : jogadores & cartao(jj) >= valorMaquina & jogadorAtual = empty
	THEN jogadorAtual := jj || bolasAtuais := nBolas || cartao :=  cartao <+ {jj |-> (cartao(jj) - valorMaquina)} || estado := 1 || pontuacaoAtual := 0
	END ;

desistir = 
	PRE not(jogadorAtual = empty) & estado = 1 & bolasAtuais > 0
	THEN jogadorAtual, estado, bolasAtuais, sequenciaAcertos:= empty, 0, 0, [] || 
		records(jogadorAtual) := IF jogadorAtual /: dom(records)  THEN pontuacaoAtual ELSE  max({records(jogadorAtual), pontuacaoAtual}) END ||
		ranking := ranking  <+ { IF jogadorAtual /: ran(ranking) THEN size(ranking) +1 ELSE ranking~(jogadorAtual) END |-> jogadorAtual}
// Adicionar e ordenar o ranking
//|| 
		//ranking := IF jogadorAtual /: dom(records)  THEN ranking <- {jogadorAtual, pontuacaoAtual} ELSE  ranking  <+ {
//((ranking |> {{jogadorAtual  |-> records(jogadorAtual)}})~)({jogadorAtual, records(jogadorAtual)}) |-> {jogadorAtual |-> pontuacaoAtual}
//}
// END
	END;

perderBola = 
	PRE not(jogadorAtual = empty) & estado = 1 & bolasAtuais > 0
	THEN  
		IF bolasAtuais = 1  THEN  jogadorAtual, estado, bolasAtuais, sequenciaAcertos := empty, 0, 0, [] || 
			records(jogadorAtual) := IF jogadorAtual /: dom(records)  THEN pontuacaoAtual ELSE  max({records(jogadorAtual), pontuacaoAtual}) END
		ELSE bolasAtuais, sequenciaAcertos :=  bolasAtuais -1, [] END
	END;
// Adicionar e ordenar o ranking

pontuar(pp) = 
	PRE pp : 1..7 & not(jogadorAtual=empty) & bolasAtuais > 0
	THEN 	sequenciaAcertos := sequenciaAcertos <- pp || 
		pontuacaoAtual := pontuacaoAtual + pp*10 + 
			IF size(sequenciaAcertos) >= card(bonus(pp)) 
			THEN IF rev(rev(sequenciaAcertos) /|\ card(bonus(pp))) = bonus(pp) THEN 100 ELSE 0 END 
			ELSE 0 END
	END;

rk <--  topN(nn)=
  	PRE size(ranking) >= nn & nn : NAT1
  	THEN rk := % jg . (jg : jogadores & jg : ran(ranking)  & ranking~(jg)<= nn | {ranking~(jg), records(jg) })// ranking /|\ nn
  	END;

rk <-- posicaoRanking(pp)=
	PRE pp : jogadores & pp : ran(ranking)
  	THEN rk := ranking~(pp)
  	END


END
