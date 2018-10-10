Dado("que eu acessei a página de cadastro") do
    #usando o load para carregar a url setada na classe pelo set_url
    @cadastro.load
    expect(@cadastro.subtitulo_page.text).to eql 'Criar uma conta Mark7'
end
  
Dado("possuo os seguintes dados:") do |table|
    # comando .rows_hash => transforma a tabela em um objeto hash (igual array)
    @table_cadastro = table.rows_hash
    #chamando a instancia da classe helpers com o metodo de apagar uma conta passando a variavel table_cadastro objeto  ['Email']
    @helpers.back_to_the_past(@table_cadastro['Email'])
end
  
Quando("faço o meu cadastro") do
    @cadastro.cadastro_user(@table_cadastro)
end
  
Então("sou redirecionado para o meu painel de tarefas") do
    @tasks.wait_for_table_body
    expect(@tasks.titulo.text).to eql 'Painel de Atividades'
end
  
Então("devo ver uma mensagem de alerta {string}") do |mensagem_alerta|
    expect(@cadastro.alert.text).to have_content mensagem_alerta
end