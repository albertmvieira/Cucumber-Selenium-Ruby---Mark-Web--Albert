Quando("faço login com {string} e {string}") do |email, senha|
    
    #Criado variavel de instância para guardar o valor de email
    @email = email

    @login.load #carrega a url setada na classe
    @login.logar(email, senha)
    
end
  
Então("sou autenticado com sucesso") do
    #Após a criação da section foi alterado pois agora @tasks herda de da nav e consegue enxergar seus elementos
    #expect(@nav.menu_usuario.text).to eql @email         #------ antes da criação da section
    expect(@tasks.nav.menu_usuario.text).to eql @email
end
  
Então("vejo o meu painel de atividades") do
    expect(@tasks.titulo.text).to eql "Painel de Atividades" 
end
   
Então("devo ver a mensagem {string}") do |msg_alerta|
    expect(@login.alert.text).to eql msg_alerta
end

Então("não sou autenticado") do
    #Valida se o elemento não existe na pagina - has_no_titulo? é um recurso do SitePrism
    #puts @tasks.has_no_titulo? #para debugar o que retorna utilizar o puts e ver o que imprime
    expect(@tasks.has_no_titulo?).to be false
  end