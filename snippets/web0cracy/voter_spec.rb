require 'acts_as_votable'
require 'spec_helper'

describe ActsAsVotable::Voter do

  before(:each) do
    clean_database
  end

  it "should not be a voter" do
    NotVoter.should_not be_voter
  end

  it "should be a voter" do
    Voter.should be_voter
  end

  describe "voting by a voter" do

    before(:each) do
      clean_database
      @voter = Voter.new(:name => 'i can vote!')
      @voter.save

      @voter2 = Voter.new(:name => 'a new person')
      @voter2.save

      @votable = Votable.new(:name => 'a voting model')
      @votable.save

      @votable2 = Votable.new(:name => 'a 2nd voting model')
      @votable2.save
    end

    it "should be voted on after a voter has voted" do
      @votable.vote :voter => @voter
      @voter.voted_on?(@votable).should be true
    end

    it "should not be voted on if a voter has not voted" do
      @voter.voted_on?(@votable).should be false
    end

    describe '#voted_as_when_voted_for' do

      it "should return nil when a voter has never voted" do
        @voter.voted_as_when_voted_for(@votable).should be nil
      end

      it "should return 0 when a voter has voted without parameters" do
        @votable.vote :voter => @voter
        @voter.voted_as_when_voted_for(@votable).should be 0
      end

      it "should return 1 when a voter has voted true" do
        @votable.vote :voter => @voter, :value => true
        @voter.voted_as_when_voted_for(@votable).should be 1
      end

      it "should return -1 when a voter has voted false" do
        @votable.vote :voter => @voter, :value => false
        @voter.voted_as_when_voted_for(@votable).should be -1
      end

      it "should return 42 when a voter has voted 42" do
        @votable.vote :voter => @voter, :value => 42
        @voter.voted_as_when_voted_for(@votable).should be 42
      end

      it "has #voted_as_when_voting_on as alias" do
        @votable.vote :voter => @voter, :value => -69
        @voter.voted_as_when_voting_on(@votable).should be -69
      end

    end

    describe '#voted_up_on?' do

      it "should return true if voter has voted true" do
        @votable.vote :voter => @voter, :value => 1
        @voter.voted_up_on?(@votable).should be true
      end

      it "should return false if voter has voted false" do
        @votable.vote :voter => @voter, :value => -1
        @voter.voted_up_on?(@votable).should be false
      end

      it "should return false if voter has voted obiwan" do
        @votable.vote :voter => @voter, :value => 0
        @voter.voted_up_on?(@votable).should be false
      end

    end

    describe '#voted_down_on?' do

      it "should return true if the voter has voted false" do
        @votable.vote :voter => @voter, :value => false
        @voter.voted_down_on?(@votable).should be true
      end

      it "should return false if the voter has not voted true" do
        @votable.vote :voter => @voter, :value => true
        @voter.voted_down_on?(@votable).should be false
      end

      it "should return false if the voter has voted obiwan" do
        @votable.vote :voter => @voter, :value => 0
        @voter.voted_down_on?(@votable).should be false
      end

    end

    it "should provide reserve functionality, voter can vote on votable" do
      @voter.vote :votable => @votable, :value => 'bad'
      @voter.voted_as_when_voting_on(@votable).should be -1
    end

    it "should allow the voter to vote up a model" do
      @voter.vote_up_for @votable
      @votable.up_votes.first.voter.should == @voter
      @votable.votes.up.first.voter.should == @voter
    end

    it "should allow the voter to vote down a model" do
      @voter.vote_down_for @votable
      @votable.down_votes.first.voter.should == @voter
      @votable.votes.down.first.voter.should == @voter
    end

    it "should allow the voter to unvote a model" do
      @voter.vote_up_for @votable
      @voter.unvote_for @votable
      @votable.find_votes.size.should == 0
      @votable.votes.count.should == 0
    end

    it "should get all of the voters votes" do
      @voter.vote_up_for @votable
      @voter.find_votes.size.should == 1
      @voter.votes.up.count.should == 1
    end

    it "should get all of the voters up votes" do
      @voter.vote_up_for @votable
      @voter.find_up_votes.size.should == 1
      @voter.votes.up.count.should == 1
    end

    it "should get all of the voters down votes" do
      @voter.vote_down_for @votable
      @voter.find_down_votes.size.should == 1
      @voter.votes.down.count.should == 1
    end

    it "should get all of the votes votes for a class" do
      @votable.vote :voter => @voter, :value => 1
      @votable2.vote :voter => @voter, :value => -1
      @voter.find_votes_for_class(Votable).size.should == 2
      @voter.votes.for_type(Votable).count.should == 2
    end

    it "should get all of the voters up votes for a class" do
      @votable.vote :voter => @voter, :value => 1
      @votable2.vote :voter => @voter, :value => -1
      @voter.find_up_votes_for_class(Votable).size.should == 1
      @voter.votes.up.for_type(Votable).count.should == 1
    end

    it "should get all of the voters down votes for a class" do
      @votable.vote :voter => @voter, :value => 1
      @votable2.vote :voter => @voter, :value => -1
      @voter.find_down_votes_for_class(Votable).size.should == 1
      @voter.votes.down.for_type(Votable).count.should == 1
    end

    it "should be contained to instances" do
      @voter.vote :votable => @votable, :value => -1
      @voter2.vote :votable => @votable, :value => 1

      @voter.voted_as_when_voting_on(@votable).should be -1
    end

  end
end
