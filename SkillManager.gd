extends Node

# --- THỜI GIAN HỒI CHIÊU (COOLDOWN) ---
@export var skill_1_cooldown: float = 3.0    # Chiêu 1: Lưỡi Kiếm Sét
@export var skill_2_cooldown: float = 8.0    # Chiêu 2: Lá Chắn Ánh Sáng
@export var ulti_cooldown: float = 15.0      # Tuyệt kỹ: Quang Diệu Trảm

var cd_timer_1: float = 0.0
var cd_timer_2: float = 0.0
var cd_timer_ulti: float = 0.0

func _process(delta: float) -> void:
	# Cập nhật đếm ngược Cooldown
	if cd_timer_1 > 0: cd_timer_1 -= delta
	if cd_timer_2 > 0: cd_timer_2 -= delta
	if cd_timer_ulti > 0: cd_timer_ulti -= delta

# --- KÍCH HOẠT CHIÊU 1 ---
func use_skill_1() -> bool:
	if cd_timer_1 <= 0:
		cd_timer_1 = skill_1_cooldown
		print("Kích hoạt Skill 1: Lưỡi Kiếm Sét!")
		return true
	print("Skill 1 đang trong thời gian hồi chiêu!")
	return false

# --- KÍCH HOẠT CHIÊU 2 ---
func use_skill_2() -> bool:
	if cd_timer_2 <= 0:
		cd_timer_2 = skill_2_cooldown
		print("Kích hoạt Skill 2: Giáp Ánh Sáng!")
		return true
	print("Skill 2 đang trong thời gian hồi chiêu!")
	return false

# --- KÍCH HOẠT QUANG DIỆU TRẢM (ULTIMATE) ---
func use_ultimate() -> bool:
	if cd_timer_ulti <= 0:
		cd_timer_ulti = ulti_cooldown
		print("KÍCH HOẠT ULTIMATE: Quang Diệu Trảm!")
		return true
	print("Ultimate chưa hồi xong!")
	return false
