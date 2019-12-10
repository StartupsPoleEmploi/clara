# == Schema Information
#
# Table name: stats
#
#  id         :integer(8)      not null, primary key
#  ga         :jsonb           default("\"{}\"")
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  ga_pe      :jsonb           default("\"{}\"")
#  hj_ad      :jsonb           default("\"{}\"")
#

class Stat < ApplicationRecord
end
