class ListBrokenLinks

  def call
    l = ListAidLinks.new.call
    a = l.reduce([]){|memo, e| memo.concat(e[:links])}
    uniq_links = a.uniq
    links_not_to_check = uniq_links.filter{|e| e.start_with?('https://candidat.pole-emploi.fr') && e.size > 'https://candidat.pole-emploi.fr/'.size}
    links_to_check = uniq_links - links_not_to_check
    
    broken_links = links_to_check.reject.each_with_index do |e, ix| 
      res = false
      timestamp = DateTime.now.strftime('%H:%M:%S')
      begin
        Timeout::timeout(7) do
          is_url_valid = UrlExists.new.call(e)
          ap "#{timestamp}, #{ix}, #{is_url_valid}, #{e}"
          res = is_url_valid
        end      
      rescue Timeout::Error
        ap "#{timestamp}, #{ix}, #{e} timedout"
      end
      res
    end

    broken_links
  end
  
end
