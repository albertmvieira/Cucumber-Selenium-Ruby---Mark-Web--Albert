Dado("que eu tenho uma tarefa com os atributos:") do |table|
    @tarefa = table.rows_hash
    #Retirado o faker e fazendo apagar a tarefa pela API - assim não precisa cadastrar com faker
    #@tarefa['titulo'] = @tarefa['titulo'] + ' ' + Faker::Lorem.characters(10) #concatenando informações, prática muito ruim  que não é muito utilizada. A mais utilizada é com interpolação de strings
    #Usando interpolação de strings necessário colocar entre chaves e utilizar o hashtag antes
    @tarefa['titulo'] = "#{@tarefa['titulo']} - #{Faker::Lorem.characters(10)}"
    puts @tarefa #imprimindo tarefa para ver como foi montado (Chave e valor)
  end
  
  Dado("eu quero taguear esta tarefa com:") do |table|
    @tags = table.hashes #Comando para montar um array (neste caso precisou pois precisamos inserir cada tag individualmente)
    puts @tags #imprimindo tags para ver como o array foi montado (primeira linha será o titulo)
  end

  Dado("eu já cadastrei esta tarefa e não tinha percebido") do                  
    @tasks.botao_novo.click
    @tasks.adicionar.nova(@tarefa, @tags) 
  end
  
  Quando("faço o cadastro desta tarefa") do
    @tasks.botao_novo.click
    @tasks.adicionar.nova(@tarefa, @tags)
  end
  
  Então("devo ver este cadastro com status {string}") do |status_tarefa|
    @tasks.wait_for_itens # espera carregar o elemento de itens (a tabela na tela)
    expect(@tasks.itens.first).to have_content status_tarefa #valida a primeira posição do array, neste caso porque sabemos que sempre cadastra em primeiro

    @tasks.busca(@tarefa['titulo'])
    puts @tasks.itens.size #pegar o tamanho da variavel itens (array criado com a tabela de tasks)

    expect(@tasks.itens.size).to eql 1 #valida que esteja exibindo apenas uma task com este titulo, após fazer a busca na tela
  end                                                                       
                                                                                
  Então("devo ver a mensagem {string} ao tentar fazer o cadastro") do |mensagem|  
    expect(@tasks.adicionar.mensagem.text).to eql mensagem
  end
  
  # --------------- --Remover Tarefas --------------------------------------

  Dado("que eu tenho uma tarefa cadastrada") do
    #variavel tarefa_para_remover recebe titulo e data, virando um hasd do ruby (array)
    @tarefa_para_remover = {
      'titulo' => "Tarefa muito legal para remover - #{Faker::Lorem.characters(10)}",
      'data' => '01/12/2018'
    }
    #criado a variavel tags como um array vazio (pois o foco não é cadastrar então cadastrara sem tags)
    @tags = []
    
    #imprimindo variaveis para ver o tipo que assumiram
    puts @tarefa_para_remover
    puts @tags

    @tasks.botao_novo.click
    @tasks.adicionar.nova(@tarefa_para_remover, @tags)
  end
  
  Quando("eu solicito a exclusão desta tarefa") do
    @tasks.wait_for_itens

    #Apagando primeira tarefa da lista:
    #@tasks.apaga_primeiro_item

    #chamando metodo apagar por titulo passando a variavel @tarefa_para_remover com o item titulo
    @tasks.apagar_por_titulo(@tarefa_para_remover['titulo'])
    sleep 1 #think time do usuario lendo modal
  end
  
  Quando("confirmo a solicitação") do
    @tasks.confirma_modal.click
  end

  Quando("cancelo a solicitação") do
    @tasks.cancela_modal.click
  end
  

  Então("esta tarefa não deve ser exibida na lista") do
    
    #validando através do botão de busca da pagina
    #@tasks.busca(@tarefa_para_remover['titulo'])
    #expect(@tasks.conteudo_pagina).to have_content 'Hmm... nenhuma tarefa encontrada :('

    #validando percorrendo a lista na tela
    @tasks.wait_for_itens
    expect(@tasks.itens).not_to have_content @tarefa_para_remover['titulo']

    #com selenium puro
    #resultado = @tasks.itens.include?(@tarefa_para_remover['titulo'])
    #expect(resultado).to be false
  end

  Então("esta tarefa permanece cadastrada na lista") do
    @tasks.busca(@tarefa_para_remover['titulo'])
    expect(@tasks.itens.first).to have_content @tarefa_para_remover['titulo']
  end
