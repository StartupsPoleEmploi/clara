# Filters that comes from API
class ApiLevel3Filters < ActiveType::Object

  attribute :filters, :string

  validate :single_value_must_be_amongst_activated_filters, unless: Proc.new { |a| a.filters.blank? }
  validate :one_of_the_values_must_be_amongst_activated_filters, unless: Proc.new { |a| a.filters.blank? }

  def single_value_must_be_amongst_activated_filters
    if !filters.include?(",") && !has_filter(filters)
      errors.add(:filters, "La valeur doit être le slug d'un filtre actif (voir la liste avec GET /filters). Pour spécifier plusieurs slugs, il faut les séparer par une virgule.")
    end
  end

  def one_of_the_values_must_be_amongst_activated_filters
    if filters.include?(",")
      filters.split(",").each do |e|
        if !has_filter(e)
          errors.add(:filters, "#{e} n'est pas le slug d'un filtre actif (voir la liste avec GET /filters)")
        end
      end
    end
  end


  def has_filter(val)
    ActivatedModelsService.instance.filters.find{|e| e["slug"] == val}
  end

end
