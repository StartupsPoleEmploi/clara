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
      it "#from_pe? should return true if IP is from PE" do
        fake_request = OpenStruct.new({remote_ip: "111.28.209.38"})
        expect(helper.from_pe?(fake_request)).to eq(true)
      end
      it "#from_pe? should return false if IP is NOT from PE" do
        fake_request = OpenStruct.new({remote_ip: "222.33.54.12"})
        expect(helper.from_pe?(fake_request)).to eq(false)
      end
    end    
    context 'ARA_URL_PE badly filled' do
      around do |example|
        ClimateControl.modify ARA_URL_PE: '' do
          example.run
        end
      end
      it "#from_pe? should return false, even if IP is from PE" do
        fake_request = OpenStruct.new({remote_ip: "111.28.209.38"})
        expect(helper.from_pe?(fake_request)).to eq(false)
      end
      it "#from_pe? should return false if IP is NOT from PE" do
        fake_request = OpenStruct.new({remote_ip: "222.33.54.12"})
        expect(helper.from_pe?(fake_request)).to eq(false)
      end
    end    
  end
end
