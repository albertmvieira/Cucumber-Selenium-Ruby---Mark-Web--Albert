Dado("que eu tenho uma tarefa com os atributos:") do |table|
    @tarefa = table.rows_hash
    #Usando interpolação de strings
    #Retirado o faker e fazendo apagar a tarefa pela API - assim não precisa cadastrar com faker
    #@tarefa['titulo'] = "#{@tarefa['titulo']} #{Faker::Lorem.characters(10)}"# table is a Cucumber::MultilineArgument::DataTable
    puts @tarefa #imprimindo tarefa para ver como foi montado (Chave e valor)
  end
  
  Dado("eu quero taguear esta tarefa com:") do |table|
    @tags = table.hashes #Comando para montar um array (neste caso precisou pois precisamos inserir cada tag individualmente)
    puts @tags #imprimindo tags para ver como o array foi montado (primeira linha será o titulo)
  end
  
  Quando("faço o cadastro desta tarefa") do
    @tasks.botao_novo.click
    @tasks.adicionar.nova(@tarefa, @tags)
  end
  
  Então("devo ver este cadastro com status {string}") do |string|
    pending # Write code here that turns the phrase above into concrete actions
  end