# class Patron
#   attr_accessor(:name, :id)
#
#   def initialize (attributes)
#     @name = attributes.fetch(:name)
#     @id = attributes.fetch(:id)
#   end
#
#   def ==(another_patron)
#     self.name == another_patron.name
#   end
#
#   def self.all
#     returned_patrons = DB.exec("SELECT * FROM patrons;")
#     patrons = []
#     returned_patrons.each do |patron|
#       name = patron.fetch('name')
#       id = patron.fetch('id').to_i
#       patrons.push(Patron.new({:name => name, :id => id}))
#     end
#     patrons
#   end
#
#   def save
#     result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
#     @id = result.first.fetch('id').to_i
#   end
#
#   def self.find (id)
#     found_patron = nil
#     Patron.all.each do |patron|
#       if patron.id == id
#         found_patron = patron
#       end
#     end
#     found_patron
#   end
#
#   def delete
#     DB.exec("DELETE FROM patrons WHERE id = #{self.id};")
#   end
#
# end
