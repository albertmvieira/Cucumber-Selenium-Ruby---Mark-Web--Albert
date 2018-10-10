class CadastroPage < SitePrism::Page

    set_url '/register'
    element :subtitulo_page, '.header-title small'
    element :input_nome, '#register_name'
    element :input_email, '#register_email'
    element :input_password, 'input[type=password]'
    element :botao_cadastrar, 'button[type=submit]'
    element :alert , '.alert-message'

    def cadastro_user(dados_user)
        input_nome.set dados_user['Nome']
        input_email.set dados_user['Email']
        input_password.set dados_user['Senha']
        botao_cadastrar.click
    end

end