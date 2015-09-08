module ApplicationHelper

	def add_field(f, association)
	  new_object = f.object.send("build_#{association}")
	  id = new_object.object_id
	  fields = f.fields_for(association, new_object, child_index: id) do |builder|
	    render(association.to_s.singularize + "_fields", b: builder)
	  end
	end

end
