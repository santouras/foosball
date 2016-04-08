require "spec_helper"
require "elo/calculator"

describe Elo::Calculator do
  subject(:calculator) { Elo::Calculator }

  describe ".p" do
    it "calculates things" do
      expect(calculator.p(630, 500, 3, 1, 20)).to eq(9.63)
    end
  end

  describe ".w" do
    it "is 1 for a win" do
      expect(calculator.w(1, 0)).to eq(1)
      expect(calculator.w(4, 2)).to eq(1)
      expect(calculator.w(9, 8)).to eq(1)
    end

    it "is .5 for a draw" do
      expect(calculator.w(0, 0)).to eq(0.5)
      expect(calculator.w(8, 8)).to eq(0.5)
      expect(calculator.w(2, 2)).to eq(0.5)
    end

    it "is 0 for a loss" do
      expect(calculator.w(0, 10)).to eq(0)
      expect(calculator.w(6, 10)).to eq(0)
      expect(calculator.w(4, 5)).to eq(0)
    end
  end

  describe ".we" do
    it "calculates correctly" do
      expect(calculator.we(630, 500)).to eq(0.679)
      expect(calculator.we(500, 630)).to eq(0.321)
      expect(calculator.we(500, 480)).to eq(0.529)
      expect(calculator.we(480, 500)).to eq(0.471)
    end
  end

  describe ".g" do
    it "is 1 for draws" do
      expect(calculator.g(1, 1)).to eq(1.0)
      expect(calculator.g(2, 2)).to eq(1.0)
      expect(calculator.g(200, 200)).to eq(1.0)
    end

    it "is 1 for +1 differential" do
      expect(calculator.g(1, 2)).to eq(1.0)
      expect(calculator.g(2, 1)).to eq(1.0)
      expect(calculator.g(200, 199)).to eq(1.0)
    end

    it "is 3/2 when +2 differential" do
      expect(calculator.g(1, 3)).to eq(1.5)
      expect(calculator.g(10, 12)).to eq(1.5)
      expect(calculator.g(4, 2)).to eq(1.5)
    end

    it "is (11 + difference)/8 when +3 or higher" do
      expect(calculator.g(0, 3)).to eq(1.75)
      expect(calculator.g(7, 0)).to eq(2.25)
      expect(calculator.g(30, 40)).to eq(2.625)
    end
  end
end
