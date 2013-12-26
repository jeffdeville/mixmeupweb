require 'spec_helper'

describe FatSecretService::Transformer do
  describe ".call" do
    let(:fs_alcohol_hash) {
      {

      }
    }
    let(:alcohol_hash) { subject.call(fs_alcohol_hash) }

    it "should map the alcohol completely" do
      expect(alcohol_hash[:proof]).to eq 40
    end
  end
end
