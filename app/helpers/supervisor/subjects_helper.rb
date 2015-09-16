module Supervisor::SubjectsHelper
  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, "#", onclick: "remove_fields(this)")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to name, "#", onclick: "add_fields(this, \"#{association}\",
      \"#{escape_javascript(fields)}\")"
  end

  def link_add_fields name, f, type
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to name, "#", class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")}
  end
end
