# Coercions should retain a proc, so that we can easily
# use them with Hashie's coercion methods.
#
# E.g.:
#   coerce_key, :the_key, name_of_method_that_returns_proc
#
module FreckleApi::Coercions
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # TODO: timezone based on local machine
    # TODO: beware nil values
    def coerce_to_datetime
      DateTime.method(:parse).to_proc
    end

    def coerce_to_date
      Date.method(:parse).to_proc
    end
  end
end
