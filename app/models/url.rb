class Url < ApplicationRecord
	belongs_to :base_url
	default_scope { where(is_scrap: false) }
end
