require "test_helper"

class DetectBrokenLinksTest < ActiveSupport::TestCase
  
  test '.call' do
    #given
    old_saved_link = _old_saved_link

    allow_any_instance_of(ListBrokenLinks).to receive(:call).and_return(_list_of_new_unsaved_links)

    #when
    result = DetectBrokenLinks.new.call
    #then
    assert_nil(Broken.find_by(id: old_saved_link.id))
    assert_equal(2, Broken.all.count)
  end

  def _old_saved_link
    Broken.new(
      url: 'https://example.com/redirected', 
      code: '302', 
      new_url: 'https://example.com/new_url', 
      aids_slug: ['aide-mobilite', 'aide-enfant'].to_json
    ).tap(&:save!)
  end

  def _list_of_new_unsaved_links
    [
      Broken.new(
        url: 'https://foo.com/redirected', 
        code: '302', 
        new_url: 'https://foo.com/new_url', 
        aids_slug: ['aide-region','aide-international'].to_json
      ),
      Broken.new(
        url: 'https://qix.com/redirected', 
        code: '404', 
        aids_slug: ['aide-deplacement'].to_json
      )
    ]
  end

end
