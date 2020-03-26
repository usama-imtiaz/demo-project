ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes :name, :sortable => true, order: :name
  indexes description
  # indexes user.name, :as => :author, :sortable => true

  # has user_id,  :type => :integer
  has created_at, :type => :timestamp
  has updated_at, :type => :timestamp
end
