require 'spec_helper'

describe Span do

  # be sure the factory is valid
  it 'has a valid factory' do
    create(:span).should be_valid
  end

  describe 'should validate' do

    # test the standard normalization of attributes
    it { should normalize_attribute(:name) }
    it { should normalize_attribute(:description) }

    # test validations
    it { should_not accept_values_for(:name, nil) }
    it { should_not accept_values_for(:user, nil) }
    it { should_not accept_values_for(:billable, nil, 'hello', 3.4) }
    it { should_not accept_values_for(:start_at, nil, 'xyzpdq') }
    it { should_not accept_values_for(:end_at, nil, 'xyzpdq') }
    it { should_not accept_values_for(:hourly_rate, nil, 'abc', 1.345) }


    # uniqueness is a special validation because you need
    # more then one record to test it. So, the pattern
    # for uniqueness validation is:                                                                                                                            describe Span do
    context 'and reject if span with same time exists' do

      before :each do
        @span = create(:span, start_input: '10am', end_input: '11am')
      end

      # we should be able to create a span for another user in the same time span
      it { should accept_values_for(:start_input, '10:15am') }

      it 'should not accept a span for the same user in the same time period' do
        @new_span = build(:span, user: @span.user, start_input: '10:15am', end_input: '10:45am')
        @new_span.should_not be_valid
      end

      it 'should not accept a span whose start is after its end' do
        @span.update(start_input: '10:45am', end_input: '10:15am')
        @span.should_not be_valid
      end

    end
  end

  # test the named scopes for ordering and searching
  describe 'when a span is searched or sorted' do

    before :each do
      @span1 = create(:span, name: 'Apple Picking', start_input: '10am', end_input: '11am')
      @span2 = create(:span, name: 'Zebra Ranching', start_input: 'yesterday 8pm', end_input: 'yesterday 9pm')
      @span3 = create(:span, name: 'Banana Picking', start_input: '4:00', end_input: '5:00')
    end

    it 'should be listed in descending order of start_at' do
      @spans = Span.order_by_start_at
      @spans.first.should == @span3
      @spans.last.should == @span2
    end

    it 'should be listed in ascending name order' do
      @spans = Span.order_by_name
      @spans.first.should == @span1
      @spans.last.should == @span2
    end

    it 'should return only entries excluding a span_id' do
      Span.excluding(@span1.id).count.should < Span.count
    end
  end

end