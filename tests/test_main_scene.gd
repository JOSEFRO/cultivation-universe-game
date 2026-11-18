extends SceneTree

func _initialize() -> void:
	call_deferred("_run_integration_tests")

func _run_integration_tests() -> void:
	var packed_scene: PackedScene = load("res://scenes/main.tscn")
	assert(packed_scene != null, "La escena principal debe existir")
	var main = packed_scene.instantiate()
	root.add_child(main)
	await process_frame

	assert(main.find_child("BeginButton", true, false) != null, "Debe existir el botón Iniciar camino")
	assert(main.find_child("CodexButton", true, false) != null, "Debe existir el botón del códice")
	assert(main.status_label != null, "La interfaz debe crear el estado")

	main._on_codex_pressed()
	assert(main.status_label.text.begins_with("RAÍCES:"), "El códice debe mostrar las siete raíces")

	main._on_begin_pressed()
	assert(main.character_dialog != null, "Iniciar camino debe abrir creación de personaje")
	assert(main.find_child("CharacterNameInput", true, false) != null, "Debe existir el campo de nombre")
	assert(main.find_child("CultivationPathSelect", true, false) != null, "Debe existir la selección de camino")

	main.character_name_input.text = "Ari"
	main._create_character()
	assert(main.current_character.get("name") == "Ari", "Debe crear el personaje con el nombre indicado")
	assert(main.current_character.get("path") == "Cuerpo", "Debe asignar el camino inicial seleccionado")
	assert(FileAccess.file_exists("user://character.json"), "Debe persistir el personaje en user://character.json")
	print("PASS: integración de escena principal, códice y creación/guardado de personaje")
	quit(0)
