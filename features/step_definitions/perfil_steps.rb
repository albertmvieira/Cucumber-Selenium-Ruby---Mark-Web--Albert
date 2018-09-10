Dado("que estou autenticado com {string} e {string}") do |email, senha|
    @login.load #carrega a url setada na classe
    @login.logar(email, senha)
    
    @tasks.wait_for_table_body #wait_for Recurso do SitePrism para esperar um elemente que ainda não foi carregado na tela  e será carregado a partir da ação anterior
end
  
Dado("acesso meu perfil") do
    #@perfil.load # =>  user acessa via URL (favoritos)

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