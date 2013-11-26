class Song
    @@plays = 0
    def initialize(name, artist, duration)
        @name       = name
        @artist     = artist
        @duration   = duration
        @plays      = 0
    end
    
    def play
        @plays += 1
        @@plays += 1
        "This song:#@plays plays.Total #@@plays plays."
    end

    attr_reader :name, :artist, :duration

    attr_writer :duration

    def duration_in_minutes
        @duration/60.0 #force floating poing
    end

    def duration_in_minutes=(new_duration)
        @duration = (new_duration * 60).to_i
    end

    def to_s
        "Song:#@name--#@artist (#@duration)"
    end
end

class KaraokeSong < Song
    def initialize(name, artist, duration, lyc)
        super(name, artist, duration)
        @lyc = lyc
    end

    def to_s
        super + " [#@lyc]"
    end
end

class SongList
    MAX_TIME = 5 * 60

    def initialize
        @songs = Array.new
        @index = WordIndex.new
    end
    def append(song)
        @songs.push(song)
        @index.add_to_index(song, song.name, song.artist)
        self
    end
    def lookup(word)
        @index.lookup(word)
    end
    def delete_first
        @songs.shift
    end
    def delete_last
        @songs.pop
    end
    def [](index)
        @songs[index]
    end
    
    def with_title(title)
        for i in 0...@songs.length
            return @songs[i] if title== @songs[i].name
        end
        return nil
    end

    def SongList.is_too_long(song)
        return song.duration > MAX_TIME
    end
end

class WordIndex
    def initialize
        @index = {}
    end
    def add_to_index(obj, *phrases)
        phrases.each do |phrase|
            phrase.scan(/\w[-\w']+/) do |word|
                word.downcase!
                @index[word] = [] if @index[word].nil?
                @index[word].push(obj)
            end
        end
    end

    def lookup(word)
        @index[word.downcase]
    end

end

class MyLogger
    private_class_method :new
    @@logger = nil
    def MyLogger.create
        @@logger = new unless @@logger
        @@logger
    end
end
=begin
songlist = SongList.new
class JukeboxButton < Button
    def initialize(label, &action)
        super(label)
        @action = action
    end

    def button_pressed
        @action.call(self)
    end

end
start_button = JukeboxButton.new('Start') {songlist.start}
pause_button = JukeboxButton.new('Pause') {songlist.pause}
=end
=begin
puts "+++++++++logger+++++++++++++++" 
puts MyLogger.create.object_id
puts MyLogger.create.object_id
=end
=begin
puts "+++++++++songs initialize+++++++++++++++" 
song = KaraokeSong.new("Kiss the rain", "CGP", 260, "And now, the...")
puts song.to_s
song.duration = 1024
puts song.duration
puts "+++++++++songs access+++++++++++++++"
puts song.duration_in_minutes
song.duration_in_minutes = 4.2
puts song.duration
puts "++++++++++play songs++++++++++++++"
s1 = Song.new("Song1", "Art1", 234)
s2 = Song.new("Song2", "Art2", 945)
puts s1.play
puts s2.play
puts s1.play
puts s2.play
puts "++++++++++songs length++++++++++++++"
puts SongList.is_too_long(s1)
puts SongList.is_too_long(s2)
=end

puts "++++++++++songs data list++++++++++++++"
File.open('songdata') do |song_file|
    songs = SongList.new
    song_file.each do |line|
        file,length,name,title = line.chomp.split(/\s*\|\S*/)
        name.squeeze!(" ")
        mins, secs = length.scan(/\d+/)
        songs.append(Song.new(title, name, mins.to_i*60+secs.to_i))
    end
    #puts songs[0]
    puts songs.lookup("Fats")
    puts songs.lookup("Walle")
end

