class FreckleApi::Project < FreckleApi::Model
  coerce_key :group, FreckleApi::Group
  coerce_key :import, FreckleApi::Import
  coerce_key :invoices, Array[FreckleApi::Invoice]
  coerce_key :participants, Array[FreckleApi::User]

  coerce_key :created_at, coerce_to_datetime
  coerce_key :updated_at, coerce_to_datetime

  # entries is a method of hash, so we're aliasing
  # it for now. Hashie's MethodWithIndirectAccess
  # should take care of this, but it doesn't
  # seem to work in this case, so we do it manually.
  alias_method :__entries, :entries

  def entries
    self[:entries]
  end
end
