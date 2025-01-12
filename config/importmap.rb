# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap" # @5.3.3
# https://github.com/rails/importmap-rails/issues/65#issuecomment-2049989937g
pin "@popperjs/core", to: "@popperjs--core-2.11.8.manual.js" # @2.11.8
pin "dropzone" # @6.0.0
pin "just-extend" # @5.1.1
pin "flatpickr" # @4.6.13
pin "@rails/activestorage", to: "@rails--activestorage.js" # @8.0.100
