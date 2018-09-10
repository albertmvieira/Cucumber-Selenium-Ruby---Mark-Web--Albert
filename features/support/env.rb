require 'selenium-webdriver'
require 'capybara'
require 'capybara/cucumber'
require 'site_prism'
require 'faker'

#Config capybara para firefox, chrome e chrome_headless
Capybara.configure do |config|
    config.default_driver = :selenium_chrome
    #definindo URl padrão (recurso do capybara)
    config.app_host = 'https://marktasks.herokuapp.com'
end

Capybara.default_max_wait_time = 5