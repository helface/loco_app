class Msgthread < ActiveRecord::Base
attr_accessible :participant1_id, :participant2_id, :subject
has_many :messages, foreign_key: "thread_id"
validates_presence_of :participant1_id, :participant2_id

end
