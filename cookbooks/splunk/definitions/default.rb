define :set_user do
 user params[:name] do
  action :create
  shell "/bin/bash"
 end 
end 
