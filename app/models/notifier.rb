class Notifier
  def initialize(result)
    @result = result
  end

  def notify_slack
    return if Rails.application.secrets.notify_channel.nil?

    message = "Acabei de aquecer o cache: " \
              " passei por #{@result.total_urls} urls," \
              " carreguei as urls daqui #{@result.entry_point}" \
              " e demorei #{@result.duration.to_i} segundos para executar :)"

    client = Slack::Web::Client.new
    client.chat_postMessage(channel: Rails.application.secrets.notify_channel,
                            text: message,
                            as_user: true)
  end
end
