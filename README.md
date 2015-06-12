== README

require 'factual'

class HomeController < ApplicationController
  def index
    @results = Location.order(:name).page params[:page]
  end

  def import
    factual = Factual.new("Aev9HGqqyKn6XSkuLNKzETx4F75WlairtUq0To69", "kl30cssbwJmF2QKFTC3dAGRKdp5E0VIRe3cjiVFa")

      @total_counts = factual.table("places-us").search("PepBoys").total_count.to_i/20

      @total_counts.times do |i|
        p "*******************************"
        p i
        p "*******************************"
        begin
          @results = factual.table("places-us").search("PepBoys").page(i, :per => 20)

          @results.each do |result|      
            @location = Location.where(
              address: result['address'],
              category_labels: result['category_labels'],
              country: result['country'],
              latitude: result['latitude'],
              longitude: result['longitude'],
              name: result['name'],
              post_code: result['postcode'],
              region: result['region'],
              telephone: result['tel'],
              website: result['website'],
              locality: result['locality'],
            ).first_or_initialize

            @location.save
          end
        rescue => e
          p "Exception in row: #{i}: #{e.message}"
        end
      end

      redirect_to root_path
  end

end
---------------

index.html.eb
--------------------  
<table class=table table-stripped>
  <tr>
    <th>Address</th>
    <th>category labels </th>
    <th>country</th>
    <th>Latitude</th>
    <th>Longitude</th>
    <th>name</th>
    <th>postcode</th>
    <th>region</th>
    <th>Telephone</th>
    <th>website</th>
    <th>Locality</th>
  </tr>
  <% @results.each do |result| %>
  <tr>
    <td><%= result['address'] %></td>
    <td><%= result['category_labels']%></td>
    <td><%= result['country']  %></td>
    <td><%= result['latitude']  %></td>
    <td><%= result['longitude']  %></td>
    <td><%= result['name']%></td>
    <td><%= result['postcode'] %></td>
    <td><%=result['region'] %></td>
    <td><%=result['tel'] %></td>
    <td><%=result['website'] %></td>
    <td><%=result['locality'] %></td>
  </tr>
  <%end%>
</table>
<br/><br/>


<%= paginate @results %>
----------------------------
routes
-----------
 root 'home#index'
  resources :home, only: [:index] do
    collection do
      get :import
    end
  end