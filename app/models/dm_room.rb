class DmRoom < ApplicationRecord
  has_many :dms, dependent: :destroy
  has_many :entries, dependent: :destroy

end
