class Enigma

  attr_reader :char_set
  def initialize()
    @char_set = ("a".."z").to_a << " "
  end

  def encrypt(message, key = generate_key, date)
    split_message = message.downcase.split('')
    shifts = create_shifts(key, date)
    output = ''
    split_message.each do |char|
      if !@char_set.include?(char)
        output += char
      else
        output += shift_char(char, shifts[output.length % 4])
      end
    end
    result_hash(:encryption, output, key, date)
  end

  def generate_key
    range = ('00000'..'99999').to_a
    range.sample
  end

  def create_shifts(key, date)
    date = offset(date)
    [key[0..1].to_i + date[0].to_i,
    key[1..2].to_i + date[1].to_i,
    key[2..3].to_i + date[2].to_i,
    key[3..4].to_i + date[3].to_i]
  end

  def offset(date)
    if date[0] == "0"
      date = date[1..date.length]
    end
    date = date.to_i * date.to_i
    date = date.to_s
    date[-4..-1]
  end

  def shift_char(char, shift)
    index = @char_set.index(char)
    new_index = (index + shift) % 27
    @char_set[new_index]
  end

  def result_hash(encr_or_decr, result, key, date)
    {encr_or_decr => result,
    :key => key,
    :date => date}
  end
end
