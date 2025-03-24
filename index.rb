require "gosu"
dirname = Dir.entries(".")
dirname.each do |folder|
    if folder != "index.rb" and folder != "." and folder != ".." and folder != ".git" and folder != "level" and folder != "README.md"
        filename = Dir.entries(folder)
        filename.each do |file|
            if file != "index.rb" and file != "." and file != ".." and folder != ".git" and folder != "level" and folder != "README.md"
                require "./"+folder+"/"+file
            end
        end
    end
end  

include Move_game
include Constant

Main.new.show