@tool
extends EditorInspectorPlugin

# Properties
var current_node

# Signals
# signal animation_updated(animation_player: AnimationPlayer)

func _can_handle(object):
	# printt('gen object', object)
	if object is FiniteStateMachine:
		current_node = object
		# printt('object', object, type_string(typeof(object)), object.get_class())
		return true
	if object is State:
		current_node = object
		# print_debug('object', object)
		return true
	return false

func addchild(object):
	var a = AddChildNode.new()
	printt('addchild', object, a, object.new_child)
	if object is FiniteStateMachine:
		print('fss')
		var state = AutoAnimatedSprite2D.new().add_state(object.new_child)
		a.add_child_node(state, object, object.new_child+'State')
	if object is State:
		var trans = a.add_child_node(Transition, object, 'To'+object.new_child.name)
		trans.target_state = object.new_child
		printt('trans.target_state', trans.target_state)
		return trans

	print(object.get_children())

func addTransInit(object: Object):

	if not object._initial_state:
		printerr("ADD INITIAL STATE")
		return

	var children = object.get_children()
	printt('addTransInit', object, object.new_child, children, children[0], children[0].name, object._initial_state)
	# addchild(children[0])
	for child in object.get_children():
		printt('\n\nchild', child, object._initial_state, child == object._initial_state)
		var stateVariable = JSON.new().parse_string(FileAccess.open('res://addons/split_ss/variables.json', FileAccess.READ).get_as_text())
		# print(stateVariable)
		if child != object._initial_state:
			printt('sib', child, child.new_child)
			object._initial_state.new_child = child
			var childInit = addchild(object._initial_state)

			printt('childInit', childInit, child, child.name, stateVariable[child.name])
			childInit._variable_name = stateVariable[child.name].variable_name
			childInit._operator = stateVariable[child.name].operator
			childInit._value = stateVariable[child.name].value
			childInit._value_type = stateVariable[child.name].value_type
			printt(childInit._variable_name, childInit._operator, childInit._value, childInit._value_type)

	# for child in object.get_children():
	# 	printt('\n\nchild', child, object._initial_state, child == object._initial_state)
	# 	if child != object._initial_state:
	# 		printt('sib', child, child.new_child)
	# 		object._initial_state.new_child = child
	# 		addchild(child)

func addTrans(object: Object):
	var children = object.get_children()
	printt('addTrans', object, object.new_child, children, children[0], children[0].name)
	# addchild(children[0])
	for child in object.get_children():
		print(child)
		if child != object._initial_state:
		# 	for sib in object.get_children():
		# 		if not sib is IdleState:
		# 			printt('sib', sib, child.new_child)
		# 			child.new_child = sib
		# 			addchild(child)
		# else:
			child.new_child = object._initial_state
			var childTrans = addchild(child)
			printt('childTrans', childTrans)
			var target: Transition = object._initial_state.find_children('To' + child.name)[0]
			printt('target: ', target, type_string(typeof(target)), Transition)
			childTrans._variable_name = target._variable_name
			childTrans._value = target._value
			childTrans._value_type = target._value_type
			childTrans._operator = target.get_opposite_operator(target._operator)
			
			printt('\n\nelse', child, child.new_child, children, object._initial_state.get_children(), object._initial_state.find_children('To' + child.name), child.name, target.get_opposite_operator(target._operator), target._operator)

func newField(object: Object):
	var header = CustomEditorInspectorCategory.new("Add Child")

	# Import button
	var button := Button.new()
	button.text = "Add Child"
	button.get_minimum_size().y = 26
	# print(object.get_method_list())
	# button.button_down.connect(object.addchild)
	button.button_down.connect(addchild.bind(object))
	
	var buttonstyle = StyleBoxFlat.new()
	buttonstyle.bg_color = Color8(32, 37, 49)
	button.set("custom_styles/normal", buttonstyle)
	
	var container = VBoxContainer.new()
	container.add_spacer(true)

	container.add_child(header)
	# container.add_child(node_selector)
	# container.add_spacer(false)
	container.add_child(button)

	# var exports = preload('./exports.gd').new()
	# container.add_child(exports)

	return container

func addTransBtn(object: Object):
	var header = CustomEditorInspectorCategory.new("Add Animations from folder")

	# Import button

	var initTrans := Button.new()
	initTrans.text = "Add Init"
	initTrans.get_minimum_size().y = 26

	initTrans.button_down.connect(addTransInit.bind(object))

	var trans := Button.new()
	trans.text = "Add Trans"
	trans.get_minimum_size().y = 26

	trans.button_down.connect(addTrans.bind(object))

	var transStyle = StyleBoxFlat.new()
	transStyle.bg_color = Color8(32, 37, 49)
	initTrans.set("custom_styles/normal", transStyle)
	trans.set("custom_styles/normal", transStyle)

	var container = VBoxContainer.new()
	container.add_spacer(true)

	container.add_child(header)

	# container.add_child(node_selector)
	# container.add_spacer(false)
	# container.add_child(button)
	
	container.add_child(initTrans)
	container.add_child(trans)

	# var exports = preload('./exports.gd').new()
	# container.add_child(exports)

	return container

