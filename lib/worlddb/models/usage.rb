# encoding: utf-8

module WorldDb::Models

  class Usage < ActiveRecord::Base

    belongs_to :country
    belongs_to :lang

  end  # class Usage

end # module WorldDb::Models
