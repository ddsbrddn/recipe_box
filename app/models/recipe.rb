class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients
  has_many :directions
  accepts_nested_attributes_for :ingredients,
                                reject_if:
                                proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for :directions,
                                reject_if:
                                proc { |attributes| attributes['step'].blank? },
                                allow_destroy: true

  validates :title, :description, :picture, presence: true
  mount_uploader :picture, PictureUploader
  validate :picture_size


  private

    # Validates the size of an uploaded pictures.
    def picture_size
      if picture.size > 3.megabytes
        errors.add(:picture, "should be less than 3MB")
      end
    end
end
