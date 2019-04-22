class ProjectRole < ApplicationRecord
  belongs_to :project
  belongs_to :role

  def as_json(*)
    super(
      only: %i[id project role],
      include: :role
    )
  end
end
