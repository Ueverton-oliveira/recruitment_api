module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    # Define the mappings if needed
    mappings do
      indexes :title, type: 'text'
      indexes :description, type: 'text'
      indexes :skills, type: 'text'
    end

    # Define a class method for searching
    def self.search(query)
      search_definition = {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'description', 'skills']
          }
        }
      }

      __elasticsearch__.search(search_definition).records.to_a
    end
  end
end
