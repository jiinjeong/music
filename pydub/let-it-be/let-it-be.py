from cs101audio import *

# ******************** BASIC SPEED GENERATION ********************
BPM = 100
QUARTER = int(60000 / BPM)
EIGHTH = int(QUARTER / 2)
HALF = int(QUARTER * 2)
WHOLE = int(QUARTER * 4)

# ******************** BASIC NOTE GENERATION ********************
e3 = generate_music_note("e3", QUARTER, "Square")
g3_e = generate_music_note("g3", EIGHTH, "Square")
g3 = generate_music_note("g3", QUARTER, "Square")
g3_h = generate_music_note("g3", HALF, "Square")
a3 = generate_music_note("a3", QUARTER, "Square")
a3_h = generate_music_note("a3", HALF, "Square")
b3 = generate_music_note("b3", QUARTER, "Square")
c4 = generate_music_note("c4", QUARTER, "Square")
c4_h = generate_music_note("c4", HALF, "Square")
d4_e = generate_music_note("d4", EIGHTH, "Square")
d4 = generate_music_note("d4", QUARTER, "Square")
d4_h = generate_music_note("d4", HALF, "Square")
e4_e = generate_music_note("e4", EIGHTH, "Square")
e4 = generate_music_note("e4", QUARTER, "Square")
f4 = generate_music_note("f4", QUARTER, "Square")

# ******************** BASIC CHORD GENERATION ********************
g3e3 = g3
g3e3.overlay(e3)

e4c4 = e4
e4c4.overlay(c4)

d4b3 = generate_music_note("d4", QUARTER, "Square")
d4b3.overlay(b3)

d4a3 = generate_music_note("d4", QUARTER, "Square")
d4a3.overlay(a3)

d4g3_h = d4_h
d4g3_h.overlay(g3_h)

c4a3_h = c4_h
c4a3_h.overlay(a3_h)


def select_speed():
    """ Allows user to select a desired speed. """
    speed = input("Fast, Medium, or Slow? ")
    if speed == "Fast":
        bpm = 100
    elif speed == "Medium":
        bpm = 80
    elif speed == "Slow":
        bpm = 60
    else:
        "Please enter a valid speed."
    return bpm


def create_drum_beat(drum, pattern, measures):
    """ Creates drum beat for the given drum type and pattern. """
    drum_beat = Audio()
    rest = Audio(HALF - len(drum))

    for measure in range(measures):
        for beat in pattern:
            if beat == 0:
                drum_beat += rest
            elif beat == 1:
                drum_beat += drum
    return drum_beat


def main():

    # ******************** MELODY ********************
    piano_notes = [g3_e, g3_e, g3e3, g3, a3, e3,
                   g3, g3, c4, d4,
                   e4c4, e4c4, e4c4, d4b3,
                   d4a3, c4, c4_h,
                   e4, e4, f4, e4,
                   e4, d4_h, e4_e, d4_e,
                   d4g3_h, c4a3_h]

    piano_tune = Audio()
    for note in piano_notes:
        piano_tune += note

    # ******************** DRUMS ********************

    drum_beat = Audio()

    snare = Audio()
    snare.open_audio_file("snare.wav")
    snare_beat = Audio()
    bass = Audio()
    bass.open_audio_file("bass.wav")
    bass_beat = Audio()

    snare_pattern = [1, 0, 1, 0]
    bass_pattern = [0, 1, 0, 1]
    measures = 8

    snare_beat = create_drum_beat(snare, snare_pattern, measures)
    bass_beat = create_drum_beat(bass, bass_pattern, measures)

    drum_beat = snare_beat
    drum_beat.overlay(bass_beat)

    # ******************** COMBO ********************
    piano_tune.apply_gain(-5)
    piano_tune.overlay(drum_beat, QUARTER)
    piano_tune.play()


if __name__ == '__main__':
    main()
