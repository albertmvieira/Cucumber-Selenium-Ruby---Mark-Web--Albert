Before do     
    #Instanciando classes no hook para que todos steps definitions possam enxergar e não precise instanciar dentro de cada um deles
    @login = LoginPage.new
    @tasks = TarefasPage.new
    @perfil = PerfilPage.new
    @cadastro = CadastroPage.new
    @helpers = Helpers.new

  #comando capybara para ajustar tamanho minimo da janela do browser caso necessário
  #usar quando necessário ou software precisar se adequar ao padrão de tela especifico
  #page.current_window.resize_to(1280, 800)
end 

Before('@auth') do
    #Retirado 
    @email = 'albert@teste.com'
    @senha = '123456'
    @login.load #carrega a url setada na classe
    @login.logar(@email, @senha) #chamando o metodo logar do LoginPage passando email e senha
    @token = @helpers.login(@email, @senha) #Chamando o metodo logar do helpers que logará na api e armazenando o return do metodo na variavel @token
end

# After tageado será executado somente nos cenários que tiverem esta tag e após execução
After('@logout') do
    @tasks.nav.bye
end

After('@perfil_logout') do
    @perfil.nav.bye
end

# Pegar as propriedades do cenário para poder gerar o print
After do |scenario|
    #o comando .tr é para substituição, neste caso os espaços vazios por _ (Assim deixamos o nome sem espaço em branco para não dar erro no sistema operacional)
    # e passando comando downcase! para deixar em caixa baixa
    nome_cenario =  scenario.name.tr(' ', '_').downcase!
    
    #gsub - substring do ruby com regex para substituir caracteres especiais por nada e não dar problema ao salvar print de cenário outline (esquema do cenario)
    nome_cenario = nome_cenario.gsub(/([_@#!%()\-=;><,{}\~\[\]\.\/\?\"\*\^\$\+\-]+)/, '')
    
    #montando a estrutura para montar o screeshot com o caminho, nome do cenario e extensão
    screenshot = "logs/shots/#{nome_cenario}.png"
  
    #recurso do capybara para salvar screenshot
    page.save_screenshot(screenshot)
  
    #recurso do cucumber embed para anexar um screenshot no relatório
    #variavel, tipo da imagem, e texto que sera exibido para acesso ao print
    embed(screenshot, 'image/png', 'Clique para ver a evidência!')
  end