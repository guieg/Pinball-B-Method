MACHINE Pinball

SETS
    JOGADOR; CARTAO

CONSTANTS         
    nBolas, valorMaquina, empty

PROPERTIES
    nBolas = 5 & valorMaquina = 5.0 & empty : JOGADOR

VARIABLES
   jogadorAtual, bolasAtuais, estado, ranking

INVARIANT
    jogadorAtual : JOGADOR & bolasAtuais : NAT & estado : 0..5  & ranking : iseq(JOGADOR)

INITIALIZATION
    jogadorAtual, bolasAtuais, estado, ranking:= empty, 0, 0, [ ] 

END
