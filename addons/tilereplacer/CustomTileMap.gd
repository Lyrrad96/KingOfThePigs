@tool
extends TileMap

class_name CustomTileMap

## Folder which contains all the character animations as individual spritesheets
@export_dir var world_tileset: String = "res://Sprites/14-TileSets/Terrain (32x32).png"  # Folder to load sprites from
## The height and width of each frame
@export var frame_size: Vector2 = Vector2(16, 16)  # Size of each frame (in pixels)
## If feet of the character touch the bottom of the frame
# @export var feet_on_ground: bool = true

# checkbox to call the function
@export var generate_tiles: bool = false :
    get:
        return generate_tiles
    set(value):
        if Engine.is_editor_hint():
            # Ensure the script runs only in the editor
            'update_sprite_frames(value)'
        generate_tiles = value

# Function to update the SpriteFrames resource
func _ready():
    print("ready")
    printt(tile_set)
    if not tile_set:
        tile_set = TileSet.new()
    add_tileset_source("res://addons/tilereplacer/blank.png", "blank")
    add_tileset_source(world_tileset, "world")

func add_tileset_source(file_path: String, source_name: String):
    var file = load(file_path)
    var s = TileSetAtlasSource.new()
    s.set_texture(file)
    s.texture_region_size = Vector2i(16,16)
    # s.create_tile(Vector2i.ZERO,Vector2i(1,1))
    create_tiles(file_path, Vector2i(16,16), s)
    s.resource_name = source_name
    tile_set.add_source(s,-1)

func create_tiles(image_path: String, tile_size: Vector2i, s):
    var image = load(image_path)
    if not image:
        push_error("Failed to load image at path: %s" % image_path)
        return
    var texture = ImageTexture.create_from_image(image)
    var id = 0

    for y in range(image.get_height() / tile_size.y):
        for x in range(image.get_width() / tile_size.x):
            var region = Rect2(Vector2i(x, y) * tile_size, tile_size)
            if is_non_transparent(image, region):
                printt(id, x, y)
                s.create_tile(Vector2i(x, y),Vector2i(1, 1))
                id += 1

func is_non_transparent(texture: Texture2D, region: Rect2) -> bool:
    var image = texture.get_image()
    for y in range(region.size.y):
        for x in range(region.size.x):
            var color = image.get_pixel(region.position.x + x, region.position.y + y)
            if color.a > 0:
                return true
    return false