require 'spec_helper'
require 'industry'

describe Industry do
  it 'should simulate industry' do
    expect { Universe.simulate! }.not_to raise_error
  end
end
