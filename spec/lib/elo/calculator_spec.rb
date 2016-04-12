require "spec_helper"
require "elo/calculator"

describe Elo::Calculator do
  subject(:calculator) { Elo::Calculator }

  shared_examples "calculates" do |description, method, params, outcome|
    it description do
      expect(calculator.send(method, *params)).to eq(outcome)
    end
  end

  describe ".p" do
    [{ args: [630, 500, 3, 1, 20], result: 9.63 }].each do |params|
      include_examples "calculates", "calculates correctly", :p, params[:args], params[:result]
    end
  end

  describe ".w" do
    [[1,0], [4,2], [9,8]].each do |params|
      include_examples "calculates", "is 1 for a win", :w, params, 1
    end

    [[0, 0], [8, 8], [2, 2]].each do |params|
      include_examples "calculates", "is .5 for a draw", :w, params, 0.5
    end

    [[0, 10], [6, 10], [4, 5]].each do |params|
      include_examples "calculates", "is 0 for a loss", :w, params, 0
    end
  end

  describe ".we" do
    [{ args: [630, 500], result: 0.679 },
     { args: [500, 630], result: 0.321 },
     { args: [500, 480], result: 0.529 },
     { args: [480, 500], result: 0.471 }].each do |params|
      include_examples "calculates", "calculates correctly", :we, params[:args], params[:result]
    end
  end

  describe ".g" do
    [[1, 1], [2, 2], [200, 200]].each do |params|
      include_examples "calculates", "is 1 for draws", :g, params, 1.0
    end

    [[1, 2],  [2, 1],  [200, 199]].each do |params|
      include_examples "calculates", "is 1 for +1 differential", :g, params, 1.0
    end

    [[1, 3], [10, 12], [4, 2]].each do |params|
      include_examples "calculates", "is 3/2 when +2 differential", :g, params, 1.5
    end

    [{ args: [0, 3],   result: 1.75 },
     { args: [7, 0],   result: 2.25 },
     { args: [30, 40], result: 2.625 }].each do |params|
      include_examples "calculates", "is (11 + difference)/8 when +3 or higher", :g, params[:args], params[:result]
    end
  end
end
