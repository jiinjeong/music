# FILE   : beats_intro.rb
# AUTHOR : Jiin Jeong
# DATE   : August 25, 2018
# DESC   : Helps explain the musical concept of time signature & beats,
#          as well as functions and good styling practices,
#          and gives examples of 4/4 and 3/4 beats. (Class 2)


use_bpm 100  # Beats per minute.

# Function: Code block that accomplishes a specific task.
# Descriptive name! Longer names (_ instead of spaces).
# 4/4 rhythm.
def four_four
  sample :drum_heavy_kick
  sleep 1
  sample :drum_snare_hard
  sleep 1
end

# 3/4 rhythm.
def three_four
  sample :drum_heavy_kick  # Downbeat.
  sleep 1
  sample :drum_snare_hard
  sleep 1
  sample :drum_snare_hard
  sleep 1
end

def waltz
  # Measure 1
  play :a3
  sleep 1
  play :d4
  sleep 1
  play :fs4
  sleep 1
  
  # Measure 2
  play :g4; sleep 1.5  # Multiple statements in one line (;).
  play :fs4; sleep 0.5
  play :fs4; sleep 1
end

def mamma_mia
  # Measure 1
  sleep 1
  play :e4
  sleep 0.5
  play :d4
  sleep 0.5
  play :e4
  sleep 0.5
  play :d4
  sleep 0.5
  sleep 1
  
  # Measure 2
  sleep 1
  play :d4; sleep 0.5
  play :d4; sleep 0.5
  play :e4; sleep 0.5
  play :fs4; sleep 0.5  # Sharp (s), Flat (b)
  play :e4; sleep 0.5
  play :d4; sleep 0.5
end

# CITE : https://groups.google.com/forum/#!topic/sonic-pi/d6DPLdTbMYo
# DESC : Showed a better way of organizing the melody!
def mamma_mia2
  # Variable creation.
  # Data structure (way of storing data): List
  notes = [:r, :e4, :d4, :e4, :d4, :r,
           :r, :d4, :d4, :e4, :fs4, :e4, :d4]  # :r is rest.
  
  durations = [1, 0.5, 0.5, 0.5, 0.5, 1,       # Adds up to four beats!
               1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]
  
  play_pattern_timed notes, durations
end

# Two live loops so they play simultaneously!
live_loop :beat do
  four_four
end

live_loop :melody do
  use_synth :blade  # Synthesizer: Piano or Blade ("Blade Runner"-themed)
  mamma_mia
end

# Another way to organize melody in live loops is through "ring" and "tick"
# See: Sam Aaron (https://github.com/samaaron/sonic-pi/blob/master/etc/doc/tutorial/A.07-bizet.md)
