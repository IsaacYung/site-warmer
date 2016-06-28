class SlackResponseParser
  def initialize(realtime_client)
    @client = realtime_client
  end

  def reply(data)
    if bot_reply?(data) || bot_direct?(data) && !initial_message(data)
      @client.typing channel: data.channel
      @client.message channel: data.channel, text: message(data)
    end
  end

  private

  def bot_reply?(data)
    data.text.starts_with? "<@#{@client.self.id}>"
  end

  def bot_direct?(data)
    data.channel.starts_with? 'D'
  end

  def initial_message(data)
    data.reply_to.present?
  end

  def message(data)
    return no_warm_message if last_warm.nil?
    message = without_user(data.text)

    case message
    when /^(oi|hi|bom dia|dia)/
      "Oi <@#{data.user}> :smirk:"
    when /^quando(.*)cache(.*)?/
      "<@#{data.user}> #{when_cache_warmed_message}"
    when /cache(.*)(quente|frio)(.*)?/
      "<@#{data.user}> #{summarized_message}"
    when /^quais(.*)frias(.*)?/
      "<@#{data.user}> #{which_urls_message}"
    when /detalhes|info(.*)/
      "<@#{data.user}> #{complete_message}"
    else
      "<@#{data.user}> não entendi o que você quer"
    end
  end

  def summarized_message
    "Da ultima vez que esquentei, tinha #{last_warm.cold_urls.length} urls frias"
  end

  def when_cache_warmed_message
    "A ultima vez que aqueci foi em " \
      "#{parsed_date(last_warm.created_at)}"
  end

  def which_urls_message
    if last_warm.cold_urls.length
      "Essas (foram aquecidas em #{parsed_date(last_warm.created_at)}):\n" \
      "- #{last_warm.cold_urls.join("\n- ")}"
    else
      "Nenhuma estava fria"
    end
  end

  def complete_message
    "Esquentei o cache em #{parsed_date(last_warm.created_at)}, " \
      "passei por *#{last_warm.total_urls}* urls, " \
      "das quais *#{last_warm.cold_urls.length}* estavam frias." \
      " Demorei #{last_warm.duration} segundos para executar o processo"
  end

  def no_warm_message
    "Não passei pelo site nenhuma vez, ainda."
  end

  def last_warm
    @last_warm ||= WarmResult.last
  end

  def without_user(message)
    message.gsub(/<(.*)>:/, '').strip.downcase
  end

  def parsed_date(date)
    date.strftime('%m de %b, às %H:%M')
  end
end
