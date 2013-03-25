require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe 'string concat' do
#     it 'concats two strings with spaces' do
#       helper.concat_strings('this','that').should == 'this that'
#     end
#   end
# end
describe ApplicationHelper do

  describe '#anchor_tag' do
    it 'returns an anchor tag' do
      expect(helper.anchor_tag('MyTag')).to eq("<a class=\"anchor_tag\" name=\"MyTag\">&nbsp;</a>")
    end
  end

  describe '#icon_tag' do
    it 'returns an icon_tag' do
      expect(helper.icon_tag('icon-pencil')).to eq("<i class=\"icon-pencil\"></i>")
    end
  end

  describe '#boolean_icon' do
    it 'returns a boolean_icon for true' do
      expect(helper.boolean_icon(true)).to eq("<i class=\"icon-check\"></i>")
    end
    it 'returns a boolean_icon for false' do
      expect(helper.boolean_icon(false)).to eq("<i class=\"icon-check-empty\"></i>")
    end
  end

  describe '#friendly_timestamp' do
    it 'returns a friendly_timestamp' do
      expect(helper.friendly_timestamp(Time.parse('2012-02-02 12:30 PM'))).to eq("02 Feb 12:30 pm")
    end
  end

  describe '#timeago' do
    it 'returns a timeago time tag' do
      expect(helper.timeago(Time.parse('2012-02-02 12:30 PM'))).to eq("<time class=\"timeago\" datetime=\"2012-02-02T11:30:00Z\">02 Feb 12:30 pm</time>")
    end
  end
end
