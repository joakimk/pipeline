require "httparty"

# NOTE: This class only tested manually (don't expect it to change much and outgoing http calls and threads are tricky to test)

class PostStatusToWebhook
  method_object :project

  TIMEOUT = 10 # seconds

  def call
    return unless webhook_url

    # Build payload outside of thread so that we don't leak active record connections,
    # or some other such thing.
    payload = build_payload

    Thread.new do
      HTTParty.post(webhook_url, body: { payload: payload }, timeout: TIMEOUT)
    end
  end

  private

  def build_payload
    ProjectStatusSerializer.new(project).serialize.to_json
  end

  def webhook_url
    ENV.fetch("WEBHOOK_URL", nil)
  end
end
