require "securerandom"

module Bogusdb
  # simulates a basic database record
  # @param [Hash] args column names and values
  class Record
    def initialize(table_data)
      raise TypeError unless Hash(table_data)
      @table_data = table_data
      set_id
      @table_data.each do |k,v|
        self.class.send(:define_method, k.to_sym, -> { v })
        self.class.send(:define_method, "#{k}=", -> {  })
      end
    end

    def id
      SecureRandom.random_number(100)
    end

    def attributes
      to_hash
    end

    # @param  [String, Symbol] table_name joined table name
    # @param  [Hash] opts column names and values
    # @return [Bogusdb::Record] 
    def join_table(table_name, opts={})
      self.class.send(:define_method, table_name.to_sym) do
        self.class.new(opts)
      end
    end

    def inspect
      nice_format = to_hash.collect { |k,v|
        "#{k}: #{v}"
      }.compact.join(", ")
      "#<#{self.class.name}: #{nice_format}"
    end

    private

    def to_hash
      hsh = {}
      column_names.sort.each do |m|
        hsh[m] = self.method(m).call unless [:attributes].include? m
      end
      hsh
    end

    def column_names
      @table_data.keys 
    end

    def set_id
      unless @table_data.include?("id" || :id)
        @table_data.merge!(id: id)
      end
    end

  end
end
