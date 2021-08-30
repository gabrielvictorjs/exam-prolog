:- dynamic
([
    tamanho_do_mundo/1,
    ouro_atual/1,
    posicao_wumpus/2,
    posicao_ouro/2,
    ouro_coletado/2,
    ouro_maximo/1,
    posicao_abismo/2,
    posicao_x/1,
    posicao_y/1
]).

reiniciar :-
    retractall(tamanho_do_mundo(_)),
    retractall(ouro_atual(_)),
    retractall(posicao_wumpus(_, _)),
    retractall(posicao_ouro(_, _)),
    retractall(ouro_coletado(_, _)),
    retractall(ouro_maximo(_)),
    retractall(posicao_abismo(_, _)),
    retractall(posicao_x(_)),
    retractall(posicao_y(_)).

iniciar :-
    reiniciar,
    nl, writeln('Bem-vindo ao Mundo de Wumpus'), nl,
    nl, writeln('Seu objetivo eh encontrar ouro e voltar vivo para a entrada'), nl,
    writeln('Movimentos possiveis: mover_para_cima; mover_para_esquerda; mover_para_baixo; mover_para_direita;'),
    assert(tamanho_do_mundo(5)),
    assert(ouro_atual(0)),
    assert(posicao_wumpus(2, 4)),
    assert(posicao_ouro(3, 3)),
    assert(posicao_ouro(1, 4)),
    assert(posicao_abismo(4, 4)),
    assert(ouro_maximo(200)),
    alterar_posicao(1, 1).

resolver :-
    mover_para_direita;
    mover_para_direita;
    mover_para_direita;
    mover_para_direita;
    mover_para_baixo;
    mover_para_baixo;
    mover_para_esquerda;
    mover_para_esquerda;
    mover_para_cima;
    mover_para_cima;
    mover_para_esquerda;
    mover_para_esquerda.

mover_para_cima :-
    writeln('Moveu para cima'),
    posicao_x(LXC),
    posicao_y(LYC),
    NovaPosicao is LXC - 1,
    caminha(NovaPosicao, LYC).

mover_para_esquerda :-
    writeln('Moveu para esquerda'),
    posicao_x(LXE),
    posicao_y(LYE),
    NovaPosicao is LYE-1,
    caminha(LXE, NovaPosicao).

mover_para_direita :-
    writeln('Moveu para direita'),
    posicao_x(LXD),
    posicao_y(LYD),
    NovaPosicao is LYD + 1,
    caminha(LXD, NovaPosicao).

mover_para_baixo :-
    writeln('Moveu para baixo'),
    posicao_x(LXB),
    posicao_y(LYB),
    NovaPosicao is LXB + 1,
    caminha(NovaPosicao, LYB).

tem_wumpus(X, Y) :-
    posicao_wumpus(X, Y).

tem_abismo(X, Y) :-
    posicao_abismo(X, Y).

caminha(X, Y):-
    (
        (not(checar_posicao(X, Y)) -> writeln('Voce bateu em uma parede!'));
        (
            (checar_posicao(X, Y)) ->
                (alterar_posicao(X, Y)),
                ((
                    (tem_wumpus(X, Y) -> (writeln('Wumpus matou voce!!!!'), iniciar));
                    (tem_abismo(X, Y) -> (writeln('Voce caiu em um abismo e morreu!!!!'), iniciar))
                );
                (
                    checar_novo_ecossistema(X, Y),
                    checar_ouro_proximo(X, Y),
                    mostrar_ouros,
                    checar_vitoria -> (
                        nl, writeln('!!!VOCE VENCEU!!!'), nl,
                        writeln('Reiniciando o jogo!!!'),
                        iniciar
                    )
                ))
        )
    ).

checar_posicao(X, Y) :- (X >= 1), (X =< 5), (Y >= 1), (Y =< 5).

alterar_posicao(X, Y) :-
    retractall(posicao_x(_)),
    retractall(posicao_y(_)),
    assert(posicao_x(X)),
    assert(posicao_y(Y)),
    write('Sua nova posicao: (X:'), write(Y), write(', Y:'), write(X), writeln(').').

checar_novo_ecossistema(X, Y):-
    ZX1 is X + 1,
    ZX2 is X - 1,
    ZY1 is Y + 1,
    ZY2 is Y - 1,
    (((tem_wumpus(X, ZY1); tem_wumpus(X, ZY2); tem_wumpus(ZX1, Y); tem_wumpus(ZX2, Y))
        -> writeln('Voce sentiu algum cheiro horrivel aqui!')); true),
    (((tem_abismo(X, ZY1); tem_abismo(X, ZY2); tem_abismo(ZX1, Y); tem_abismo(ZX2, Y))
        -> writeln('Voce sentiu uma brisa aqui!')); true).

checar_ouro_proximo(X, Y):-
    (((posicao_ouro(X, Y), not(ouro_coletado(X, Y))) ->
        (
            writeln('Voce encontrou ouro, volte para a entrada e ganhe o jogo!!!'),
            ouro_atual(OUR),
            assert(ouro_coletado(X, Y)),
            ValorOuro is OUR + 100,
            retractall(ouro_atual(_)),
            assert(ouro_atual(ValorOuro))
        )); true).

checar_vitoria:-
    posicao_x(1),
    posicao_y(1),
    ouro_atual(OUR),
    ouro_maximo(OUR2),
    OUR >= OUR2.

mostrar_ouros:-
    ouro_atual(OUR),
    write('Agora voce possui '), 
    write(OUR), 
    writeln(' ouros.'), nl, nl.
