
RSpec::Matchers.define :eq_with_units do |expected_phys_units|
  match do |phys_units|
    phys_units.value.should be_within(0.01).of(expected_phys_units.value)
    phys_units.unit.should eq expected_phys_units.unit
  end

  failure_message_for_should do |phys_units|
    "Expected: #{phys_units.to_s} but was #{expected_phys_units.to_s}"
  end
end
