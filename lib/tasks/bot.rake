namespace :bot do
  desc 'Wake up the bot'
  task wake_up: :environment do
    client = Slack::RealTime::Client.new
    parser = SlackResponseParser.new(client)

    client.on :message do |data|
      parser.reply(data)
    end

    client.start!
  end
end
