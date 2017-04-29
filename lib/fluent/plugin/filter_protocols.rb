require "csv"

module Fluent::Plugin
  class ProtocolsFilter < Filter
    Fluent::Plugin.register_filter('protocols', self)

    config_param :database_path, :string, :default => File.dirname(__FILE__) + '/../../../protocolslist/service-names-port-numbers.csv'
    config_param :key_port,      :string, :default => 'port'
    config_param :key_proto,     :string, :default => 'proto'
    config_param :key_prefix,    :string, :default => 'des'
    config_param :remove_prefix, :string, :default => nil
    config_param :add_prefix,    :string, :default => nil

    def configure(conf)
      super
      @remove_prefix = Regexp.new("^#{Regexp.escape(remove_prefix)}\.?") unless conf['remove_prefix'].nil?
      @key_prefix    = @key_port + "_" + @key_prefix
    end

    def filter_stream(tag, es)
      new_es = Fluent::MultiEventStream.new
      tag = tag.sub(@remove_prefix, '') if @remove_prefix
      tag = (@add_prefix + '.' + tag) if @add_prefix

      es.each do |time, record|
        unless record[@key_port].nil?
          record[@key_prefix] = getprotocolname(record[@key_port], record[@key_proto]) rescue "unknown"
        end
          new_es.add(time, record)
      end
      return new_es
    end

    def getprotocolname(port, protocol)
      CSV.open(@database_path,"r") do |csv|
        csv.each do |row|
          if row[1] == port
            if row[2] == protocol.downcase
              return row[0]
            end
          end
        end
      end
    end
  end
end
