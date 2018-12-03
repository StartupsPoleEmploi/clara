describe ApplicationHelper, type: :helper do
  def helper
    # See https://stackoverflow.com/a/322501/2595513
    Class.new.send(:include, ApplicationHelper).new
  end
  describe "#empty_image" do
    it "returns an empty image" do
      expect(helper.empty_image).to eq("data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=")
    end
  end
  describe '#from_pe?' do
    context 'ARA_URL_PE properly filled' do
      around do |example|
        ClimateControl.modify ARA_URL_PE: '111.28.209.37,111.28.209.38,111.28.209.39' do
          example.run
        end
      end
      context 'Remote IP is from PE' do
        it "#from_pe? Should return true" do
          expect(helper.from_pe?).to eq(true)
        end
      end
      context 'Remote IP is NOT from PE' do
        it "#from_pe? Should return false" do
          expect(helper.from_pe?).to eq(false)
        end
      end   
    end    
  end
end
