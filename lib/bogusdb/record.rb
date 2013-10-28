require "securerandom"

module Bogusdb
  # simulates a basic database record
  # @param [Hash] args column names and values
  class Record
    attr_accessor :new_record
    def initialize(table_data)
      #raise TypeError unless Hash(table_data)
      @table_data = table_data
      #set_id
      defaults = Hash[@table_data.map { |k, v|
        [k.to_sym, v] 
      }]
      @attributes = initialize_attributes(defaults)
    end

    def id
      SecureRandom.random_number(100)
    end

    def self.create(args)
      rows = []
      args.each do |arg|
        rows << new(arg)
      end
      rows
    end

    def attributes
      @attributes
    end

    # @param  [String, Symbol] table_name joined table name
    # @param  [Hash] opts column names and values
    # @return [Bogusdb::Record] 
    def join_table(table_name, opts)
      self.class.send(:define_method, table_name.to_sym) do 
        self.class.create(opts)
      end
    end

    def inspect
      nice_format = attributes.collect { |k,v|
        "#{k}: #{v}"
      }.compact.join(", ")
      "#<#{self.class.name}: #{nice_format}"
    end

    private

    #def to_hash
    #hsh = {}
    #column_names.sort.each do |m|
    #hsh[m] = self.method(m).call unless [:attributes].include? m
    #end
    #hsh
    #end

    def column_names
      @table_data.keys 
    end

    def set_id
      unless @table_data.include?("id" || :id)
        @table_data.merge!(id: id)
      end
    end

    def initialize_attributes(options)
      options.each do |key,value|
        self.define_singleton_method(key)       { options[key] }
        self.define_singleton_method("#{key}=") { |val| options[key]=val }
      end
    end

  end
end
