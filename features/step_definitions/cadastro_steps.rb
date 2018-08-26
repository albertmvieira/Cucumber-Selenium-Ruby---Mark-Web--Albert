Dado("que eu acessei a página de cadastro") do
    #Comando visit abre o navegador e acessa uma url
    visit 'https://marktasks.herokuapp.com/register'
    expect(page).to have_content 'Criar uma conta Mark'
end
  
Dado("possuo os seguintes dados:") do |table|
    # criei a variavel tabela cadastro com @ para ser enxergada em todo os cenários
    # comando .rows_hash => transforma a tabela em um objeto hash (igual array)
    # comando puts imprime no console
    puts @cadastro = table.rows_hash
end
  
Quando("faço o meu cadastro") do
  #------ Sem Page Object ------------------
  # fill in ..., with: => preencha com (vai preencher o campo com os dados passados) funciona quando o campo tem 'id' ou 'name' no html
  # Estavamos usando sem pag object ... com pagem object a implementação esta na classe cadastro
  fill_in 'register_name', with: @cadastro['Nome']
  fill_in 'register_email', with: @cadastro['Email']
  #fill_in 'register_password', with: @cadastro['Senha']
  # exemplo caso o campo senha não tiversse id nem name poderiamos montar um css e manda pelo comando find
  find('input[type=password]').set @cadastro['Senha']

  # Click_button => Comando do capybara que procura um botão com este nome(valor) para clicar (não recomendado, pois caso vire multilinguagem o texto quebra)
  #click_button 'Cadastrar'
  find('button[type=submit]').click
end
  
Então("sou redirecionado para o meu painel de tarefas") do
    expect(page).to have_content 'Todas as minhas tarefas'
end
  
Então("devo ver uma mensagem de alerta {string}") do |mensagem_alerta|
    expect(page).to have_content mensagem_alerta
end