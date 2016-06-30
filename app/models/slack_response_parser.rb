class SlackResponseParser
  def initialize(realtime_client)
    @client = realtime_client
  end

  def reply(data)
    if bot_reply?(data) || bot_direct?(data) && !initial_message(data)
      @client.typing channel: data.channel
      @client.message channel: data.channel, text: message(data)
    end

    if RandomMessage.should_send?(3)
      @client.message channel: data.channel, text: RandomMessage.some_sentence
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
    when /^(quais|tinha alguma|tem alguma)(.*)fria(.*)?/
      "<@#{data.user}> #{which_urls_message}"
    when /detalhes|info|status(.*)/
      "<@#{data.user}> #{complete_message}"
    else
      "<@#{data.user}> não entendi o que você quer"
    end
  end

  def summarized_message
    "Da ultima vez que esquentei, tinha #{total_cold_urls} urls frias"
  end

  def when_cache_warmed_message
    "A ultima vez que aqueci foi em " \
      "#{parsed_date(last_warm.created_at)}"
  end

  def which_urls_message
    if last_warm.cold_urls.present? && last_warm.cold_urls.length
      url_limit = 20
      if last_warm.cold_urls.length > url_limit
        "Um monte (#{total_cold_urls} :fearful:), " \
        "segue as *#{url_limit}* primeiras " \
        "_(foram aquecidas em #{parsed_date(last_warm.created_at)})_:\n" \
        "- #{last_warm.cold_urls[0..url_limit].join("\n- ")}"
      else
        "Essas (foram aquecidas em #{parsed_date(last_warm.created_at)}):\n" \
        "- #{last_warm.cold_urls.join("\n- ")}"
      end
    else
      "Nenhuma :simple_smile:"
    end
  end

  def complete_message
    "Esquentei o cache em #{parsed_date(last_warm.created_at)}, " \
      "passei por *#{last_warm.total_urls}* urls, " \
      "das quais *#{total_cold_urls}* estavam frias." \
      " Demorei #{last_warm.duration} segundos para executar o processo"
  end

  def no_warm_message
    "Não passei pelo site nenhuma vez, ainda."
  end

  def last_warm
    Rails.cache.fetch("last_warm", expires_in: 1.minute) do
      WarmResult.last.reload
    end
  end

  def without_user(message)
    message.gsub(/<(.*)>:/, '').strip.downcase
  end

  def parsed_date(date)
    date.strftime('%d de %b, às %Hh%M')
  end

  def total_cold_urls
    last_warm.cold_urls.present? ? last_warm.cold_urls.length : 0
  end
end
