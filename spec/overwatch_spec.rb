require 'spec_helper'

describe Overwatch do
  describe "#redis" do
    it { Overwatch.redis.should be_an_instance_of(Redis) }
  end
end
