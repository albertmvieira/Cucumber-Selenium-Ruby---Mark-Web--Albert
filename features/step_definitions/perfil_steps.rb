Dado("que estou autenticado com {string} e {string}") do |email, senha|
    @login.load #carrega a url setada na classe
    @login.logar(email, senha)
end
  
Dado("acesso meu perfil") do
    @tasks.nav.menu_usuario.click
    @tasks.nav.meu_perfil.click
end
  
Quando("completo meu cadastro com empresa {string} e {string}") do |empresa, cargo|
    @perfil.atualiza(empresa, cargo)
end
  
Então("vejo a mensagem {string}") do |mensagem|
    expect(@perfil.formulario).to have_content mensagem
end