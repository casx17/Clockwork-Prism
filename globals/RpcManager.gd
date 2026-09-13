extends Node

func _ready() -> void:
	DiscordRPC.app_id = 1548587652268171296 # Application ID
	DiscordRPC.details = "Monday - Coil 1"
	DiscordRPC.state = "Constrained [2/32 Tersals]"
	#DiscordRPC.large_image = "example_game" # Image key from "Art Assets"
	#DiscordRPC.large_image_text = "Try it now!"
	#DiscordRPC.small_image = "boss" # Image key from "Art Assets"
	#DiscordRPC.small_image_text = "Fighting the end boss! D:"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	# DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"

	DiscordRPC.refresh() # Always refresh after changing the values!
