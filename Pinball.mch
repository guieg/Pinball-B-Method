MACHINE Pinball

SETS
    JOGADOR

CONSTANTS         
    nBolas, valorMaquina, empty

PROPERTIES
    nBolas = 5 & valorMaquina = 5.0 & empty : JOGADOR

VARIABLES
   jogadorAtual, bolasAtuais, estado, ranking, cartao

INVARIANT
    jogadorAtual : JOGADOR & bolasAtuais : NAT & estado : 0..5  & ranking : iseq(JOGADOR)  & cartao : JOGADOR <-> NAT 

INITIALIZATION
    jogadorAtual, bolasAtuais, estado, ranking, cartao:= empty, 0, 0, [ ], JOGADOR *{0} 

OPERATIONS

adicionarCredito(jj, cc) =
	PRE jj : JOGADOR & cc : NAT & cc > 0
	THEN  cartao :=  cartao <+ {jj |-> (cc + cartao(jj))}
	END ;

transferirCredito(j1, j2, cc) = 
	PRE j1 : JOGADOR & j2 : JOGADOR & cc : NAT1 & cc <= cartao(j1) & not (j1=j2)
	THEN  cartao :=  (cartao <+ {j1 |-> (cartao(j1) - cc)}) <+ {j2 |-> (cc + cartao(j2))}
	END

END
