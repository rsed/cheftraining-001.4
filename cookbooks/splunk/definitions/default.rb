define :set_user do
 user params[:name] do
  action :create
  shell "/bin/bash"
 end 
log "User #{user params[:name]} created"
end 
