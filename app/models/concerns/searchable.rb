# submits jobs for creating elasticsearch index
module Searchable
  extend ActiveSupport::Concern

  # submits a index_job for update or create
  def create_or_update_index
    # check if index is created
    if index_exists?
      IndexJob.perform_later(self.class.name, 'update', id)
    else
      IndexJob.perform_later(self.class.name, 'index', id)
    end
  end

  # submits a index_job for delete
  def delete_index
    IndexJob.perform_later(self.class.name, 'delete', id) if index_exists?
  end

  private

  # check if index exists from elasticsearch client
  def index_exists?
    __elasticsearch__.client.exists? id: id,
      index: self.class.__elasticsearch__.index_name,
      type: self.class.__elasticsearch__.document_type
  end
end
