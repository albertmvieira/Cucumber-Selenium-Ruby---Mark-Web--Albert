require_relative 'sections'

class PerfilPage < SitePrism::Page

    set_url '/user_settings/profile' #definida URL para usar como se fosse usuario acessando direto do favoritos

    #criado seção (recurso do siteprism) para navbar pois ela não é uma página e esta acessível a todos
    # nome da sessão :nav (representado pela classe Navbar (passando o id master da do menu navbar))
    section :nav, Navbar, '#navbar'

    element :input_empresa, 'input[name$=company]'
    element :combo_cargo, 'select[name$=job]'
    element :salvar, '#form-submit-button'
    element :formulario, '#user-settings-profile-edit-form'

    def atualiza(empresa, cargo)
        input_empresa.set empresa
        #recurso do capybara para selecionar uma opção dentro de um campo de lista
        #para o campo de combo box usei o seguinte recurso
        #da um .find na variavel e na option busca o texto comparando com o cargo vindo da variavel e pede para seleciona .select_option
        combo_cargo.find('option', text: cargo).select_option               
        salvar.click   
    end

    def upload(foto)
        #recurso do capybara para anexar arquivo passando o elemento - tem que ser com id ou name do elemento
        attach_file('profile-avatar', foto)
    end

end