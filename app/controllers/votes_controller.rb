class VotesController < ApplicationController
  def action
    response = params[:response]
    client_id = response[:id]
    item_id = params[:item_id]
    action = params[:button]
    today = Time.now.strftime("%Y-%m-%d")
    if Client.exists?(client_id)
      if Vote.where(client_id: client_id, item_id: item_id, date: today).exists?
        case action
        when "like"
          # Delete the vote and show prompt
        when "aviso"
          if Vote.where(client_id: client_id, item_id: item_id, date: today, aviso: true).exists?
            # Cange aviso = false and show prompt
          else
            # Cange aviso = true and show prompt
            Vote.where(client_id: client_id, item_id: item_id).update_all(aviso: false)
            Vote.where(client_id: client_id, item_id: item_id, date: today).first.update_attribute(:aviso, true)
          end
        end
      else
        insert(item_id, client_id, today, action)
      end
    else
      name = response[:name]
      address = response[:location][:name]
      born_date = response[:birthday]
      gender = response[:gender]
      email = response[:email]
      # Create the client
      # redirect_to controller: :clients, action: 'create', id: client_id, name: name, address: address, born_date: born_date, gender: gender, email: email and return
      Client.create(id: client_id, name: name, address: address, born_date: born_date, gender: gender, email: email)
      # flash[:notice] = 'Client added!'
      insert(item_id, client_id, today, action)
    end
  end

  def insert(item_id, client_id, today, action)
    case action
    when "like"
      # Insert the vote with aviso = false and show prompt
      Vote.create(item_id: item_id, client_id: client_id, date: today, aviso: false)
    when "aviso"
      # Insert the vote with aviso = true and show prompt
      Vote.create(item_id: item_id, client_id: client_id, date: today, aviso: true)
    end
    # puts "\n\n\n\n\n\n\n\n\n\nHa llegado abajo\n\n\n\n\n\n\n\n\n\n"
    item = Item.find(item_id)
    item.increment!("votes", 1)
    ActionCable.server.broadcast('items_channel', id: item.id, votes: item.votes)
  end
end
