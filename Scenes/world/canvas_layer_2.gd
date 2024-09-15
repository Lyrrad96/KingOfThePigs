extends Control  # Use Control to draw the ruler

# Define how often to place the ruler ticks (in pixels)
var tick_spacing = 50
var ruler_color = Color(1, 1, 1)  # White color for the ruler
var tick_color = Color(0.8, 0.8, 0.8)  # Slightly gray color for tick marks
var font_size = 14  # Size of the numbers displayed

# Use the fallback font from the theme
var font = ThemeDB.fallback_font

func _ready():
    # Ensure the ruler is drawn when the scene is ready
    queue_redraw()  # This triggers the _draw() function to be called

func _process(_delta):
    # Continuously request redraws for the ruler during runtime
    queue_redraw()

func _draw():
    draw_horizontal_ruler()
    draw_vertical_ruler()

func draw_horizontal_ruler():
    var screen_width = get_viewport_rect().size.x
    var y_position = 20  # Position of the horizontal ruler on the screen (20 pixels from the top)

    # Draw the main horizontal line
    draw_line(Vector2(0, y_position), Vector2(screen_width, y_position), ruler_color, 2)

    # Draw the ticks and numbers
    for i in range(0, screen_width, tick_spacing):
        var tick_height = 10  # Height of the tick marks
        if i % (tick_spacing * 5) == 0:
            tick_height = 20  # Longer ticks every 5 ticks

        # Draw each tick
        draw_line(Vector2(i, y_position), Vector2(i, y_position + tick_height), tick_color)

        # Draw numbers every 5 ticks
        if i % (tick_spacing * 5) == 0:
            draw_string(font, Vector2(i + 5, y_position + tick_height + font_size), str(i))

func draw_vertical_ruler():
    var screen_height = get_viewport_rect().size.y
    var x_position = 20  # Position of the vertical ruler on the screen (20 pixels from the left)

    # Draw the main vertical line
    draw_line(Vector2(x_position, 0), Vector2(x_position, screen_height), ruler_color, 2)

    # Draw the ticks and numbers
    for i in range(0, screen_height, tick_spacing):
        var tick_width = 10  # Width of the tick marks
        if i % (tick_spacing * 5) == 0:
            tick_width = 20  # Longer ticks every 5 ticks

        # Draw each tick
        draw_line(Vector2(x_position, i), Vector2(x_position + tick_width, i), tick_color)

        # Draw numbers every 5 ticks
        if i % (tick_spacing * 5) == 0:
            draw_string(font, Vector2(x_position + tick_width + 5, i + font_size / 2), str(i))