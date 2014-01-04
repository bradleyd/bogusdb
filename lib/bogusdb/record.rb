require "securerandom"

module Bogusdb
  # simulate a basic database record ORM style
  # @param [Hash] table_data column names and values
  class Record
    def initialize(table_data)
      raise TypeError unless Hash(table_data)
      @table_data = table_data
      set_id
      @attributes = initialize_attributes(@table_data)
    end

    # @note can pass array of hashes to build records
    # @param [Array, Hash] args
    # @retrun [Array, Bogusdb::Record] 
    def self.create(args)
      args.is_a?(Array) ? Array.new(args.length) { |i| new(args[i]) } : new(args)
    end

    def attributes
      @attributes
    end

    # @param  [String, Symbol] table_name joined table name
    # @param  [Hash, Array] opts column names and values
    # @return [Bogusdb::Record, Array] joined table rows 
    def join_table(table_name, opts)
      self.class.send(:define_method, table_name.to_sym) do 
        self.class.create([opts].flatten)
      end
      self.send(table_name)
    end

    alias_method :has_many, :join_table

    # @param  [String, Symbol] table_name joined table name
    # @param  [Hash] opt column names and values
    # @return [Bogusdb::Record] joined table 
    def has_one(table_name, opt)
      self.class.send(:define_method, table_name.to_sym) do 
        self.class.new(opt)
      end
      self.send(table_name)
    end

    def inspect
      nice_format = attributes.collect { |k,v|
        "#{k}: #{v}"
      }.compact.join(", ")
      "#<#{self.class.name}: #{nice_format}"
    end

    private

    def id
      SecureRandom.random_number(100)
    end


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
