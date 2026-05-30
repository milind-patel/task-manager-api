require "rails_helper"

RSpec.describe Mutations::CreateTask do
  let(:user) { create(:user) }
  let(:context) { { current_user: user } }

  describe "create task" do
    let(:mutation) do
      <<~GQL
        mutation CreateTask($title: String!) {
          createTask(input: { title: $title }) {
            id
            title
            status
            priority
          }
        }
      GQL
    end

    it "creates a task successfully" do
      result = TaskManagerApiSchema.execute(
        mutation,
        variables: { title: "Test Task" },
        context: context
      )

      expect(result["errors"]).to be_nil
      expect(result.dig("data", "createTask",
        "title")).to eq("Test Task")
      expect(result.dig("data", "createTask",
        "status")).to eq("PENDING")
    end

    it "fails without authentication" do
      result = TaskManagerApiSchema.execute(
        mutation,
        variables: { title: "Test Task" },
        context: { current_user: nil }
      )

      expect(result["errors"]).to be_present
      expect(result["errors"].first["message"])
        .to eq("Unauthorized")
    end
  end
end
