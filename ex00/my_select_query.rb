#class with a constructor that load a csv file and use the first line as the name (key) of the hash
class MySelectQuery
    def initialize(csv_content)
        @hash_array = []  #instant varibale to store the array of hash
        # file = File.open(filename_db) #open the csv file
        # lines = csv_content.readlines.map(&:chomp) #read each line in the file
        lines = csv_content.split(/\n/) 
        keys = lines.shift.split(',') #remove the first line, split to create an array
        lines.each{|line| #loop through the remaining lines from the csv
            line_hash = {} #hash variable to split each line
            values = line.scan(/"[^"]*"|[^,]+/) #split line with comma and exclude quoted string
            for x in 0..values.length-1 do #loop through the splitted line
                line_hash[keys[x]] = values[x] #create an hash key from the first line and assign value
            end
            @hash_array << line_hash #push the hash variable to an array
        }
        
    end

    #method that take 2 arguments: column_name and criteria. It will return an array of hash which match the value.
    def where(column_name, criteria)
        match_array = [] #array variable that store matched hash 
        @hash_array.each{ |e_hash| #loop through the instant variable that stores the array of hash
            if(e_hash[column_name]==criteria) #test if the column_name (key) has the criteria (value)
                match_array << e_hash #then push the matching hash to an array
            end
        }
        return match_array #return the array of the matched hash
    end
end

# obj = MyFirstSelect.new("nba_players.csv")
# puts obj.where "Player","Leo Barnhorst"