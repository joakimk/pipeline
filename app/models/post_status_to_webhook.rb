require "httparty"

# NOTE: This class only tested manually (don't expect it to change much and outgoing http calls and threads are tricky to test)

class PostStatusToWebhook
  method_object :project

  def call
    return unless webhook_url

    Thread.new do
      HTTParty.post(webhook_url, body: { payload: payload }, timeout: 10)
    end
  end

  private

  def payload
    ProjectStatusSerializer.new(project).serialize.to_json
  end

  def webhook_url
    ENV.fetch("WEBHOOK_URL", nil)
  end
end
