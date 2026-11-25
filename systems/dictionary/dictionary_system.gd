extends RefCounted
class_name DictionarySystem


var _words: Array[String] = []
var _word_lookup: Dictionary = {}

var _loaded_language: String = ""
var _loaded_length: int = 0


func load_dictionary(language: String, letter_count: int) -> bool:
    clear()

    if letter_count < 3:
        push_error("DictionarySystem: Word length must be at least 3.")
        return false

    var normalized_language := language.strip_edges().to_lower()
    if normalized_language.is_empty():
        push_error("DictionarySystem: Language is empty.")
        return false

    var path := "res://data/dictionaries/%s/%d.txt" % [normalized_language, letter_count]

    if not FileAccess.file_exists(path):
        push_error("DictionarySystem: Dictionary file not found: " + path)
        return false

    var file := FileAccess.open(path, FileAccess.READ)
    if file == null:
        push_error("DictionarySystem: Failed to open dictionary: " + path)
        return false

    var lines := file.get_as_text().split("\n")
    file.close()

    for line in lines:
        var word := line.strip_edges().to_lower()

        if word.is_empty() or word.begins_with("#"):
            continue

        if word.length() != letter_count:
            continue

        var valid := true

        for i in range(word.length()):
            var character := word.unicode_at(i)
            if character < 97 or character > 122:
                valid = false
                break

        if not valid or _word_lookup.has(word):
            continue

        _word_lookup[word] = true
        _words.append(word)

    if _words.is_empty():
        push_error("DictionarySystem: No valid words loaded.")
        clear()
        return false

    _loaded_language = normalized_language
    _loaded_length = letter_count

    return true


func contains_word(word: String) -> bool:
    return _word_lookup.has(word.strip_edges().to_lower())


func get_random_word(excluded_word: String = "") -> String:
    if _words.is_empty():
        return ""

    var excluded := excluded_word.to_lower()

    if _words.size() == 1 and _words[0] == excluded:
        return ""

    var selected := _words[randi_range(0, _words.size() - 1)]

    while not excluded.is_empty() and selected == excluded:
        selected = _words[randi_range(0, _words.size() - 1)]

    return selected


func get_word_count() -> int:
    return _words.size()


func clear() -> void:
    _words.clear()
    _word_lookup.clear()
    _loaded_language = ""
    _loaded_length = 0