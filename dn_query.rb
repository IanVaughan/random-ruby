require 'sequel'
require 'mysql2'
require 'yaml'

DB = Sequel.connect('mysql2://root@127.0.0.1:3306/death_star_development')

def show_tables_sql
  "SHOW TABLES"
end

def get_fields_sql table
  "SELECT DISTINCT(c.column_name) FROM INFORMATION_SCHEMA.COLUMNS c WHERE c.table_name = '#{table}';"
end

def get_count_sql table, field
  "SELECT * FROM #{table} WHERE #{field} IS NOT NULL"
end

IGNORE_FIELDS = ['id', 'created_at', 'updated_at', 'created_on']
results = {}

if true
  query_result = DB.fetch(show_tables_sql).all
  tables = query_result.map { |f| f[:Tables_in_death_star_development] }
else
  tables = ['memberships', 'accounts']
end

table_count = tables.count

tables.each_with_index do |table, i|
  query_result = DB.fetch(get_fields_sql(table)).all
  fields = query_result.map { |f| f[:column_name] }
  print "=> #{i+1}/#{table_count} #{table} has #{fields.count} fields"

  field_results = {}
  fields.each do |field|
    next if IGNORE_FIELDS.include? field
    query = get_count_sql(table, field)
    begin
      field_results[field.to_sym] = DB.fetch(query).count
    rescue Sequel::DatabaseError
      field_results[field.to_sym] = -1
    end
    print "."
  end
  results[table.to_sym] = field_results
  puts
end

File.open("results.yml", "w") do |file|
  file.write results.to_yaml
end
