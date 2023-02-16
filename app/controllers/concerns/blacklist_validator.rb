# Validate list of words that can not be use in specifig field
class BlacklistValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # record.errors.add(attribute, :on_blacklist) if blacklist.include? value
    separated_value = value.split
    separated_value.each do |val|
      if blacklist.include? val.downcase
        record.errors.add(attribute, "contém uma palavra inválida.")
      end
    end
  end

  private

  def blacklist
    File.readlines(Rails.root.join('config', 'blacklist.txt')).map(&:strip)
  end
end