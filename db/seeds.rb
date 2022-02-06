return unless Rails.env == "development"

system 'clear'

puts 'Destroy all records'
puts '*' * 80

Message.destroy_all
Room.destroy_all
Like.destroy_all
User.destroy_all

puts 'Create new records'
puts '*' * 80

MAX_USERS_COUNT    = 3
MAX_ROOM_COUNT     = 4
MAX_LIKES_COUNT    = 40
MAX_MESSAGE_COUNT  = 32
USER_EMAIL         = %w(jane.doe john.doe admin)

# service
def create_user(email, password = '123456')
  user = User.create!(email: "#{email}@example.com",
                      password: password)
  print '.'
  generate_avatar(user)
end

def add_image(product)
  image = "#{Product::types[product.product_type].downcase}-#{rand(1..4)}.png"
  product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image)),
                 filename: "#{SecureRandom.uuid}_#{image}", content_type: 'image/png')
  print '.'
end

def not_uniq(user, message)
  Like.where(message_id: message.id, user_id: user.id).any?
end

def generate_avatar(user)
  images = 'women.jpeg' if 'jane'.in?(user.email)
  images ||= 'admin'.in?(user.email) ? 'man-1.jpeg' : 'man-2.jpeg'
  return if images.nil?

  path = Rails.root.join('app','assets','images', images)
  user.avatar.attach(io: File.open(path), filename: "image-#{SecureRandom.alphanumeric(12)}.jpg", content_type: 'image/jpeg')
  print '.'
end

#create Users
USER_EMAIL.each { |email| create_user(email) }

#create rooms
MAX_ROOM_COUNT.times do
  User.all.sample.rooms.create!
  print '.'
end

#create messages
MAX_MESSAGE_COUNT.times do
  message = Room.all.sample.messages.build(body: Faker::TvShows::BigBangTheory.quote)
  message.user = User.all.sample
  message.save
  print '.'
end

# add liked
likes = 0
while likes < MAX_LIKES_COUNT do
  message = Message.all.sample
  user = User.all.sample
  next if not_uniq(user, message)

  Like.create!(message: message, user: user)
  likes += 1
  print '.'
end

puts ' '
puts ' '
puts "That's all folks!"
puts '*' * 80
p "Created #{Room.count} #{'room'.pluralize(Room.count)}"
p "Created #{Message.count} #{'message'.pluralize(Message.count)}"
p "Created #{Like.count} #{'like'.pluralize(Like.count)}"
p "Created #{User.count} #{'user'.pluralize(User.count)}"
