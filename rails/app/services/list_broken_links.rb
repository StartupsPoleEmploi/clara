class ListBrokenLinks

  def call
    f = Faraday.new do |faraday|
      faraday.ssl[:verify] = false
    end
    l = ListAidLinks.new.call
    a = l.reduce([]){|memo, e| memo.concat(e[:links])}
    uniq_links = a.uniq
    links_not_to_check = uniq_links.filter do |e| 
      is_front_connection = e.start_with?('https://candidat.pole-emploi.fr') && e.size > 'https://candidat.pole-emploi.fr/'.size 
      is_back_connection = e.start_with?('https://authentification-candidat.pole-emploi.fr')
      is_front_connection || is_back_connection
    end

    links_to_check = uniq_links - links_not_to_check
    
    problematic_links = links_to_check.map.each_with_index do |e, ix| 
      res = nil
      timestamp = DateTime.now.strftime('%H:%M:%S')
      begin
        Timeout::timeout(7) do
          faraday_answer = f.head(e)
          ap "#{timestamp}, #{ix}, #{faraday_answer.status}, #{e}"
          if faraday_answer.status == 200
            res = nil
          else
            is_redirection = faraday_answer.status == 301 || faraday_answer.status == 302
            res = {url: e, code: faraday_answer.status, new_url: is_redirection ? faraday_answer.env.response_headers['location'] : ''}
          end
        end      
      rescue Timeout::Error
        ap "#{timestamp}, #{ix}, #{e} timedout"
        res = {url: e, code: 408}
      end
      res
    end

    broken_links = problematic_links.reject{|e| e == nil}

    broken_links_with_aids = broken_links.map do |e|
      aids_concerned = l.filter{|k| k[:links].include?(e[:url])}
      e[:aids_slug] = aids_concerned.map{|y| y[:aid_slug]}
      e
    end

    broken_links_with_aids
  end
  
end
