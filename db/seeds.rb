# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Create Regions
['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong'].each do |r|
  Region.create(name: r)
end
# Create Categories
['Entertainment', 'Learning', 'Everything Else'].each do |c|
  Category.create(name: c)
end

# First event:
dalat = Venue.create({
  name: 'Da Lat City',
  full_address: 'Ngoc Phat Hotel 10 Hồ Tùng Mậu Phường 3, Thành phố Đà Lạt, Lâm Đồng, Thành Phố Đà Lạt, Lâm Đồng',
  region: Region.find_by(name: 'Lam Dong')
})

# Dan Truong
dan_venue = Venue.create({
  name: 'Sân vận động quân khu 7',
  full_address: '202 Hoàng Văn Thụ, Quận Tân Bình, Hồ Chí Minh',
  region: Region.find_by(name: 'Ho Chi Minh')
})


# Third event - Merry Christmas Never Alone
gap = Venue.create({
  name: 'Gap Yolo Hanoi',
  full_address: '1B Quốc Tử Giám, Quận Đống Đa, Hà Nội',
  region: Region.find_by(name: 'Ha Noi')
})

