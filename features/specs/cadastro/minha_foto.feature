#language:pt

Funcionalidade: Minha foto
    Para que meu Perfil fique muito bonito
    Sendo um usuário cadastrado 
    Posso fazer upload da minha foto

    @auth @foto @logout
    Cenario: Carregar minha foto

        Dado eu tenho uma foto muito bonita
        E acesso meu perfil
        Quando faço o upload da minha foto
        Então devo ver a mensagem de upload com o texto "Agora seu perfil está bem legal."