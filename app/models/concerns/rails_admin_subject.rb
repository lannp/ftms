module RailsAdminSubject
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        field :name do
         formatted_value do
            bindings[:view].content_tag :a, "#{bindings[:object].name}",
              href: "/admin/subject/#{bindings[:object].id}/show_subject?locale=#{I18n.locale}"
          end
        end
        field :description
        field :courses do
          searchable :name
        end
      end

      edit do
        field :name
        field :description
        field :task_masters
      end
    end
  end
end
