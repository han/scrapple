# encoding: UTF-8

MULT = Hash.new(1).merge({
  '.' => 1,
  'D' => 2,
  'T' => 3
})

LETTER_VALUES = Hash.new(0).merge({
  a: 1, b: 4, c: 5, d: 2, e: 1, f: 4, g: 3, h: 4, i: 2, j: 4, k: 3, l: 3, m: 3, 
  n: 1, o: 1, p: 4, q: 10, r: 2, s: 2, t: 2, u: 2, v: 4, w: 5, x: 8, y: 8, z: 5
})


@word_set = {}

def read(f)
  File.open(f, 'r:utf-8') do |f|
    while !f.eof?
      s = f.readline 
      next unless s
      s = s.chomp.gsub(/[-']/,'').gsub(/ë/,'e').gsub(/é/,'e')
      next unless s =~ /^[a-z]+$/
      next unless s.length > 1
      @word_set[s] = true
    end
  end
end


def match(pattern, letters = @letters, results = {}, matched = {})
  return results if matched.key?(pattern)
  matched[pattern] = true

  permutations(letters, pattern) do |p|
    if @word_set.key?(p.downcase)
      points = points(p, pattern)
      if results.key?(p)
        results[p] = [results[p], points].max
      else
        results[p] = points
      end
    end
  end

  match(pattern[0..-2], letters, results, matched) if pattern =~ /[.DT23]$/ 
  match(pattern[1..-1], letters, results, matched) if pattern =~ /^[.DT23]/

  results
end

def show(results)
  results.each_pair.sort_by {|k,v| v}.each do |r|
    puts "#{r[0]} - #{r[1]}"
  end
end

def points(q, pattern)
  sum = q.split('').each_with_index.map {|el, i| (LETTER_VALUES[el.to_sym] || 0) * MULT[pattern[i]]}.inject {|el, s| s + el}
  sum *= 2 ** pattern.count('2') if pattern =~ /2/
  sum *= 3 ** pattern.count('3') if pattern =~ /3/
  sum += 40 if pattern.count('.DT23') == 7
  sum
end

def permutations(letters, pattern)
  n = pattern.count '.DT23'
  return if n == 0
  letters.split('').permutation(n).each do |p|
    q = ''
    i = j = 0
    pattern.each_char do |c|
      if ".DT23".include?(c)
        q << p[j].to_s
        j += 1
      else
        q << c
      end
    end
    if letters.include?('?')
      qs = ('a'..'z').map {|c| q.sub(/\?/,c.upcase)}
    else
      qs = [q]
    end
    
    qs.each {|q| yield q}
  end
end


puts "reading words"
read 'OpenTaal-210G-basis-gekeurd.txt'
read 'OpenTaal-210G-flexievormen.txt'
puts "#{@word_set.count} words read"

until @letters
  puts 'letters: (?: blank)'
  @letters = gets.chomp
  exit if @letters.length == 0
  @letters.downcase!
  @letters = nil unless @letters =~ /^[a-z?]+$/ && @letters.count('?') <= 1
end

loop do
  puts 'pattern: (.:char, *:chars, 2,3:2x,3x word, D,T:2x,3x letter, a-z:given)'
  pattern = gets.chomp
  exit if pattern.length == 0
  next unless pattern =~ /^[a-z23DT.*]+$/
  next if pattern =~ /[a-z].*\*.*[a-z]/
  next if pattern.count('*') > 2
  pattern.gsub! /\*/, '.'*7

  show(match(pattern))
  puts '----------'
end





