require 'spec_helper'

describe User do

  # test the standard normalization of attributes
  it { should normalize_attribute(:first)  }
  it { should normalize_attribute(:middle) }
  it { should normalize_attribute(:last) }
  it { should normalize_attribute(:message) }
  it { should normalize_attribute(:email) }

end
