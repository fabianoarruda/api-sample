class Tag < ActiveRecord::Base
  belongs_to :page

  enum name: [:h1, :h2, :h3, :a]
end
