class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
    where("ends_at >= ? and publish_status = true", Time.zone.now).order(:starts_at)
  end

  def self.search(term)
    where('name LIKE ?', "%#{term}%")
  end
end
