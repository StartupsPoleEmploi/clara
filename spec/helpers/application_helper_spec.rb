describe ApplicationHelper, type: :helper do
  describe "#empty_image" do
    it "returns an empty image" do
      # See https://stackoverflow.com/a/322501/2595513
      helper = Class.new.send(:include, ApplicationHelper).new
      expect(helper.empty_image).to eq("data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=")
    end
  end
end
