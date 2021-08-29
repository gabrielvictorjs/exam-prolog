esquerda(X, Y, [X | [Y | _]]).
esquerda(X, Y, [_ | Lista]) :- esquerda(X, Y, Lista).
vizinho(X, Y, Lista) :- esquerda(X, Y, Lista); esquerda(Y, X, Lista).

resolver :-
    Casas = [Casa1, Casa2, Casa3, Casa4, Casa5],
    
    % casa(cor, nacionalidade, bebida, cigarro, animal)

    % dica 1: O noruegues vive na primeira casa.
    Casas = [
        casa(_, noruegues, _, _, _),
        _,
        _,
        _,
        _
    ],

    % dica 2: O Ingles vive na casa Vermelha.
    member(casa(vermelha, ingles, _, _, _), Casas),

    % dica 3: O Sueco tem Cachorros como animais de estimacao.
    member(casa(_, sueco, _, _, cachorros), Casas),

    % dica 4: O Dinamarques bebe Cha.
    member(casa(_, dinamarques, cha, _, _), Casas),

    % dica 5: A casa Verde fica do lado esquerdo da casa Branca.
    esquerda(casa(verde, _, _, _, _), casa(branca, _, _, _, _), Casas),

    % dica 6: O homem que vive na casa Verde bebe Cafe.
    member(casa(verde, _, cafe, _, _), Casas),

    % dica 7: O homem que fuma Pall Mall cria Passaros.
    member(casa(_, _, _, pallmall, passaros), Casas),

    % dica 8: O homem que vive na casa Amarela fuma Dunhill.
    member(casa(amarela, _, _, dunhill, _), Casas),

    % dica 9: O homem que vive na casa do meio bebe Leite.
    Casas = [
        _,
        _,
        casa(_, _, leite, _, _),
        _,
        _
    ],

    % dica 10: O homem que fuma Blends vive ao lado do que tem Gatos.
    vizinho(casa(_, _, _, blends, _), casa(_, _, _, _, gatos), Casas),

    % O homem que cria Cavalos vive ao lado do que fuma Dunhill.
    vizinho(casa(_, _, _, _, cavalos), casa(_, _, _, dunhill, _), Casas),

    % O homem que fuma BlueMaster bebe Cerveja.
    member(casa(_, _, cerveja, bluemaster, _), Casas),

    % O Alemao fuma Prince.
    member(casa(_, alemao, _, prince, _), Casas),

    % O Noruegues vive ao lado da casa Azul.
    vizinho(casa(azul, _, _, _, _), casa(_, noruegues, _, _, _), Casas),

    % O homem que fuma Blends eh vizinho do que bebe Agua.
    vizinho(casa(_, _, _, blends, _), casa(_, _, agua, _, _), Casas),

    % Algum homem cria Peixes
    member(casa(_, _, _, _, peixes), Casas),

    nl, write('RESULTADO'), nl,
    nl, write('primeira '), print(Casa1), nl,
    nl, write('segunda '), print(Casa2), nl,
    nl, write('terceira '), print(Casa3), nl,
    nl, write('quarta '), print(Casa4), nl,
    nl, write('quinta '), print(Casa5), nl.
