module RailsAdminUser
  extend ActiveSupport::Concern
  included do
    rails_admin do
      list do
        field :name do
          formatted_value do
            bindings[:view].content_tag :a, "#{bindings[:object].name}",
              href: "user/#{bindings[:object].id}/show_user?locale=#{I18n.locale}"
          end
        end
        field :email
        field :role do
          pretty_value do
            role = bindings[:object]
            class_label = if role.trainee?
              "label label-success"
            elsif role.supervisor?
              "label label-info"
            else role.admin?
              "label label-primary"
            end
            %{<div class="#{class_label}">#{role.role}</div>}.html_safe 
          end
        end
        field :courses do
          pretty_value do
            value = ""
            user = bindings[:object]
            user.courses.each do |course|
              if course.progress?
                value = course.name
              end
            end
            %{#{value}}.html_safe
          end
        end
        field :course_leaders do
          pretty_value do
            value = ""
            user = bindings[:object]
            user.courses.each do |course|
              if course.progress?           
                value = course.leaders.first.name      
              end
            end
             %{#{value}}.html_safe
          end
        end
      end

      edit do
        field :name
        field :role
        field :email
        field :password
        field :password_confirmation
      end

      show do
        field :name
        field :role
        field :email
        field :courses
        field :subjects
      end
    end
  end
end
