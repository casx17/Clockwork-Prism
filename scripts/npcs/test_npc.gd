extends Npc

func interact():
	#execute necessary code
	super()
	
	#freeze player
	PlayerManager.interacting = true
	
	#start intro dialogue, wait to finish, then offer choice
	DialogueManager.startDialogue(load("uid://72mot2jhqt87"))
	await DialogueManager.dialogue_finished
	DialogueManager.promptDialogueChoices(["yeah", "nah"])
	
func _receive_response(response : String):
	if PlayerManager.interaction_target == self:
		#match response to proper dialogue
		match response:
			"yeah":
				#dialogue a
				DialogueManager.startDialogue(load("uid://cjar2yho5yj5g"))
				await DialogueManager.dialogue_finished
				PlayerManager.interacting = false
			"nah":
				#dialogue b
				DialogueManager.startDialogue(load("uid://bxpunptbur0ha"))
				await DialogueManager.dialogue_finished
				PlayerManager.interacting = false
