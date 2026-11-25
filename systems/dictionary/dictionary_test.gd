extends Node3D


func _ready() -> void:
    var dictionary := DictionarySystem.new()

    for length in [3, 4, 5]:
        print("\n--- Dictionary: %d letters ---" % length)

        var success := dictionary.load_dictionary("english", length)
        assert(success, "Dictionary loading failed!")

        print("Loaded words: ", dictionary.get_word_count())

        assert(dictionary.get_word_count() > 0)

        var random_word := dictionary.get_random_word()
        assert(not random_word.is_empty())
        assert(dictionary.contains_word(random_word))

        print("Random word: ", random_word)

    assert(dictionary.contains_word("cat"))
    assert(not dictionary.contains_word("qzx"))

    var different_word := dictionary.get_random_word("cat")
    assert(different_word != "cat")

    print("\nALL TESTS PASSED")