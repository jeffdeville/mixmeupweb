module YummlyService
  class Ingredient < Struct.new(:quant, :unit, :food)
    INGREDIENT_SPLITTER = /(?<quant>[\w\W]+)\s(?<unit>(cup|ounce|tsp|teaspoon|tablespoon|oz)[^\s]*)\s(?<ingredient>[\w\W]*)/i
    NO_UNIT_SPLITTER = /(?<quant>[\d]+)\s(?<ingredient>[\w\W]*)/i
    def blank?
      quant.nil? || unit.nil? || food.nil?
    end

    def self.blank(input)
      Ingredient.new(nil, nil, nil)
    end

    def unit_value
      Phys::Quantity[self.quant, self.unit].want("floz")
    end

    def self.from_line(input)
      match = INGREDIENT_SPLITTER.match(input)
      if match
        Ingredient.new get_line_quantity(match["quant"]), get_unit(match["unit"]), match["ingredient"]
      else
        match = NO_UNIT_SPLITTER.match(input)
        if match
          Ingredient.new get_line_quantity(match["quant"]), "WHOLE", match["ingredient"]
        else
          Ingredient.blank input
        end
      end
    end

    private
    def self.get_line_quantity(input)
      input.split().collect(&:to_frac).reduce(&:+)
    end

    def self.get_unit(input)
      case input.downcase
      when /ounce/
        "floz"
      else
        input.downcase
      end
    end
  end
end
