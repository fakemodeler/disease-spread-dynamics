# Disease Spread Dynamics

## Overview
This epidemiological agent-based model simulates the spread of an infectious disease through a population, incorporating factors like age, immunity, social behavior, and mobility patterns.


RELEASE 2.0 change!!

## Agents

### People
- **Attributes:**
  - `health-status`: Current health state (susceptible/infected/recovered/deceased)
  - `infection-time`: Duration since infection
  - `immunity-level`: Resistance to infection (0-1)
  - `mobility`: Movement frequency and distance
  - `social-contacts`: Number of daily interactions
  - `age-group`: Demographic category affecting disease impact

- **Behaviors:**
  - Move randomly with mobility-based frequency
  - Interact with nearby individuals
  - Progress through disease states over time
  - Develop immunity after recovery

## Environment
- Continuous 2D space with toroidal boundaries
- Population distributed initially at random locations
- No environmental barriers or special zones

## Disease Dynamics

### Transmission
- Occurs during close contact between infected and susceptible individuals
- Probability affected by immunity levels and age groups
- Distance-based interaction model

### Disease Progression
- **Susceptible** → **Infected** → **Recovered/Deceased**
- Incubation period before recovery/death determination
- Age-dependent mortality rates

### Color Coding
- **Green**: Susceptible
- **Red**: Infected  
- **Blue**: Recovered
- **Black**: Deceased

## Key Parameters
- `population-size`: Total number of individuals
- `initial-infected`: Number of initially infected people
- `base-transmission-rate`: Baseline infection probability
- `base-mortality-rate`: Baseline death probability
- `incubation-period`: Time from infection to recovery/death
- `interaction-distance`: Spatial range for disease transmission

## Measured Outputs
- `total-susceptible/infected/recovered/deceased`: Population counts by status
- `infection-rate`: Percentage of population currently infected
- `recovery-rate`: Percentage of population recovered
- `mortality-rate`: Percentage of population deceased
- `current-day`: Simulation time in days

## Research Applications
This model can be used to study:
- Epidemic curve dynamics and peak timing
- Impact of population density on disease spread
- Effects of age structure on mortality outcomes
- Herd immunity threshold determination
- Policy intervention scenarios (mobility restrictions, vaccination)

## Usage
1. Set population and disease parameters using sliders
2. Click "Setup" to initialize population and seed infection
3. Click "Go" to advance simulation one time step
4. Toggle "Go" for continuous simulation
5. Monitor epidemic statistics and population health status distribution 