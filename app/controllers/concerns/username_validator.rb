class UsernameValidator < ActiveModel::EachValidator
  CHAR_LIST = ["A".."Z", "a".."z", "1".."9"].flat_map(&:to_a)
  CHAR_LIST.append(["_", "-"])
  def validate_each(record, attribute, value)
    value.each_char do |c|
      if not CHAR_LIST.include?(c)   
        return record.errors.add(attribute, "contém caracteres inválidos.")
      end
    end
  end

end