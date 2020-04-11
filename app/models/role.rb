class Role < ApplicationRecord
    has_and_belongs_to_many :users

    validates :name, presence: true

    def self.Constants
      {
        :show_reports => "ShowBlazerQueries",
        :create_reports => "CreateBlazerQueries",
        :update_reports => "UpdateBlazerQueries",
        :delete_reports => "DeleteBlazerQueries",
        :run_reports => "RunAllBlazerQueries"
      }.freeze
    end
  end
