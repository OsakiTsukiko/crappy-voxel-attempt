extends Node

var world_gen = preload("res://Scenes/world_gen.tscn").instance()
var player_scene = preload("res://Scenes/Player.tscn")
onready var cube_cnt = $cubes
var sed 

const CHUNK_SIZE = 16

var cb_clr = Color.darkcyan
var cb_mat = SpatialMaterial.new()
var cb_clr_2 = Color.brown
var cb_mat_2 = SpatialMaterial.new()

var grass_top = SpatialMaterial.new()
var grass_side = SpatialMaterial.new()
var grass_bottom = SpatialMaterial.new()
var grass_top_txtr = preload("res://assets/top.png")
var grass_side_txtr = preload("res://assets/side.png")
var grass_bottom_txtr = preload("res://assets/bottom.png")

func do_chunk ( coords: Vector3 ):
	for x in range(coords.x, coords.x + CHUNK_SIZE):
		for y in range(coords.y, coords.y + CHUNK_SIZE):
			for z in range(coords.z, coords.z + CHUNK_SIZE):
				if world_gen.check_position(Vector3(x, y, z)):
					
#					var mm = CubeMesh.new()
#					mm.size = Vector3(.9, .9, .9)
#					var ms = MeshInstance.new()
#					ms.mesh = mm
#					ms.translate(Vector3(x, y, z))
					
					
					# LEFT
					if !world_gen.check_position(Vector3(x - 1, y, z)):
#						ms.material_override = cb_mat
						var mi = MeshInstance.new()
						var m = PlaneMesh.new()
						m.size = Vector2(1, 1)
						mi.mesh = m
						mi.material_override = grass_side
						mi.translate(Vector3(x - .5, y, z))
						mi.rotate_y(-PI/2)
						mi.rotate_z(PI/2)
						cube_cnt.add_child(mi)
						
					# RIGHT
					if !world_gen.check_position(Vector3(x + 1, y, z)):
#						ms.material_override = cb_mat
						var mi = MeshInstance.new()
						var m = PlaneMesh.new()
						m.size = Vector2(1, 1)
						mi.mesh = m
						mi.material_override = grass_side
						mi.translate(Vector3(x + .5, y, z))
						mi.rotate_y(PI/2)
						mi.rotate_z(-PI/2)
						cube_cnt.add_child(mi)
					
					# FRONT
					if !world_gen.check_position(Vector3(x, y, z - 1)):
#						ms.material_override = cb_mat
						var mi = MeshInstance.new()
						var m = PlaneMesh.new()
						m.size = Vector2(1, 1)
						mi.mesh = m
						mi.material_override = grass_side
						mi.translate(Vector3(x, y, z - .5))
						mi.rotate_y(PI)
						mi.rotate_x(-PI/2)
						cube_cnt.add_child(mi)
					
					# BACK
					if !world_gen.check_position(Vector3(x, y, z + 1)):
#						ms.material_override = cb_mat
						var mi = MeshInstance.new()
						var m = PlaneMesh.new()
						m.size = Vector2(1, 1)
						mi.mesh = m
						mi.material_override = grass_side
						mi.translate(Vector3(x, y, z + .5))
						mi.rotate_x(PI/2)
						cube_cnt.add_child(mi)
					
					# TOP
					if !world_gen.check_position(Vector3(x, y + 1, z)):
#						ms.material_override = cb_mat
						var mi = MeshInstance.new()
						var m = PlaneMesh.new()
						m.size = Vector2(1, 1)
						mi.mesh = m
						mi.material_override = grass_top
						mi.translate(Vector3(x, y + .5, z))
#						mi.rotate_x(0)
						cube_cnt.add_child(mi)
					
					# BOTTOM
					if !world_gen.check_position(Vector3(x, y - 1, z)):
#						ms.material_override = cb_mat
						var mi = MeshInstance.new()
						var m = PlaneMesh.new()
						m.size = Vector2(1, 1)
						mi.mesh = m
						mi.material_override = grass_bottom
						mi.translate(Vector3(x, y - .5, z))
						mi.rotate_x(PI)
						cube_cnt.add_child(mi)
						
#					cube_cnt.add_child(ms)

func _ready():
	randomize()
	cb_mat.albedo_color = cb_clr
	cb_mat_2.albedo_color = cb_clr_2
	grass_top.albedo_texture = grass_top_txtr
	grass_side.albedo_texture = grass_side_txtr
	grass_bottom.albedo_texture = grass_bottom_txtr
	var player = player_scene.instance()
	player.translate(Vector3(0, 20, 0))
	self.add_child(player)
	sed = floor(rand_range(-2147483648, 2147483648))
	world_gen.init(CHUNK_SIZE, sed)
	for x in range(-5, 6):
		for z in range(-5, 6):
			do_chunk(Vector3(x * CHUNK_SIZE, 0, z * CHUNK_SIZE))
	pass
	
	
func _process(delta):
	if Input.is_action_pressed("rot"):
		cube_cnt.rotate_y(PI/100)
