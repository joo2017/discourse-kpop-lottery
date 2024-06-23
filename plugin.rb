# name: discourse-kpop-lottery
# about: A plugin for K-pop forum lottery
# version: 0.1
# authors: Your Name
# url: https://github.com/yourusername/discourse-kpop-lottery

enabled_site_setting :kpop_lottery_enabled

after_initialize do
  load File.expand_path('../app/controllers/kpop_lottery_controller.rb', __FILE__)

  Discourse::Application.routes.append do
    post '/kpop-lottery/start' => 'kpop_lottery#start'
    post '/kpop-lottery/draw' => 'kpop_lottery#draw'
  end
end
