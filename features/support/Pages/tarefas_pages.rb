require_relative 'sections'

class Adicionar < SitePrism::Section
    element :input_titulo, 'input[name=title]'
    element :input_data, 'input[name=dueDate]'
    element :input_tags, '.bootstrap-tagsinput input'
    element :salvar, '#form-submit-button'
    element :mensagem, '.alert-warn'

    #metodo recebendo tarefa (possui chave e valor)
    def nova(tarefa, tags)
        input_titulo.set tarefa['titulo'] #usando a tarefa[chave]para setar o valor de titulo e data
        input_data.set tarefa['data']

        #foreach para percorrer o array de tags passando a variavel tag que representará um item de cada vez
        tags.each do |tag|
            input_tags.set tag['tag']
            #comando para emular o tab do teclado para continuar inserindo tags
            input_tags.send_keys :tab
            sleep 0.5 #think time \o/
        end
        salvar.click     
    end

end

class TarefasPage < SitePrism::Page
    
    #criado seção (recurso do siteprism) para navbar pois ela não é uma página e esta acessível a todos
    # nome da sessão :nav (reperesentado pela classe Navbar (passando o id master da do menu navbar))
    section :nav, Navbar, '#navbar'
    #section criada para a subpagina de Adicionar tarefa
    section :adicionar, Adicionar, '#add-task-view'

    element :confirma_modal, 'button[data-bb-handler=success]'
    element :cancela_modal, 'button[data-bb-handler=danger]'

    element :conteudo_pagina, '#tasks-view'

    element :titulo, '.header-title h3'
    element :botao_novo, '#insert-button'
    element :campo_busca, 'input[name=search]'
    element :botao_busca, '#search-button'

    element :table_body, 'table tbody'

    #criado "elements" para receber um conjunto de informações (array) da tabela
    elements :itens, 'table tbody tr'


    #metodo para buscar (pesquisar) uma tarefa criada
    def busca(titulo)
        campo_busca.set titulo
        botao_busca.click
    end

    #metodo para remover a primeira tarefa
    def apaga_primeiro_item
        @tasks.itens.first.find('#delete-button').click
    end

    #metodo para remover tarefa por nome
    def apagar_por_titulo(titulo)
        itens.each do |linha|
            if linha.text.include?(titulo)
                linha.find('#delete-button').click
            end
        end
    end

end