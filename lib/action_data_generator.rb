require 'yaml'

class ADG

    def self.create_file
        print "name of object:"
        name = gets.chomp

        File.write("../object data/#{name}.yaml", "---\n    ")


    end

    def self.new_action(objname)
        data = YAML.load(File.read("../object data/#{objname}.yaml"))
        
        print "action_name:"
        action_name = gets.chomp

        


    end




end

if __FILE__==$0

    # ADG.create_file
    ADG.new_action("rock")

end