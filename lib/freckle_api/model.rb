require 'hashie'

class FreckleApi::Model < Hash
  include Hashie::Extensions::Coercion
  include Hashie::Extensions::MergeInitializer
  include Hashie::Extensions::MethodAccess
  include Hashie::Extensions::IndifferentAccess

  include FreckleApi::Coercions
end
