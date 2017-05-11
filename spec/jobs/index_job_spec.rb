require 'rails_helper'

RSpec.describe IndexJob, type: :job do
  it 'matches with enqueued job' do
    ActiveJob::Base.queue_adapter = :test
    expect do
      IndexJob.perform_later(1, 2, 3)
    end.to have_enqueued_job(IndexJob).with(1, 2, 3)
  end
end
