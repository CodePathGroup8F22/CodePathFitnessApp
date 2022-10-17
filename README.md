Original App Design Project -
===

# Fitness App

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Calendar system that tracks an individual's workout routine. It records the workout split (push, pull, or legs), exercise, reps, and weight. Used to help individuals stay on track with their gym schedule, help individuals get into the gym, and help individuals find workouts to try at the gym. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Fitness
- **Mobile:** This app would be primarily developed for mobile
- **Story:** Track workout routine, and find exercises for certain muscle groups.
- **Market:** The market focuses on athletes, body builders, and anyone that goes to the gym to workout. 
- **Habit:** This app can be used at anytime but mainly during the gym. 
- **Scope:** 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users can log in to access their personal calendar
* They can click into each cell in the calendar and see/record muscle group that is being worked out, exercises, and weight. 
* Can put and X or O over a cell to signify that they went to the gym or not

**Optional Nice-to-have Stories**

* Recommended exercises for each muscle group
* Show popular excercise
* See other people's calendars and what they did or planning to do
* Intergrate other people's workouts into your own workout
* Connect with people and talk about excersies in a chat

### 2. Screen Archetypes

* Register
   * Users is prompted to enter a username, password, and a valid email to register for the app
* Login
   * Users input their username and password
   * App checks if the username and password is valid
   * If not valid show a error message
   * If valid the app moves into the calendar screen
* Calendar Screen 
   * Allow users to look at old workout routines and create new workout for future routines 
* Search for Exercise Screen
   * Allow users to scroll through a list of exercises
   * Users can search by an exercise by name, muscle category, or work split

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Calendar
* List of excersies
* (Optional) Friends tab to look at friends' calendars

**Flow Navigation** (Screen to Screen)

* Login -> Account creation if credentials are unknown -> Persoanl Calendar if valid
* Personal Calendar -> Break down of workout for a specific day
* List of exercises -> Details of the excercise clicked

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://i.imgur.com/26pmh94.jpeg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
#### Workouts
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | workout       | String   | name of the workout |
   | image         | File     | image of the workout |
   | caption       | String   | description of the workout |
#### WorkoutGroup
   | Property      | Type     | Description  |
   | ------------- | -------- | ------------ |
   | objectId      | String   | unique id for each workout group (default field) |
   | workoutGroup  | String   | name of the workout group |
   | workouts      | Array    | array consisting of the objectId's of individual workouts related to this muscle group |
   
#### User
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image of user |
   | weight        | Number   | weight of user |
   | height        | Number   | height of user |
   | age           | Number   | age of user |
   | createdAt     | DateTime | date when user object is created (default field) |
   | updatedAt     | DateTime | date when user information is last updated (default field) |
   
### Networking
- Home Screen
  - (READ/GET) Query all popular workouts
- Workout Category Screen
  - (READ/GET) Query all workout groups
- Workout List Screen
  - (READ/GET) Query all workouts where workout group id is the selected workout group
- Individal Workout Screen
  - (READ/GET) Query workout where workout id is the selected workou
- Sign Up Screen
  - (CREATE/POST) Create a new user object
- Profile Screen
  - (READ/GET) Query logged in user object
  - (UPDATE/PUT) Update user profile image
  - (UPDATE/PUT) Update user weight
  - (UPDATE/PUT) Update user height
  - (UPDATE/PUT) Update user age
- Calendar Screen
  - (CREATE/POST) Create a new calendar/date event
  - (UPDATE/PUT) Update selected date event
<!--- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp] ---!>
