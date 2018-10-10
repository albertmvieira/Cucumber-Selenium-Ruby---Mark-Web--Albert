
class LoginPage < SitePrism::Page
    
    #set_url = comando do SitePrism para armazenar url que será chamada no load no step correspondente
    #como a URL foi definida no env.rb agora só é necessário passar a rota (/ é a rota principal) .
    set_url '/'
    element :input_email, '#login_email'
    element :input_senha, 'input[type=password]'
    #utilizando expressão regular * informando para procurar um id que CONTENHA btLogin (id dinâmico)
    element :botao_logar, 'button[id*=btLogin]'
    element :alert, '.alert-login'
    
    #button[id*=btnLogin] * = contem 
    #button[id^=btnLogin] ^ = começa com
    #button[id$=btnLogin] $ = termina com

    def logar(email, senha)
        input_email.set email
        input_senha.set senha
        botao_logar.click
    end
    
end