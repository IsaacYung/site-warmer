class RandomMessage
  MESSAGES = YAML.load_file('config/random-messages.yml')

  def self.some_sentence
    MESSAGES['sentences'].sample
  end

  def self.should_send?(percent)
    (0..percent).include?((rand * 100).to_i)
  end
end
