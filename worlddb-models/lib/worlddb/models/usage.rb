# encoding: utf-8

module WorldDb
  module Model


class Usage < ActiveRecord::Base

  belongs_to :country
  belongs_to :lang

end  # class Usage


  end # module Model
end # module WorldDb

