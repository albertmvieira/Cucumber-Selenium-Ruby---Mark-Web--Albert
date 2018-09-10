Before do
    #Acessando API criada para limpar o cadastro do usuario
    visit 'https://marktasks.herokuapp.com/api/reset/albert@rerun.io?clean=full'

    #Instanciando classes no hook para que todos steps definitions possam enxergar e não precise instanciar dentro de cada um deles
    @login = LoginPage.new
    @tasks = TarefasPage.new
    @perfil = PerfilPage.new

  #comando capybara para ajustar tamanho minimo da janela do browser caso necessário
  #usar quando necessário ou software precisar se adequar ao padrão de tela especifico
  #page.current_window.resize_to(1280, 800)

end

Before('@auth') do
    @login.load #carrega a url setada na classe
    @login.logar('albert@teste.com', '123456') #chamando o metodo logar do LoginPage passando email e senha
end

# After tageado será executado somente nos cenários que tiverem esta tag e após execução
After('@logout') do
    @tasks.nav.bye
end

After('@perfil_logout') do
    @perfil.nav.bye
end