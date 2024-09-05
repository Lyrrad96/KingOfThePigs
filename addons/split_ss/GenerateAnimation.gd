@tool
extends EditorInspectorPlugin

# Properties
var sprite: AutoAnimatedSprite2D

# Signals
signal animation_updated(animation_player: AnimationPlayer)

func _can_handle(object):
	printt('object', object)
	if object is AutoAnimatedSprite2D:
		sprite = object

		return true
	return false

func fields(object: Object):
	var header = CustomEditorInspectorCategory.new("Add Animations from folder")

	# Import button
	var button := Button.new()
	button.text = "Generate Animations"
	button.get_minimum_size().y = 26
	button.button_down.connect(object.update_sprite_frames)

	var buttonstyle = StyleBoxFlat.new()
	buttonstyle.bg_color = Color8(32, 37, 49)
	button.set("custom_styles/normal", buttonstyle)

	var container = VBoxContainer.new()
	container.add_spacer(false)

	container.add_child(header)
	# container.add_child(node_selector)
	container.add_spacer(false)
	container.add_child(button)

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
	if path == "generate_animation":  # Check against the last known property in this category
		add_custom_property(object)  # Function to add your property
		handled = true

	return handled

func add_custom_property(object: Object) -> void:
    # Add your custom property at the end of the specified category
	var custom_property_name = "Custom Property"
	add_property_editor(custom_property_name, fields(object))

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
	emit_signal("animation_updated", sprite)

# Child class
class CustomEditorInspectorCategory extends Control:
	var title: String = ""
	var icon: Texture2D = null
	@export var n = ''
	@export_dir var sprite_folder: String = "res://Sprites/02-King Pig"  # Folder to load sprites from

	func _init(p_title: String, p_icon: Texture2D = null):
		title = p_title
		icon = p_icon
		printt('_init', title, icon)
		# tooltip_text = "AnimatedSprite to AnimationPlayer Plugin"
		tooltip_text = "Generate Animations"

	func _get_minimum_size() -> Vector2:
		var font := get_theme_font(&"bold", &"EditorFonts");
		var font_size := get_theme_font_size(&"bold_size", &"EditorFonts");

		var ms: Vector2
		ms.y = font.get_height(font_size);
		if icon:
			ms.y = max(icon.get_height(), ms.y);

		ms.y += get_theme_constant(&"v_separation", &"Tree");

		return ms;

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

