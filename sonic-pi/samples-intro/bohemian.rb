# ----------------------------------------------------------------- #
# FILE    : bohemian.rb

# AUTHOR  : Jiin Jeong

# DESC    : First two mama- melody of Bohemian Rhapsody
#           with voice, drums, and piano.
# ----------------------------------------------------------------- #


# ============== PART 1 (Samples) ============== #
# 1. Load external samples. Formats supported (WAV, AIFF or FLAC)
sample "/Users/Jiin/Desktop/queen_bohemian.wav"  # Mac.
# sample "C:/Users/Jiin/Desktop/queen_bohemian.wav"  # Windows.

# 2. Control sample parameters.
# 1) rate: 1.5 (faster, higher pitch), 0.5, -1 (plays backwards)
# 2) attack: 5.0 (fade-in), release: 0.5 (fade-out)
# 3) start: 0-1 (0.5, ..start); finish: 0-1 (0.1, ... end)

# 3. Folder of samples!
# One way:
sample "/Users/Jiin/Desktop/WavFile/", 1  # Index starts from 0!

# Better way:
path = "/Users/Jiin/Desktop/WavFile/"
sample path, 1
# File names work as well!
sample path, "trumpet.wav"

# ============== PART 2 (FX & Sound) ============== #
# 1. FX: Effects (sound processing using digital software).
# Ex: echo, gverb, ixi_techno, octaver, ring_mod, whammy, wobble

with_fx :whammy do
  sample path, 0
end

# 2. Sound Creation & Modification:
# 1) Synth (Synthesizer): Sth that creates sounds (Like a music instrument.)
synth :dsaw
sleep 1

# 2) Sample: Calls prerecorded sounds.
use_synth :beep  # Useless!
sample :ambi_choir
sleep 1

# 3) FX (Effects): Process sounds.
use_synth :blade
with_fx :echo do
  # Your code!
  melody = [:A3, :F3, :D3, :D3, :G3, :A3, :B3]
  beat = [0.5, 0.2, 1.5, 0.5, 0.5, 0.2, 0.2]
  play_pattern_timed melody, beat
end

# Instead of rerunning the whole thing, you can use live-loop
# to find the right notes/chords while coding.
live_loop :mama do

  # Voice
  in_thread do
    # External voice sample!!
    sample "queen_bohemian.wav"
  end
  
  kick = :drum_heavy_kick
  drum = :drum_bass_hard
  cymbal = :drum_cymbal_pedal
  
  # Drums
  in_thread do
    loop do
      use_bpm 69
      drums = (ring kick, drum, cymbal, drum,
               drum, drum)
      drums_sleep = (ring 0.5, 0.5, 0.5, 0.5,
                     0.45, 0.45)
      sample drums.look
      sleep drums_sleep.look
    end
  end
  
  # Piano melody
  loop do
    use_bpm 66
    use_synth :piano
    
    # You can use chords in a list/ring as well!
    intro = [chord(:G4, :minor), :G4, :Bb4, :D5, :G5, :F5,
             chord(:G4, :minor), :G4, :Bb4, :D5, :A5, :G5,
             chord(:C4, :minor), :C5, :Eb5, :G5, :D6, :C6]
    connection = [chord(:C4, :minor), :C5, :Eb5, :G5,
                  chord(:F4, :major), :Eb5, :F5, :C6]
    
    intro_dur = (ring 0.5, 0.5, 0.5, 0.5, 0.9, 0.9)
    connection_dur = (ring 0.5)  # Since it is a ring, will play
                                 # 0.5 eight times to match the
                                 # length of the list connection.
    
    play_pattern_timed intro, intro_dur
    play_pattern_timed connection, connection_dur
  end
end
