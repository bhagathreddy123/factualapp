require 'factual'

namespace :fetch do
  namespace :factual do
    desc "fetch factual locations (can only fetch 500 records with free version)"
    task :locations => :environment do
      factual = Factual.new("U0R66iT0MPqYMi4UOCnRO8ecVnJBUHdIKn2dQwjt", "RrsoQA2924YBJQ2vmD9LAcEB2GFjtqIgIWjTtznK")

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
              postcode: result['postcode'],
              region: result['region'],
              tel: result['tel'],
              website: result['website'],
              locality: result['locality'],
            ).first_or_initialize

            @location.save
          end
        rescue => e
          p "Exception in row: #{i}: #{e.message}"
        end
      end
    end
  end
end