MACHINE Pinball_ProB

EXTENDS Pinball

CONSTANTS 
    /*JOGADOR */
     Marcel, Renan, Guilherme

PROPERTIES
    /* JOGADOR */
    Marcel:JOGADOR & Renan:JOGADOR & Guilherme:JOGADOR
        & JOGADOR = {Marcel, Renan, Guilherme, empty} 
        & card(JOGADOR) = 4
END