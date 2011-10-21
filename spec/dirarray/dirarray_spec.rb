#coding: utf-8
require 'spec_helper'

module Dirarray
  describe Dirarray do
    describe "#initialize" do
      context "set path" do
        it "should set path from parameter" do
          dh = Dirarray.new('./')
          dh.path.should == './'
        end
      end
    end
    describe "#array" do
      context "empty directory" do
        it "should return empty array" do
          dh = Dirarray.new('./features/case01/')
          dh.array.should == []
        end
      end
      context "the directory has only files" do
        it "should return file list array" do
          expects = [
            {:name => 'a', :body => 'aあ'},
            {:name => 'b', :body => ''}
          ]
          dh = Dirarray.new('./features/case02/')
          result = dh.array
          result.size.should == expects.size
          expects.each {|e|
            result.index(e).should_not == nil
          }
        end
      end
      context "the directory has files and directory" do
        it "should return file list array and ignore directories" do
          expects = [
            {:name => 'a', :body => 'aあ'},
            {:name => 'b', :body => ''}
          ]
          dh = Dirarray.new('./features/case03/')
          result = dh.array
          result.size.should == expects.size
          expects.each {|e|
            result.index(e).should_not == nil
          }
        end
      end
      context "the directory has only files includes .xxx" do
        it "should return ignore the file that its name start with '.'" do
          expects = [
            {:name => 'a', :body => 'aあ'},
            {:name => 'b', :body => ''}
          ]
          dh = Dirarray.new('./features/case04/')
          result = dh.array
          result.size.should == expects.size
          expects.each {|e|
            result.index(e).should_not == nil
          }
        end
      end
      context "sort files." do
        it "should sort by file name asc" do
          expects = [
            {:name => '0', :body => ''},
            {:name => '01', :body => ''},
            {:name => '1', :body => ''},
            {:name => 'a', :body => ''},
            {:name => 'b', :body => ''}
          ]
          dh = Dirarray.new('./features/case05/')
          result = dh.array
          result.should == expects
        end
      end
    end
  end
end
