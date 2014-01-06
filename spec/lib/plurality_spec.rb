require 'spec_helper'

describe Plurality do
  let(:users) { %w(Evan Rob Bill Josh Noah) }

  describe ".translate" do
    context "with correct data" do
      let(:key) { 'correct.email.subject' }

      context "one noun" do
        let(:nouns) { users.take(1) }

        subject { Plurality.translate key, nouns: nouns }

        it { should eq("Evan was added")}
      end

      context "two nouns" do
        let(:nouns) { users.take(2) }

        subject { Plurality.translate key, nouns: nouns }

        it { should eq("Evan and Rob were added")}
      end

      context "three nouns" do
        let(:nouns) { users.take(3) }

        subject { Plurality.translate key, nouns: nouns }

        it { should eq("Evan, Rob and Bill were added")}
      end

      context "four nouns but only using the first user's name" do
        let(:nouns) { users.take(4) }

        subject { Plurality.translate key, nouns: nouns }

        it { should eq("Evan and 3 others were added")}
      end

      context "other using the first two users but not the rest" do
        let(:nouns) { users.take(5) }

        subject { Plurality.translate key, nouns: nouns }

        it { should eq("Evan, Rob and 3 others were added")}
      end
    end

    context "with some missing data" do
      let(:key) { 'missing.email.subject' }

      context "one noun" do
        let(:nouns) { users.take(1) }

        subject { Plurality.translate key, nouns: nouns }

        it { should eq("Evan was added")}
      end

      context "missing data for two nouns" do
        let(:nouns) { users.take(2) }

        subject { Plurality.translate key, nouns: nouns }

        it { raise_error(Plurality::MissingPluralData, "Missing for two nouns") }
      end

      context "three nouns" do
        let(:nouns) { users.take(3) }

        subject { Plurality.translate key, nouns: nouns }

        it { should eq("Evan, Rob and Bill were added")}
      end

      context "other using the first two users but not the third" do
        let(:nouns) { users.take(5) }

        subject { Plurality.translate key, nouns: nouns }

        it { should eq("Evan, Rob and 3 others were added")}
      end
    end
  end
end