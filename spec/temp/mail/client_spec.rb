require 'spec_helper'
require 'net/smtp'

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
    let(:from_email) { 'temp-mail-gem@yandex.ru' }
    let(:to_email) { 'test-mail-gem@landmail.co' }

    let(:smtp_host) { %w{smtp yandex ru}.join(?.) }
    let(:smtp_port) { 465 }
    let(:username) { 'temp-mail-gem' }
    let(:password) { 'xei9daeph0Eka5Nileuh' }

    before do
      smtp = Net::SMTP.new(smtp_host, smtp_port)
      smtp.enable_ssl
      smtp.start('yandex.ru', username, password, :login) do
        smtp.open_message_stream(from_email, to_email) do |f|
          f.puts "From: #{from_email}"
          f.puts "To: #{to_email}"
          f.puts "Subject: #{message_subject}"
          f.puts
          f.puts message
        end
      end

      sleep 2
    end

    subject { described_class.new.incoming_emails(to_email) }

    it do
      expect(subject).to be_a Array
      expect(subject).to_not be_empty
      expect(subject.last).to include(:mail_unique_id, :mail_id, :mail_address_id, :mail_from, :mail_subject, :mail_preview, :mail_text_only, :mail_text, :mail_html, :mail_timestamp)
      expect(subject.last).to include(mail_address_id: Digest::MD5.hexdigest(to_email))
      expect(subject.last).to include(mail_from: from_email)
      expect(subject.last).to include(mail_subject: message_subject)
      expect(subject.last).to include(mail_text: message + ?\n)
    end
  end
end
