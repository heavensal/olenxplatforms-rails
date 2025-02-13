class Portfolio < ApplicationRecord
  belongs_to :user

  has_many :ideas, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_one_attached :qr_code
  has_one_attached :avatar

  after_create :generate_my_qr_code

  BASE_URL = "https://www.olenxplatforms.com/portfolios"

  def self.ransackable_attributes(_auth_object = nil)
    %w[company_name description]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def generate_my_qr_code
    if self.qr_code.attached?
      self.qr_code.purge
    end
    qr = RQRCode::QRCode.new("#{BASE_URL}/#{self.id}")
    png = qr.as_png(
      bit_depth: 1,
      border_modules: 0,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
    # attach the png to the portfolio as qr_code by cloudinary
    self.qr_code.attach(
      io: StringIO.new(png.to_s),
      filename: "qr_code_portfolio_#{self.id}.png",
      content_type: "image/png",
      identify: false,
      metadata: {
        title: "QR code for portfolio #{self.id}",
        alt: "QR code for portfolio #{self.id}"
      }
    )
  end
end
