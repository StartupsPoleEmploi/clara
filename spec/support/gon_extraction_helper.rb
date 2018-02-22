module GonExtractionHelper
  def string_between_markers str, marker1, marker2
    str[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
  end

  def after_first_equal(str)
    a  = str.match /(?<==).*/
    a.to_a[0]
  end

  def extract_gon(str)
   gon = Hash.new

   str['//<![CDATA['] = ''
   str['//]]>'] = ''
   str['window.gon={};'] = ''
   str.strip
   str
   .split(';')
   .map{|e| e.strip}
   .reject{|e| e.empty?}
   .each{ |e| e['gon.'] = 'gon_' }
   .each do |e| 
      the_index = string_between_markers(e, 'gon_', '=')
      gon[the_index] = JSON.parse after_first_equal(e)
    end  

    gon
  end
end

RSpec.configure do |config|
  config.include GonExtractionHelper, type: :feature
end
