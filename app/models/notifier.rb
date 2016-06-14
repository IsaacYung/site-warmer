class Notifier
  def initialize(result)
    @result = result
  end

  def notify_slack
    target = ENV["NOTIFY_CHANNEL"]
    return if target.nil?

    message = "Acabei de aquecer o cache: " \
              " passei por #{@result.total_urls} urls," \
              " carreguei as urls daqui #{@result.entry_point}" \
              " e demorei #{@result.duration.to_i} segundos para executar :)"

    client = Slack::Web::Client.new
    client.chat_postMessage(channel: target,
                            text: message,
                            as_user: true)
  end
end
