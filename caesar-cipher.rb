def caesar_cipher(text, shift)
  cipher = ""
  text.each_char do |char|
    char_code = char.ord + shift%26
    char = char_code.chr
    cipher << char
  end
  cipher
end

puts caesar_cipher('y', 2)