# encoding: utf-8

module WorldDb::Model

  class Tagging < ActiveRecord::Base

    belongs_to :tag
    belongs_to :taggable, :polymorphic => true

  end  # class Tagging

end # module WorldDb::Model

