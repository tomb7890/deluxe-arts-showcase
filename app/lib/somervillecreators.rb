require 'mechanize'
baseurl='http://somervilleartscouncil.org'
mainurl = baseurl + '/porchfest/2021'
agent=Mechanize.new
page=agent.get(mainurl)

allnodes = [] 

def grab_nodes_of_page(page, allnodes)
  nodes=page.links.select{|l| l.href =~ /\/node\/\d\d\d\d\d/ }
  nodes.each do |n|
    unless  allnodes.include? n.href
      puts "Storing node #{n.href}" 
      allnodes << n.href
    end
  end
end

grab_nodes_of_page(page, allnodes)

def fetch_next_page(page)
  selection = page.links.select{|l| l.attributes['title'].include?('next page') if l.attributes.keys.include? 'title'  }
  if selection.size == 1
    return selection[0]
  end
  return nil
end

count = 0 

while true
  el = fetch_next_page(page)
  if el.nil?
    break
  end
  nexturl = baseurl + el.href
  page = agent.get(nexturl)

  puts el.href
  
  grab_nodes_of_page(page, allnodes)
  count = count + 1 

  if count  > 1
    break
  end
end

allnodes.each do |n|
  fulladdress = baseurl + n
  puts "Now trying for node page " + fulladdress 
  page = agent.get(fulladdress)
  unless page.nil?
    results = page.search('div.views-field.views-field-field-band-description')
    if results.size > 0

      artist_name = page.search('.views-field.views-field-title').text
      
      hits = page.search('div.views-field-field-porchfest-image img')
      if hits.size > 0 
        artist_image =  hits[0]['src']
        # puts "Artist Image:  #{artist_image}"
      end

      results = page.search('div.views-field.views-field-field-band-website > div > a')
      if results.size > 0
        artist_website = results[0] 
        puts "Website: #{artist_website.text}"
        puts "The href:: #{        artist_website['href'] }"



      end


      artist_genres = page.search('div.views-field.views-field-taxonomy-vocabulary-5 > div').text
      # puts "Artist Genres:  #{artist_genres}"
      
    end

    
  end
end




