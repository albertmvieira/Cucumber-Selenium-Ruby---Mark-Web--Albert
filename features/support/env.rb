require 'selenium-webdriver'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'site_prism'
require 'faker'
require 'httparty'

#não verificar SSL (resolver o erro de certificado SSL)
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#Configuração global do Proxy da rede
HTTParty::Basement.http_proxy('proxy', 'port', 'user', 'pass')

#variavel env grava o valor de variavel de ambiente BROWSER que foi criado no cucumber.yaml
$env = ENV['BROWSER']
$headless = ENV['HEADLESS']
$ie = ENV['Internet']

#config para usar poltergeist como driver do capybara e selenium caso seja setado como headless
#js_errors: false) - ignora erros de javascript caso ocorra
if $headless
    Capybara.register_driver :selenium do |app|
        Capybara::Poltergeist::Driver.new(app, js_errors: false)
    end
end

#Baixar IEDriver e validar implementação
if $ie
    Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(:internet_explorer)
    end
end

#Config capybara para firefox, chrome e chrome_headless
Capybara.configure do |config|
    if $env == 'chrome'
        config.default_driver = :selenium_chrome
    elsif $env == 'chrome_headless'
        config.default_driver = :selenium_chrome_headless   
    else
        config.default_driver = :selenium
    end
    #definindo URl padrão
    config.app_host = 'https://marktasks.herokuapp.com'
end

Capybara.default_max_wait_time = 5

#Para configuração default_driver podemos utilizar os paramtros:
# :selenium => Firefox
# :selenium_chorme => Chrome
# :selenium_chorme_headless => Chrome Headless