#language:pt

Funcionalidade: Meu Perfil
    Para que eu possa ter meus dados atualizados
    Sendo um usuário
    Posso completar o meu cadastro

    #Esquema do Cenario = Outlline
    @perfil @logout
    Esquema do Cenario: Atualizar meu perfil
        
        Dado que estou autenticado com "albert@teste.com" e "123456"
        E acesso meu perfil
        Quando completo meu cadastro com empresa "<empresa>" e "<cargo>"
        Então vejo a mensagem "Perfil atualizado com sucesso."

        Exemplos:
        | empresa        | cargo      |
        | QA Ninja       | Developer  |
        | Dotz           | QA         |
        | Microsoft      | CTO        |
        | Google         | Estagiário |
        | Dogão do Betão | CEO        |

