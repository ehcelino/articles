# Validate list of words that can not be use in specifig field
class BlacklistValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # record.errors.add(attribute, :on_blacklist) if blacklist.include? value
    record.errors.add(attribute, "contém uma palavra inválida.") if blacklist.include? value.downcase
  end

  private

  def blacklist
    File.readlines(Rails.root.join('config', 'blacklist.txt')).map(&:strip)
  end
end