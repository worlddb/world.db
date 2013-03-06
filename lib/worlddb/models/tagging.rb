# encoding: utf-8

module WorldDb::Models

  class Tagging < ActiveRecord::Base

    belongs_to :tag
    belongs_to :taggable, :polymorphic => true

  end  # class Tagging

end # module WorldDb::Models
