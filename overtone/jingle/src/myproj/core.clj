;; Prof Perkins & Jiin
(ns myproj.core
  (:use [overtone.live])
  (:use [overtone.inst.drum]))

(defsynth elec-piano [freq 200 dur 1]
  (let [src (saw [freq (* freq 1.01) (* 0.99 freq)])
        low (sin-osc (/ freq 2))
        filt (lpf src (line:kr (* 10 freq) freq 10))
        env (env-gen (perc 0.1 dur) :action FREE)]
    (out 0 (pan2 (* 0.6 low env filt)))))

(defn to-freq
    "Converts a note in :A4 form to its frequency."
    [my-note]
    (midi->hz (note my-note)))

(defn my-new-melody
  "Plays a melody using sleeps as durations on instrument."
  [time sleeps melody instrument]
  (at time (instrument (to-freq (first melody))))
  (let [new-time (+ time (* 1000 (first sleeps)))]
    (apply-by new-time
              my-new-melody [new-time
                             (rest sleeps)
                             (rest melody)
                             instrument])))

(defn clapping
  "Plays a clap when pattern has a 1, and dynamically sleeps between beats."
  [time pattern sleeps]
  (at time (when (= 1 (first pattern)) (kick)))
  (let [new-time (+ time (* 1000 (first sleeps)))]
    (apply-by new-time clapping [new-time (rest pattern) (rest sleeps)])))

;; Changed drum pattern.
(def drum-sleeps  (cycle [1 1 1 1]))
(def drum-pattern (cycle [0 1 0 1]))

;; Jingle Bells Melody
(my-new-melody (now)
    (cycle [0.25 0.25 0.25 0.25 1  ;; Melody (first time)
            0.25 0.25 0.25 0.25 1
            0.25 0.25 0.25 0.25 1
            0.25 0.25 0.25 0.25 0.5 0.5
            0.25 0.25 0.25 0.25 1  ;; Melody (second time)
            0.25 0.25 0.25 0.25 1
            0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25
            0.25 0.25 0.25 0.25 1
            0.25 0.25 0.5 0.25 0.25 0.5  ;; Chorus (one)
            0.25 0.25 0.25 0.25 1
            0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25
            0.25 0.25 0.25 0.25 0.5 0.5
            0.25 0.25 0.5 0.25 0.25 0.5  ;; Chorus (two)
            0.25 0.25 0.25 0.25 1
            0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25
            0.25 0.25 0.25 0.25 1])
    (cycle [:C4 :A4 :G4 :F4 :C4  ;; Melody (first time)
            :C4 :A4 :G4 :F4 :D4
            :D4 :Bb4 :A4 :G4 :E4
            :C5 :C5 :Bb4 :G4 :A4 :F4
            :C4 :A4 :G4 :F4 :C4  ;; Melody (second time)
            :C4 :A4 :G4 :F4 :D4
            :D4 :Bb4 :A4 :G4 :C5 :C5 :C5 :C5
            :D5 :C5 :Bb4 :G4 :F4
            :A4 :A4 :A4 :A4 :A4 :A4  ;; Chorus (one)
            :A4 :C5 :F4 :G4 :A4
            :Bb4 :Bb4 :Bb4 :Bb4 :Bb4 :A4 :A4 :A4
            :A4 :G4 :G4 :F4 :G4 :C5
            :A4 :A4 :A4 :A4 :A4 :A4  ;; Chorus (two)
            :A4 :C5 :F4 :G4 :A4
            :Bb4 :Bb4 :Bb4 :Bb4 :Bb4 :A4 :A4 :A4
            :C5 :C5 :Bb4 :G4 :F4])
    elec-piano)

;; ;; Claps (Beat)
(clapping (now) drum-pattern drum-sleeps)
