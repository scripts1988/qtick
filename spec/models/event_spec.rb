require 'rails_helper'

RSpec.describe Event, type: :model do
  describe ".upcoming" do
    it "return [] when there are no events" do
      expect(Event.upcoming).to eq []
    end

    it "return [] when there are only past events" do
      Event.create!(starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a past event",
                    venue: Venue.new, category: Category.new)
      expect(Event.upcoming).to eq [] 
    end

    it "return [b] when there are a past event 'a' and a future event 'b'" do
      a = Event.create!(name: "a", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: "a past event",
                        venue: Venue.new, category: Category.new)
      b = Event.create!(name: "b", starts_at: 2.days.ago, ends_at: 1.day.from_now, extended_html_description: " a future event",
                        venue: Venue.new, category: Category.new)
      expect(Event.upcoming).to eq [b]
    end

    it "return [d, c, e] when two events will start in future and should be in order of starting date" do
      c = Event.create!(name: "c", starts_at: 3.days.from_now, ends_at: 5.day.from_now, extended_html_description: "future event",
                        venue: Venue.new, category: Category.new)
      d = Event.create!(name: "d", starts_at: 1.days.from_now, ends_at: 2.day.from_now, extended_html_description: " a future event",
                        venue: Venue.new, category: Category.new)
      e = Event.create!(name: "e", starts_at: 5.days.from_now, ends_at: 10.day.from_now, extended_html_description: " a future event",
                        venue: Venue.new, category: Category.new)
      expect(Event.upcoming).to eq [d, c, e]
    end
  end
end
