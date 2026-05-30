require "rails_helper"

RSpec.describe Types::QueryType do
  let(:user) { create(:user) }
  let(:context) { { current_user: user } }

  describe "tasks query" do
    before do
      create(:task, user: user,
        status: :pending, priority: :high)
      create(:task, user: user,
        status: :completed, priority: :low)
    end

    let(:query) do
      <<~GQL
        query GetTasks($status: TaskStatusEnum) {
          tasks(status: $status) {
            id
            title
            status
            priority
          }
        }
      GQL
    end

    it "returns all tasks" do
      result = TaskManagerApiSchema.execute(
        query,
        variables: {},
        context: context
      )

      expect(result["errors"]).to be_nil
      expect(result.dig("data",
        "tasks").length).to eq(2)
    end

    it "filters tasks by status" do
      result = TaskManagerApiSchema.execute(
        query,
        variables: { status: "PENDING" },
        context: context
      )

      tasks = result.dig("data", "tasks")
      expect(tasks.length).to eq(1)
      expect(tasks.first["status"]).to eq("PENDING")
    end
  end
end
