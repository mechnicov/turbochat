module GenerateName
  extend ActiveSupport::Concern

  def generate_random_name
    attempts = 0
    while attempts < 10 do
      attempts += 1
      random_name = RandomUsername.noun(:min_length => 4, :max_length => 8)
      # random_name = RandomUsername.adjective(:min_length => 4, :max_length => 8)
      next if check_uniq_name(random_name)

      update(name: random_name)
    end
  end

  def check_uniq_name(name)
    Room.where(name: name).present?
  end
end
