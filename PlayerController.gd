extends CharacterBody3D

# --- CÁC THÔNG SỐ CẤU HÌNH ---
@export_group("Tốc độ & Di chuyển")
@export var move_speed: float = 12.0          # Tốc độ di chuyển ngang
@export var dash_speed: float = 25.0          # Tốc độ lướt né
@export var min_x_bound: float = -3.5         # Giới hạn mép trái màn hình
@export var max_x_bound: float = 3.5          # Giới hạn mép phải màn hình

@export_group("Thao tác cảm ứng")
@export var swipe_threshold: float = 50.0     # Độ dài vuốt tối thiểu để tính là Dash

# --- BIẾN TRẠNG THÁI ---
var touch_start_position: Vector2 = Vector2.ZERO
var is_swiping: bool = false
var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_duration: float = 0.25               # Thời gian lướt (giây)
var target_x_position: float = 0.0

func _ready():
	target_x_position = global_position.x

func _unhandled_input(event: InputEvent) -> void:
	# 1. Nhận diện thao tác chạm màn hình (Touch Down)
	if event is InputEventScreenTouch:
		if event.pressed:
			touch_start_position = event.position
			is_swiping = true
		else:
			is_swiping = false

	# 2. Nhận diện thao tác vuốt (Drag / Swipe)
	elif event is InputEventScreenDrag and is_swiping:
		var swipe_vector = event.position - touch_start_position
		
		# Nếu vuốt nhanh sang hai bên -> Kích hoạt Dash (Lướt né)
		if abs(swipe_vector.x) > swipe_threshold and not is_dashing:
			if swipe_vector.x > 0:
				trigger_dash(1.0) # Lướt sang phải
			else:
				trigger_dash(-1.0) # Lướt sang trái
			is_swiping = false
		else:
			# Cập nhật vị trí di chuyển theo ngón tay chạm
			var viewport_width = get_viewport().get_visible_rect().size.x
			var normalized_x = (event.position.x / viewport_width) * 2.0 - 1.0 # Quy đổi về [-1, 1]
			target_x_position = clamp(normalized_x * max_x_bound, min_x_bound, max_x_bound)

func _physics_process(delta: float) -> void:
	# Xử lý trạng thái Lướt né (Dash)
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	else:
		# Di chuyển mượt mà tới vị trí ngón tay chỉ định (Lerp)
		var current_pos = global_position
		current_pos.x = move_toward(current_pos.x, target_x_position, move_speed * delta)
		global_position = current_pos

	move_and_slide()

# Hàm kích hoạt chiêu Lướt né
func trigger_dash(direction: float) -> void:
	is_dashing = true
	dash_timer = dash_duration
	target_x_position = clamp(global_position.x + (direction * 2.5), min_x_bound, max_x_bound)
	print("Lướt né sang hướng: ", direction)
