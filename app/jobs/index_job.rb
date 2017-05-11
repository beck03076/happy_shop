# job to create index in elasticsearch
class IndexJob < ApplicationJob
  # queue name
  queue_as :default
  # submits the job to sidekiq with passed arguments
  #
  # @params klass [Product]
  # @params operation [String] could index or update or delete
  # @params record_id [Numeric] the id of the product
  def perform(klass, operation, record_id)
    model = klass.constantize
    record = model.find_by(id: record_id)

    case operation.to_s
    when /index/
      record.__elasticsearch__.index_document if record
    when /update/
      record.__elasticsearch__.update_document if record
    when /delete/
      model.__elasticsearch__.client.delete id: record_id,
        type: model.__elasticsearch__.document_type,
        index: model.__elasticsearch__.index_name
    end
  end
end
