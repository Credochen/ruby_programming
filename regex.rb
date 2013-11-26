#encoding:utf-8
def show_regexp(a, re)
    if a =~ re
        "#{$`}<< #{$&} >>#{$'}"
    else
        "no match"
    end
end

puts show_regexp('very interesting', /t/)
puts show_regexp('Fats Waller', /a/)
puts show_regexp('Fats Waller', /ll/)
puts show_regexp('Fats Waller', /z/)
#匹配开头
puts show_regexp("this is \nthe time", /^the/)
#匹配结尾
puts show_regexp("this is \nthe time", /is$/)
#匹配词的边界
puts show_regexp("this is \nthe time", /\bis/)
#匹配非词到边界
puts show_regexp("this is \nthe time", /\Bis/)

a = 'see [Design Patterns-page 123]'
#中括号中到“-”表示区间
puts show_regexp(a, /[A-F]/)
puts show_regexp(a, /[A-Fa-f]/)
puts show_regexp(a, /[0-9]/)
#^表示求反
#匹配任何非小写字母到字符
puts show_regexp(a, /[^a-z]/)
puts show_regexp(a, /[-]/)
puts show_regexp(a, /[]]/)
puts show_regexp(a, /[^a-z\s]/)
#重复
puts '+++++++++++++贪婪模式+++++++++++++++++'
b = "The moon is made of cheese"
puts show_regexp(b, /\w+/)
puts show_regexp(b, /\s.*\s/)
puts show_regexp(b, /\s.*?\S/)
puts show_regexp(b, /[aeiou]{2,99}/)
puts show_regexp(b, /mo?o/)
#替换
puts '+++++++++++++替换+++++++++++++++++'
c = "red ball blue sky"
puts show_regexp(c, /d|e/)
puts show_regexp(c,/al|lu/)
puts show_regexp(c, /red ball|angry sky/)
#编组
puts '+++++++++++++编组++++++++++++++++'
puts show_regexp('banana', /an*/)
puts show_regexp('banana', /(an)*/)
puts show_regexp('banana', /(an)+/)

puts show_regexp(c, /blue|red/)
puts show_regexp(c, /(blud|red) \w+/)
puts show_regexp(c, /(red|blue) \w+/)
puts show_regexp(c, /red|blue \w+/)
puts show_regexp(c, /red (ball|angry) sky/)
puts show_regexp('the red angry sky', /red (ball|angry) sky/)
puts show_regexp('the red angry sky', /red [ball|angry] sky/)

puts "+++++++++++++mathch duplicated letter+++++++++++"
puts show_regexp('He said "Hello"', /(\w)\1/) #He said "He<< ll >>o"
puts "+++++++++++++mathch duplicated substrings+++++++++++"
puts show_regexp('Mississippi', /(\w+)\1/) #M<< ississ >>ippi

puts show_regexp('He said "Hello"', /(["']).*?\1/)#He said << "Hello" >>

puts show_regexp("He said 'Hello'", /(["']).*?\1/)

d = 'the quick brown fox'
puts d.sub(/^./){|match| match.upcase}
puts d.gsub(/[aeiou]/){|vowel| vowel.upcase}
