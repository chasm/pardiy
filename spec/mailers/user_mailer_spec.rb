require "spec_helper"

describe UserMailer do
  describe "reset_link" do
    let(:mail) { UserMailer.reset_link }

    it "renders the headers" do
      mail.subject.should eq("Reset link")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "register_link" do
    let(:mail) { UserMailer.register_link }

    it "renders the headers" do
      mail.subject.should eq("Register link")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "register_congrats" do
    let(:mail) { UserMailer.register_congrats }

    it "renders the headers" do
      mail.subject.should eq("Register congrats")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "goodbye" do
    let(:mail) { UserMailer.goodbye }

    it "renders the headers" do
      mail.subject.should eq("Goodbye")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
