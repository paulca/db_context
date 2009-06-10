require File.dirname(__FILE__) + '/spec_helper'
require File.join(File.dirname(__FILE__), "../lib", "object")

describe "changing the context of a database" do
  
  class TestModel < ActiveRecord::Base
    def self.table_name; 'boojas'; end
  end
  
  before do
    db_context(:default) do
      TestModel.delete_all
    end

    db_context(:other) do
      TestModel.delete_all
    end

    db_context(:default) do
      TestModel.create!
    end
    
    db_context(:other) do
      TestModel.create!
      TestModel.create!
      TestModel.create!
    end
  end
  
  it "should have one test model in the regular database" do
    db_context(:default) do
      TestModel.count.should == 1
    end
  end
  
  it "should have one test model" do
    db_context(:other) do
      TestModel.count.should == 3
    end
  end
  
  it "should return the value within the block" do
    count = db_context(:other) do
      TestModel.count
    end
    count.should == 3
  end
end