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
# end
