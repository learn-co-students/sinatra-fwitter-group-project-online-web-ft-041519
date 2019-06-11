class Tweet < ActiveRecord::Base
  belongs_to :user

  include Slugifiable
  extend Slugifiable
end
