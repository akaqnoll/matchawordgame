class_name GameSession
extends RefCounted

const HISTORY_SEPARATOR := "\u0000"

var initial_word: String = ""
var target_word: String = ""
var current_word: String = ""
var history: String = ""
var elapsed_time: float = 0.0
var number_of_turns: int = 0

var is_active: bool = false
var is_completed: bool = false

var _dictionary_system: DictionarySystem = DictionarySystem.new()


func start(language: String, letter_count: int) -> bool:
	reset()

	if not _dictionary_system.load_dictionary(language, letter_count):
		push_warning("Failed to load dictionary.")
		return false

	if _dictionary_system.get_word_count() < 2:
		push_warning("Dictionary must contain at least two words.")
		return false

	initial_word = _dictionary_system.get_random_word()
	target_word = _dictionary_system.get_random_word(initial_word)

	if initial_word.is_empty() or target_word.is_empty():
		push_warning("Failed to select initial and target words.")
		reset()
		return false

	current_word = initial_word
	history = initial_word
	is_active = true

	return true


func try_change_letter(letter_index: int, new_letter: String) -> bool:
	if not is_active or is_completed:
		return false

	if letter_index < 0 or letter_index >= current_word.length():
		return false

	if new_letter.length() != 1:
		return false

	new_letter = new_letter.to_lower()

	if current_word.substr(letter_index, 1) == new_letter:
		return false

	var candidate_word = current_word.left(letter_index) + new_letter + current_word.substr(letter_index + 1)

	if not _dictionary_system.contains_word(candidate_word):
		return false

	current_word = candidate_word
	history += HISTORY_SEPARATOR + current_word
	number_of_turns += 1

	if current_word == target_word:
		is_completed = true
		is_active = false

	return true


func update_time(delta: float) -> void:
	if is_active and delta > 0.0:
		elapsed_time += delta


func reset() -> void:
	initial_word = ""
	target_word = ""
	current_word = ""
	history = ""
	elapsed_time = 0.0
	number_of_turns = 0
	is_active = false
	is_completed = false