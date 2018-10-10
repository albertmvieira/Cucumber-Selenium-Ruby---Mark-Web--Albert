class Helpers

    #metodo para fazer login pela api e pegar o token para poder acessar a tarefa
    def login(email, senha)
        #Não precisei criar a variavel result como váriavel de instância pois será utilizada somente dentro do metodo
        result = HTTParty.post(
            'https://marktasks.herokuapp.com/api/login',
            headers: {'Content-Type' => 'application/json'},
            body: {email: email, password: senha}.to_json #body com informações de hash ruby convertendo para json
        )
        #return do metodo com informações do response contem dentro de data informações do token
        return result.parsed_response['data']
    end   

    def remover_tarefa(token, titulo)
        
        #Criando variavel de instância headers para armazenar o header que será utilizado mais de uma vez
        @headers = {
            'Content-Type' => 'application/json',
            'X-User-id' => token['userId'], 
            'X-Auth-Token' => token['authToken']
        }

        @result = HTTParty.get(
            'https://marktasks.herokuapp.com/api/tasks',
            headers: @headers
        )
        #@tasks recebe todo o conteudo da lista de tarefas
        @tasks = @result.parsed_response['data']

        #percorrer array para pegar a task correta para apagar
        @tasks.each do |t|
            if t['title'] == titulo
                @id_remover = t['_id']
                #Utilizando API de deleção para remover a task pelo id
                HTTParty.delete(
                'https://marktasks.herokuapp.com/api/tasks/' + @id_remover,
                headers: @headers
                )
            end
        end
    end
    
    def back_to_the_past(email)
        #Acessando API criada para limpar o cadastro do usuario
        HTTParty.get("https://marktasks.herokuapp.com/api/reset/#{email}?clean=full")    
    end
end