class Source < ActiveRecord::Base
  has_many :entries

  def update_last_checked_at
    self.last_checked_at = Time.now
    self.save!
  end
end
