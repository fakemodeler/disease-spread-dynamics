breed [people person]

people-own [
  health-status    ; "susceptible", "infected", "recovered", "deceased"
  infection-time   ; how long infected
  immunity-level   ; resistance to infection
  mobility         ; movement frequency
  social-contacts  ; number of daily interactions
  age-group        ; affects disease severity
]

globals [
  total-susceptible
  total-infected
  total-recovered
  total-deceased
  infection-rate
  recovery-rate
  mortality-rate
  current-day
]

to setup
  clear-all
  setup-population
  setup-initial-infection
  reset-ticks
  set current-day 0
end

to setup-population
  create-people population-size [
    setxy random-xcor random-ycor
    set shape "person"
    set size 0.8
    set health-status "susceptible"
    set infection-time 0
    set immunity-level random-float 1.0
    set mobility 0.3 + random-float 0.7
    set social-contacts 2 + random 8
    set age-group one-of ["child" "adult" "elderly"]
    set color green  ; susceptible = green
  ]
end

to setup-initial-infection
  ask n-of initial-infected people [
    set health-status "infected"
    set infection-time 0
    set color red  ; infected = red
  ]
  update-counters
end

to go
  move-people
  spread-infection
  update-health-status
  update-counters
  update-statistics
  tick
  if ticks mod 24 = 0 [ set current-day current-day + 1 ]
end

to move-people
  ask people with [health-status != "deceased"] [
    ; Infected people move less
    let movement-factor ifelse-value (health-status = "infected") [0.3] [1.0]
    
    ; Random walk with some social clustering
    rt random 60 - 30
    forward mobility * movement-factor
    
    ; Boundary wrapping
    if xcor > max-pxcor [ set xcor min-pxcor ]
    if xcor < min-pxcor [ set xcor max-pxcor ]
    if ycor > max-pycor [ set ycor min-pycor ]
    if ycor < min-pycor [ set ycor max-pycor ]
  ]
end

to spread-infection
  ask people with [health-status = "infected"] [
    let nearby-people other people in-radius interaction-distance
    let contacts min (list social-contacts count nearby-people)
    
    ask n-of contacts nearby-people [
      if health-status = "susceptible" [
        let transmission-probability base-transmission-rate
        
        ; Adjust probability based on immunity
        set transmission-probability transmission-probability * (1 - immunity-level)
        
        ; Age affects susceptibility
        if age-group = "elderly" [
          set transmission-probability transmission-probability * 1.5
        ]
        if age-group = "child" [
          set transmission-probability transmission-probability * 1.2
        ]
        
        if random-float 1.0 < transmission-probability [
          set health-status "infected"
          set infection-time 0
          set color red
        ]
      ]
    ]
  ]
end

to update-health-status
  ask people with [health-status = "infected"] [
    set infection-time infection-time + 1
    
    ; Recovery or death after infection period
    if infection-time >= incubation-period [
      let death-probability base-mortality-rate
      
      ; Age affects mortality
      if age-group = "elderly" [
        set death-probability death-probability * 3.0
      ]
      if age-group = "child" [
        set death-probability death-probability * 0.5
      ]
      
      ifelse random-float 1.0 < death-probability [
        set health-status "deceased"
        set color black
      ] [
        set health-status "recovered"
        set color blue
        ; Gained immunity
        set immunity-level min (list 1.0 (immunity-level + 0.8))
      ]
    ]
  ]
end

to update-counters
  set total-susceptible count people with [health-status = "susceptible"]
  set total-infected count people with [health-status = "infected"]
  set total-recovered count people with [health-status = "recovered"]
  set total-deceased count people with [health-status = "deceased"]
end

to update-statistics
  let total-population count people
  set infection-rate (total-infected / total-population) * 100
  set recovery-rate (total-recovered / total-population) * 100
  set mortality-rate (total-deceased / total-population) * 100
end 