require 'spec_helper'
require 'net/smtp'
require 'gmail'

describe Temp::Mail::Client do
  context 'get available domains' do
    subject { described_class.new.available_domains }

    it { expect(subject).to be_a Array }
    it { expect(subject).to_not be_empty }
  end

  context 'check incoming emails (empty inbox)' do
    subject { described_class.new.incoming_emails('demo@example.com') }

    it { expect(subject).to be_a Array }
    it { expect(subject).to be_empty }
  end

  context 'check incoming emails' do
    let(:message_subject) { 'test message' }
    let(:message) { 'This is a test message.' }
    let(:from_email) { 'tempmail.gem@gmail.com' }
    let(:to_email) { "test#{described_class.new.available_domains[0]}" }
    let(:user_name) { from_email }
    let(:password) { 'd3liv3rusfr0m3v1l' }    

    before do
      gmail = Gmail.connect(user_name, password)
      email = gmail.compose      
      email.to = to_email
      email.subject = message_subject
      email.body = message
      email.deliver!
      gmail.logout
      sleep 2
    end

    subject { described_class.new.incoming_emails(to_email) }

    it do
      expect(subject).to be_a Array
      expect(subject).to_not be_empty
      expect(subject.last).to include(:createdAt, :mail_id, :mail_address_id, :mail_from, :mail_subject, :mail_preview, :mail_text_only, :mail_text, :mail_html, :mail_timestamp, :_id)      
      expect(subject.last).to include(mail_address_id: Digest::MD5.hexdigest(to_email))
      expect(subject.last).to include(mail_from: from_email)
      expect(subject.last).to include(mail_subject: message_subject)
      expect(subject.last).to include(mail_text: message + ?\n)
    end
  end
end