func _parse_property(object: Object, type: int, path: String, hint: int, hint_text: String, usage: int, wide: bool) -> bool:
	var handled = false
	# printt(path, hint_text)
	# Check if the property belongs to the specific category you are targeting
	# if path.begins_with("generate_animation"):
	# 	# Handle the property normally, or with custom logic if needed
	# 	# parse_property(object, type, path, hint, hint_text, usage, wide)
	# 	handled = true

	# After parsing all properties, check if you should add a custom one
	if path == "addTrans":  # Check against the last known property in this category
		add_property_editor("FSM", addTransBtn(object))  # Function to add your property
		print(object)
		handled = true
	# After parsing all properties, check if you should add a custom one
	if path == "submit":  # Check against the last known property in this category
		add_property_editor("New Child", newField(object))  # Function to add your property
		print(object)
		handled = true

	return handled

# func add_custom_property(object: Object):
#     # Add your custom property at the end of the specified category
# 	var custom_property_name = "Custom Property"
# 	add_property_editor(custom_property_name, newField(object))

# func _parse_property(object: Object, type: int, path: String, hint: int, 
# hint_text: String, usage: int, wide: bool) -> bool:
# 	printt(object, type, path, hint, hint_text, usage, wide)
# 	# Use path or hint_text to check for a specific category or property
# 	if hint_text == "Sprite Frames":
# 		# Custom handling for properties in "My Custom Category"
# 		add_property_editor(path, object)
# 		return true  # Return true if you handled the property yourself
# 	else:
# 		return false  # Return false to let Godot handle the property as usual

func _create_folder_input():
	# Create a container to hold the line edit and button
	var hbox = HBoxContainer.new()
	
	# Create the line edit to display the folder path
	var line_edit = LineEdit.new()
	# line_edit.readonly = true  # Make it readonly to ensure the path is only set via the dialog
	hbox.add_child(line_edit)
	
	# Create the button to open the folder dialog
	var select_button = Button.new()
	select_button.text = "..."
	select_button.connect("pressed", Callable(_on_select_button_pressed).bind(line_edit))
	hbox.add_child(select_button)
	
	return hbox

func _on_select_button_pressed(line_edit):
	# Create and configure the folder dialog
	var dialog = FileDialog.new()
	dialog.mode = FileDialog.FILE_MODE_OPEN_DIR
	dialog.connect("dir_selected", Callable(_on_folder_selected).bind(line_edit))
	dialog.popup_centered()

func _on_folder_selected(dir, line_edit):
	# Set the selected folder path to the line edit
	line_edit.text = dir

	# Optionally, do something with the selected folder path
	print("Selected folder:", dir)

func _on_animation_updated():
	emit_signal("animation_updated", current_node)

# Child class
class CustomEditorInspectorCategory extends Control:
	var title: String = ""
	var icon: Texture2D = null
	# @export var n = ''
	# @export_dir var sprite_folder: String = "res://Sprites/02-King Pig"  # Folder to load sprites from

	func _init(p_title: String, p_icon: Texture2D = null):
		title = p_title
		icon = p_icon
		printt('_init', title, icon)
		# tooltip_text = "AnimatedSprite to AnimationPlayer Plugin"
		tooltip_text = "Generate Animations"

	# func _get_minimum_size() -> Vector2:
	# 	var font := get_theme_font(&"bold", &"EditorFonts");
	# 	var font_size := get_theme_font_size(&"bold_size", &"EditorFonts");

	# 	var ms: Vector2
	# 	ms.y = font.get_height(font_size);
	# 	if icon:
	# 		ms.y = max(icon.get_height(), ms.y);

	# 	ms.y += get_theme_constant(&"v_separation", &"Tree");

	# 	return ms;

	# func _draw() -> void:
	# 	var sb := get_theme_stylebox(&"bg", &"EditorInspectorCategory")
	# 	draw_style_box(sb, Rect2(Vector2.ZERO, size))

	# 	var font := get_theme_font(&"bold", &"EditorFonts")
	# 	var font_size := get_theme_font_size(&"bold_size", &"EditorFonts")

	# 	var hs := get_theme_constant(&"h_separation", &"Tree")

	# 	var w: int = font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x;
	# 	if icon:
	# 		w += hs + icon.get_width();


	# 	var ofs := (get_size().x - w) / 2;

	# 	if icon:
	# 		draw_texture(icon, Vector2(ofs, (get_size().y - icon.get_height()) / 2).floor())
	# 		ofs += hs + icon.get_width()

	# 	var color := get_theme_color(&"font_color", &"Tree")
	# 	draw_string(font, Vector2(ofs, font.get_ascent(font_size) + (get_size().y - font.get_height(font_size)) / 2).floor(), title, HORIZONTAL_ALIGNMENT_LEFT, get_size().x, font_size, color);

