# encoding: UTF-8

glas = 'уеёыаоэяию'

firstA = File.open('firstA.txt', 'w')
firstB = File.open('firstB.txt', 'w')
secondA = File.open('secondA.txt', 'w')
secondB = File.open('secondB.txt', 'w')
third = File.open('third.txt', 'w')
fourth = File.open('fourth.txt', 'w')

File.open('base.txt', :encoding => 'Windows-1251') do |f|

    f.each_line do |raw|

        next if raw =~ /^\s+$/

        word,s_attrs,udar = raw.encode('utf-8').split('|')[0..2]
        word.strip!
        word.tr!('*','')
        udar.strip!
        attrs = s_attrs.strip.split(' ')
        n_slogs = 0
        n_udar = 0

        udar.each_char { |l|
            n_slogs +=1 if glas.include?(l)
            n_udar = n_slogs if l=='\''
        }

        if attrs.include?('ед') && attrs.include?('муж')
            if attrs.include?('сущ')
                if (attrs.include?('им')) && (word.end_with?('ик'))
                    if (n_slogs==2) && (n_udar==1)
                        puts "2A: #{word}"
                        n+=1
                        secondA.puts word
                    elsif (n_slogs==3) && (n_udar==2)
                        puts "2B: #{word}"
                        secondB.puts word                        
                    end
                elsif (attrs.include?('род')) && (n_slogs==2) && (n_udar==1)
                    puts "4: #{word}"
                    fourth.puts word
                end
            elsif attrs.include?('прл')
                if (attrs.include?('им')) && (n_udar==1)
                    if n_slogs==2
                        puts "1B: #{word}"
                        firstB.puts word
                    elsif n_slogs==3
                        puts "1A: #{word}"
                        firstA.puts word
                    end
                elsif (attrs.include?('род')) && (n_slogs==4) && (n_udar==2)
                    puts "3: #{word}"
                    third.puts word
                end
            end
        end  
    end 
end

puts "done: number of oboronas is #{n}"
