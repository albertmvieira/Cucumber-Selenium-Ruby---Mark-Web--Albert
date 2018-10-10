class Navbar < SitePrism::Section
    
    element :menu_usuario, 'a[href="/user_settings dropdown-toggle"]'
    #pesquisando pelo elemento pai que tem id e depois pegando as características do filho 
    element :meu_perfil, '#navbar a[href="/user_settings"]'
    element :sair, 'a[href$=logout]'

    def bye
        menu_usuario.click
        sair.click
    end
    
end