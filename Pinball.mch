MACHINE Pinball

SETS
    JOGADOR

CONSTANTS         
    nBolas, valorMaquina, empty

PROPERTIES
    nBolas = 5 & valorMaquina = 5 & empty : JOGADOR

VARIABLES
   jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records

INVARIANT
    jogadorAtual : JOGADOR & bolasAtuais : NAT & pontuacaoAtual : NAT &estado : 0..5  & ranking : iseq(records)  & cartao : JOGADOR <-> NAT & records : JOGADOR <-> NAT 

INITIALIZATION
    jogadorAtual, bolasAtuais, pontuacaoAtual, estado, ranking, cartao, records:= empty, 0, 0, 0, [ ], JOGADOR *{0},{}

OPERATIONS

adicionarCredito(jj, cc) =
	PRE jj : JOGADOR & cc : NAT & cc > 0
	THEN  cartao :=  cartao <+ {jj |-> (cc + cartao(jj))}
	END ;

transferirCredito(j1, j2, cc) = 
	PRE j1 : JOGADOR & j2 : JOGADOR & cc : NAT1 & cc <= cartao(j1) & not (j1=j2)
	THEN  cartao :=  (cartao <+ {j1 |-> (cartao(j1) - cc)}) <+ {j2 |-> (cc + cartao(j2))}
	END ;

iniciarPartida(jj) = 
	PRE jj : JOGADOR & cartao(jj) >= valorMaquina & jogadorAtual = empty
	THEN jogadorAtual := jj || bolasAtuais := nBolas || cartao :=  cartao <+ {jj |-> (cartao(jj) - valorMaquina)} || estado := 1 || pontuacaoAtual := 0
	END ;

desistir = 
	PRE not(jogadorAtual = empty) & estado = 1
	THEN jogadorAtual, pontuacaoAtual, estado := empty, 0, 0 //adicionar atualização de recorde
	END ;

pontuar(pp) = 
	PRE pp : 1..7 & not(jogadorAtual=empty) & bolasAtuais > 0
	THEN pontuacaoAtual := pontuacaoAtual + pp //melhorar implementação e atualizar ranking
	END

END
