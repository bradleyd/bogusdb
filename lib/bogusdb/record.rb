module Bogusdb
  class Record
    def initialize(args)
      @args = args.merge(id: id)
      @args.each do |k,v|
        self.class.send(:define_method, k.to_sym, -> { v })
      end
    end

    #@todo random number
    def id
      1
    end

    def attributes
      to_h
    end

    def inspect
      nice_format = to_h.collect { |k,v|
                      "#{k}: #{v}"
                    }.compact.join(", ")
      "#<#{self.class.name}: #{nice_format}"
    end

    private
    def to_h
      hsh = {}
      column_names.sort.each do |m|
        hsh[m] = self.method(m).call unless [:attributes].include? m
      end
      hsh
    end

    def column_names
     @args.keys 
    end
  end

end
