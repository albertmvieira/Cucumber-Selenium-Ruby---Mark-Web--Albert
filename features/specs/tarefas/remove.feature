#language: pt

Funcionalidade: Remover tarefa
    Para que eu possa organizar minhas atividades
    Sendo um usuário cadastrado
    Posso excluir uma tarefa indesejada

    @auth @remover @logout @smoke
    Cenario: Remover uma tarefa indesejada

        Dado que eu tenho uma tarefa cadastrada
        Quando eu solicito a exclusão desta tarefa
        E confirmo a solicitação
        Então esta tarefa não deve ser exibida na lista

    @auth @cancela @logout
    Cenario: Desistir da remoção

        Dado que eu tenho uma tarefa cadastrada
        Quando eu solicito a exclusão desta tarefa
        E cancelo a solicitação
        Então esta tarefa permanece cadastrada na lista
