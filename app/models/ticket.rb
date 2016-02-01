class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, uniq: true
  attr_accessor :tag_names
  has_and_belongs_to_many :watchers, join_table: "ticket_watchers",
    class_name: "User", uniq: true

  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true
  validates :description, presence: true, length: { minimum: 10 }

<<<<<<< HEAD
  before_create :assign_default_state
  after_create :author_watches_me

  searcher do
    label :tag, from: :tags, field: "name"
    label :state, from: :state, field: "name"
  end

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end

  private
    def assign_default_state
      self.state ||= State.default
    end

    def author_watches_me
      if author.present? && !self.watchers.include?(author)
        self.watchers << author
      end
    end
=======
  mount_uploader :attachment, AttachmentUploader
>>>>>>> 1fe3ca34fe375c1f3f5d4246d8dc1d5afcc3fde6
end
