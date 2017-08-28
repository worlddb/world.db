
module WorldDB::Service

class Server < Sinatra::Base

  PUBLIC_FOLDER = "#{WorldDB::Service.root}/lib/worlddb/service/public"
  VIEWS_FOLDER  = "#{WorldDB::Service.root}/lib/worlddb/service/views"

  puts "[debug] worlddb-service - setting public folder to: #{PUBLIC_FOLDER}"
  puts "[debug] worlddb-service - setting views folder to: #{VIEWS_FOLDER}" 
  
  set :public_folder, PUBLIC_FOLDER   # set up the static dir (with images/js/css inside)   
  set :views,         VIEWS_FOLDER    # set up the views dir

  set :static, true   # set up static file routing

  #####################
  # Models

  include WorldDB::Models

  ##############################################
  # Controllers / Routing / Request Handlers

  get '/' do
    erb :index
  end


  get '/countries.?:format?' do
    # todo: remove .all why? why not?
    data = data_for_countries( Country.by_key.all )

    format = params[:format] || 'json'

    render_data( data, format )
  end


  get '/cities.?:format?' do
    # todo: remove .all why? why not?
    data = data_for_cities( City.by_key.all )

    format = params[:format] || 'json'

    render_data( data, format )
  end


  get '/tag/:part' do   # e.g. /tag/north_america.txt
  
    ##############
    # NB:
    #  get '/tag/:key.?:format?'
    #   will NOT work - key is greedy and will include the optional format part
  
    # split part into slug/key and optional format
    slug, format = params[:part].split('.')
    format ||= 'json'
  
    data = data_for_countries( Tag.find_by_slug!( slug ).countries )

    render_data( data, format )
  end


  get '/d*' do
    erb :debug
  end


  private

=begin
  def csv_content_type
    case request.user_agent
    when /windows/i then 'application/vnd.ms-excel'
    else                 'text/csv'
    end
  end
=end

  def data_for_cities( cities )
    ## fix: move to model? why? why not?
    
    ## add virtual column like kind for metro, metro|city, city, district
  
    ## todo add region.title if present  
  
    data = []
    cities.each do |city|
      data << { key:      city.key,
                title:    city.title,
                code:     city.code,
                pop:      city.pop,
                popm:     city.popm,
                area:     city.area,
                synonyms: city.synonyms,
                country:  city.country.title }      
    end # each city
    data
  end

  def data_for_countries( countries )
    ## fix: move to model? why? why not?  
  
    ## todo: add tags too??
    
    data = []
    countries.each do |country|
      data << { key:      country.key,
                title:    country.title,
                code:     country.code,
                pop:      country.pop,
                area:     country.area,
                synonyms: country.synonyms }
    end # each country
    data  
  end
  
  
  def csv_for_data( data )
    ## :col_sep => "\t"
    ## :col_sep => ";"

    ## todo: use rec.key for headers/first row
    
    csv_string = CSV.generate() do |csv|
      data.each do |rec|
        csv << rec.values
      end
    end
    csv_string
  end # method csv_for_data


  def table_for_data( data )
    buf = ""
    buf << "<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'></head><body>\n"
    buf << "<table>\n"
    data.each do |rec|
      buf << "  <tr>"
      rec.values.each do |value|
        buf << "<td>#{value}</td>"
      end
      buf << "</tr>\n"
    end
    buf << "</table>\n"
    buf << "</body></html>"
    buf
  end # method table_for_data

### helper for json or jsonp response (depending on callback para)

def json_or_jsonp( data )
  callback = params.delete('callback')
  response = ''

  if callback
    content_type :js
    response = "#{callback}(#{data.to_json})"
  else
    content_type :json
    response = data.to_json
  end
  
  response
end


  def render_data( data, format )
    if format == 'csv' || format == 'txt'
      headers 'Content-Type' => 'text/plain; charset=utf-8'
      csv_for_data( data )
    elsif format == 'html' || format == 'htm'
      headers 'Content-Type' => 'text/html; charset=utf-8'
      table_for_data( data )
    else
      json_or_jsonp( data )
    end
  end


end # class Server


end #  module WorldDB::Service