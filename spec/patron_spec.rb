# require 'spec_helper'
#
# describe(Patron) do
#   describe('#==') do
#     it ('is the same patron if the name is the same') do
#       patron1 = Patron.new({:name => "Monique", :id => nil})
#       patron2 = Patron.new({:name => "Monique", :id => nil})
#       expect(patron1 == patron2).to(eq(true))
#     end
#   end
#
#   describe('#name') do
#     it('returns the name of the patron') do
#       patron1 = Patron.new({:name => "Monique", :id => nil})
#       expect(patron1.name).to(eq('Monique'))
#     end
#   end
#
#   describe('#id') do
#     it('returns the patron id') do
#         patron1 = Patron.new({:name => "Monique", :id => nil})
#       patron1.save
#       expect(patron1.id).to(be_an_instance_of(Fixnum))
#     end
#   end
#
#   describe(".all") do
#     it('starts with an empty array') do
#       expect(Patron.all).to(eq([]))
#     end
#   end
#
#   describe("#save") do
#     it("adds an patron to the patrons array") do
#       patron1 = Patron.new({:name => "Monique", :id => nil})
#       patron1.save
#       expect(Patron.all).to(eq([patron1]))
#     end
#   end
#
#   describe(".find") do
#     it("finds an patron by their id") do
#       patron1 = Patron.new({:name => "Monique", :id => nil})
#       patron1.save
#       patron2 = Patron.new({:name => "Steven", :id => nil})
#       patron2.save
#       expect(Patron.find(patron2.id)).to(eq(patron2))
#     end
#   end
#
#   describe("#delete") do
#     it('lets you delete an patron from the database') do
#       patron1 = Patron.new({:name => "Monique", :id => nil})
#       patron1.save
#       patron2 = Patron.new({:name => "Steven", :id => nil})
#       patron2.save
#       patron1.delete
#       expect(Patron.all()).to(eq([patron2]))
#     end
#   end
#
#
# end
