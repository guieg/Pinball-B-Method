MACHINE Pinball

SETS
    JOGADOR

CONSTANTS         
    nBolas, valorMaquina, empty, jogadores

PROPERTIES
    nBolas = 5 & valorMaquina = 5 & empty : JOGADOR & jogadores = (JOGADOR - {empty})

VARIABLES
   jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records

INVARIANT
    jogadorAtual : JOGADOR & bolasAtuais : NAT & pontuacaoAtual : NAT &estado : 0..5  & ranking : iseq(records)  & cartao : jogadores --> NAT & records : jogadores +-> NAT 

INITIALIZATION
    jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records:= empty, 0, 0, 0, [ ], jogadores*{0},{}

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
	THEN jogadorAtual, estado, bolasAtuais:= empty, 0, 0 || 
		records(jogadorAtual) := IF jogadorAtual /: dom(records)  THEN pontuacaoAtual ELSE  max({records(jogadorAtual), pontuacaoAtual}) END
	END ;

perderBola = 
	PRE not(jogadorAtual = empty) & estado = 1 & bolasAtuais > 0
	THEN  
		IF bolasAtuais = 1  THEN  jogadorAtual, estado, bolasAtuais := empty, 0, 0 || 
			records(jogadorAtual) := IF jogadorAtual /: dom(records)  THEN pontuacaoAtual ELSE  max({records(jogadorAtual), pontuacaoAtual}) END
		ELSE bolasAtuais :=  bolasAtuais -1 END
	END;

pontuar(pp) = 
	PRE pp : 1..7 & not(jogadorAtual=empty) & bolasAtuais > 0
	THEN pontuacaoAtual := pontuacaoAtual + pp //melhorar implementação e atualizar ranking
	END;


rk <--  topDez=
  	PRE size(ranking) >= 10
  	THEN rk := ranking /|\ 10
  	END;

rk <-- posicaoRanking(pp)=
	PRE pp : NAT & size(ranking)>=pp
  	THEN rk := ranking(pp)
  	END


END
