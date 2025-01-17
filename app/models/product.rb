class Product < ApplicationRecord
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(jpg|jpeg|png|gif)\z}i,
        message: "Must be a url of gif, png, jpg"
    }

    has_many :line_items

    before_destroy :ensure_not_referenced_by_any_line_item

    private
    def ensure_not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, 'Line Items present')
            throw :abort
        end
    end
end
