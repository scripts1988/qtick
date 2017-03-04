require 'rails_helper'

RSpec.describe Event, type: :model do

  before :each do
    saigon = Region.create(name:  'Saigon')
    saigon.save!

    diamond_place = Venue.create(name: 'Diamond Place', full_address: 'Just a Address, why so serious', region_id: saigon.id)
    diamond_place.save!

    entertainment = Category.create(name: 'Entertainment')
    entertainment.save!

    learn = Category.create(name: 'Learning')
    learn.save!

    something_else = Category.create(name: 'Everything Else')
    something_else.save!
  end

  describe ".search" do
    it "return [] when there is no events in db" do
      expect(Event.search('Hello')).to eq []
    end

    it "return [s] when s event name contain search term" do
      s = Event.create!(name: "s", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: "Hello event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      expect(Event.search('s')).to eq [s]
    end

    it "return [] when event name does not contain the searching name" do
      s0 = Event.create!(name: "Nothing", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: "Hello event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      expect(Event.search('Notfound')).to eq []
    end

    it "return [s1, s2] when s1, s2 event name contain search term" do
      s1 = Event.create!(name: "Hello 1", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: "Hello 1 event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      s2 = Event.create!(name: "Hello 2", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: "Hello 2 event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      expect(Event.search('Hell')).to eq [s1, s2]
    end

    it "return [s3, s4] when s3, s4 event name contain search term, and other events will not be found" do
      s3 = Event.create!(name: "Hello 1", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: "Hello 1 event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      s4 = Event.create!(name: "Hello 1", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: "Hello 1 event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      s5 = Event.create!(name: "Helo", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: "Hello 2 event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      expect(Event.search('Hell')).to eq [s3, s4]
    end
  end

  describe ".upcoming" do
    it "return [] when there are no events" do
      expect(Event.upcoming).to eq []
    end

    it "return [] when there are only past events" do
      Event.create!(starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a past event",
                    venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      expect(Event.upcoming).to eq [] 
    end

    it "return [b] when there are a past event 'a' and a future event 'b'" do
      a = Event.create!(name: "a", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: "a past event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      b = Event.create!(name: "b", starts_at: 2.days.ago, ends_at: 1.day.from_now, extended_html_description: " a future event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      expect(Event.upcoming).to eq [b]
    end

    it "return [d, c, e] when two events will start in future and should be in order of starting date" do
      c = Event.create!(name: "c", starts_at: 3.days.from_now, ends_at: 5.day.from_now, extended_html_description: "future event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      d = Event.create!(name: "d", starts_at: 1.days.from_now, ends_at: 2.day.from_now, extended_html_description: " a future event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      e = Event.create!(name: "e", starts_at: 5.days.from_now, ends_at: 10.day.from_now, extended_html_description: " a future event",
                        venue: Venue.find_by_name('Diamond Place'), category: Category.find_by_name('Entertainment'))
      expect(Event.upcoming).to eq [d, c, e]
    end
  end
end
