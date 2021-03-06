module SomervilleCreators
  
  require 'mechanize'
  def grab_nodes_of_page(page, allnodes)
    nodes=page.links.select{|l| l.href =~ /\/node\/\d\d\d\d\d/ }
    nodes.each do |n|
      unless  allnodes.include? n.href
        puts "Storing node #{n.href}" 
        allnodes << n.href
      end
    end
  end

  def fetch_next_page(page)
    selection = page.links.select{|l| l.attributes['title'].include?('next page') if l.attributes.keys.include? 'title'  }
    if selection.size == 1
      return selection[0]
    end
    return nil
  end

  def getallnodes(agent, page, baseurl)
    allnodes = [] 
    
    grab_nodes_of_page(page, allnodes)
    pagecount = 0 

    while true
      el = fetch_next_page(page)
      if el.nil?
        break
      end
      nexturl = baseurl + el.href
      page = agent.get(nexturl)

      puts el.href
      
      grab_nodes_of_page(page, allnodes)
      pagecount = pagecount + 1 

      if pagecount  > 11
        break
      end
    end

    allnodes
  end


  def getallcreators
    baseurl='http://somervilleartscouncil.org'
    mainurl = baseurl + '/porchfest/2021'
    agent=Mechanize.new
    page=agent.get(mainurl)

    
    artists = []
    getallnodes(agent, page, baseurl).each do |n|
      fulladdress = baseurl + n
      puts "Now trying for node page " + fulladdress 
      page = agent.get(fulladdress)
      unless page.nil?
        artist = {} 
        # look for band's title 
        results = page.search('.views-field.views-field-title')
        if results.size > 0
          artist['name'] = results[0].text

          results = page.search('div.views-field.views-field-field-band-description')
          if results.size > 0
            artist['description'] = results[0].text
            puts "Bio: #{artist['description']}"
          end
          
          hits = page.search('div.views-field-field-porchfest-image img')
          if hits.size > 0 
            artist['image'] =  hits[0]['src']
            puts "Artist Image:  #{artist['image']}"
          end

          results = page.search('div.views-field.views-field-field-band-website > div > a')
          if results.size > 0
            artist_website = results[0]
            puts "Website: #{artist_website.text}"
            puts "The href:: #{        artist_website['href'] }"
            artist['website'] = artist_website['href'] 
          end

          artist_genres = page.search('div.views-field.views-field-taxonomy-vocabulary-5 > div').text
          puts "Artist Genres:  #{artist_genres}"
          artist['genres'] = artist_genres
        end

        artists << artist 
      end
    end
    artists 
  end
end 
