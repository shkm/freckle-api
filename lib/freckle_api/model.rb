require 'hashie'

class FreckleApi
  class Model < Hash
    include Hashie::Extensions::Coercion
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IndifferentAccess

    include FreckleApi::Coercions

    def self.list(*records)
      [*records].map { |record| new(record) }
    end

    def reload!(_api)
      fail NotImplementedError
    end
  end
end
