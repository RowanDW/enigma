require './lib/enigma'

RSpec.describe Enigma do

  before :each do
    @enigma = Enigma.new
  end

  context "Initialize" do
    it 'exists' do
      expect(@enigma).to be_a(Enigma)
      expect(@enigma.char_set.size).to eq(27)
    end
  end

  context "Helper Methods" do
    it "#generate_key" do
      key = @enigma.generate_key
      expect(key).to be_a(String)
      expect(key.length).to eq(5)
    end

    it "#offset" do
      offset = @enigma.offset("040895")
      expect(offset).to eq("1025")
    end

    it '#create_shifts' do
      shift = @enigma.create_shifts("02715", "040895")
      expected = [03, 27, 73, 20]
      expect(shift).to eq(expected)
    end

    it '#shift_char' do
      expect(@enigma.shift_char('h', 03)).to eq('k')
      expect(@enigma.shift_char('e', 27)).to eq('e')
      expect(@enigma.shift_char('l', 73)).to eq('d')
      expect(@enigma.shift_char('l', 20)).to eq('e')
    end

    it '#result_hash' do
      expected = {encryption: "hello world!", key: "02715", date: "040895"}
      expect(@enigma.result_hash(:encryption, "hello world!", "02715", "040895" )).to eq(expected)
    end
  end

  context "Main methods" do
    it "#encrypt" do
      code = @enigma.encrypt("hello world", "02715", "040895")
      expected = {encryption: "keder ohulw", key: "02715", date: "040895"}
      expect(code).to eq(expected)
    end

    it '#encrypt leaves other characters as they are' do
      code = @enigma.encrypt("hello world!", "02715", "040895")
      expected = {encryption: "keder ohulw!", key: "02715", date: "040895"}
      expect(code).to eq(expected)
    end

    it '#decrypt' do
      message = @enigma.decrypt("keder ohulw", "02715", "040895")
      expected = {decryption: "hello world", key: "02715", date: "040895"}
      expect(message).to eq(expected)
    end
  end
end
