class Adopter < ActiveRecord::Base
  has_many :pets, dependent: :destroy
  has_many :shelters, through: :pets

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def adopt(pet)
    if !pet.adopted? && !pet.adopter_id
      pet.update(adopted?: true, adopter_id: self.id)
    end
  end

  def fav_pet
    return nil if self.pets.count == 0

    self.pets
    .group_by { |pet| pet.species}
    .max_by { |species| species.count }
    [0]
  end

end
