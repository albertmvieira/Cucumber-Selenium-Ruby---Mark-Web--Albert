Dado("que estou autenticado com {string} e {string}") do |email, senha|
    @login.load
    @login.logar(email, senha)
    
    @tasks.wait_for_table_body #wait_for Recurso do SitePrism para esperar um elemento que ainda não foi carregado na tela
end
  
Dado("acesso meu perfil") do
    #@perfil.load # =>  user acessa via URL (favoritos) ---

    # usuario acessa via link do menu superior
    @tasks.nav.menu_usuario.click
    @tasks.nav.meu_perfil.click
end
  
Quando("completo meu cadastro com empresa {string} e {string}") do |empresa, cargo|
    @perfil.atualiza(empresa, cargo)
end
  
Então("vejo a mensagem {string}") do |mensagem|
    expect(@perfil.formulario).to have_content mensagem
end

# Upload foto

Dado("eu tenho uma foto muito bonita") do
    #File.join = recurso do ruby
    #Dir.pwd = indentificar que esta no diretorio local de execução do cucumber
    @minha_foto = File.join(Dir.pwd, 'features/support/fixtures/albert.jpg')
end

Quando("faço o upload da minha foto") do
    @perfil.upload(@minha_foto)
end

Então("devo ver a mensagem de upload com o texto {string}") do |mensagem|
    expect(@perfil.formulario).to have_content mensagem
end