require "test_helper"

class AllocationNewTest < ActiveSupport::TestCase
  
  test '.display_are? returns true if asker is inscrit' do
    #given
    allow_any_instance_of(ExtractAskerFromSession).to receive(:call).and_return(_subcribed_asker)
    #when
    res = AllocationNew.new(nil).display_are?
    #then
    assert_equal(true, res)
  end
  test '.display_are? returns false if asker is NOT inscrit' do
    #given
    allow_any_instance_of(ExtractAskerFromSession).to receive(:call).and_return(_unsubcribed_asker)
    #when
    res = AllocationNew.new(nil).display_are?
    #then
    assert_equal(false, res)
  end

  test '.display_ass? returns true if asker is inscrit' do
    #given
    allow_any_instance_of(ExtractAskerFromSession).to receive(:call).and_return(_subcribed_asker)
    #when
    res = AllocationNew.new(nil).display_ass?
    #then
    assert_equal(true, res)
  end
  test '.display_ass? returns false if asker is NOT inscrit' do
    #given
    allow_any_instance_of(ExtractAskerFromSession).to receive(:call).and_return(_unsubcribed_asker)
    #when
    res = AllocationNew.new(nil).display_ass?
    #then
    assert_equal(false, res)
  end

  def _subcribed_asker(existing_asker=nil)
    res = existing_asker || Asker.new
    res.v_duree_d_inscription = 'more_than_a_year'
    res
  end

  def _unsubcribed_asker(existing_asker=nil)
    res = existing_asker || Asker.new
    res.v_duree_d_inscription = 'non_inscrit'
    res
  end



end
