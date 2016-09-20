namespace :api do
  desc "API Routes"
  task :routes => :environment do


      API.routes.each do |api|
        method = api.request_method.ljust(10)
        path = api.path.gsub(":version", api.version)
        desc = api.description
        puts "     #{method} #{path}  ----  #{desc}"
      end

    #end
  end
end