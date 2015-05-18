assets = ["login.css", "print.css"]
dir = Rails.root.join('app/assets/javascripts/', '*.{coffee}')

Dir[dir].each do |d|
  basename = File.basename(d)
  assets << basename.gsub('.coffee', '')
end

assets << "google/google-chart.js"

Rails.application.config.assets.precompile += assets 
