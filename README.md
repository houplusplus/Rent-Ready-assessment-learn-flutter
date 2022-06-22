# Learn flutter in 2 weeks : a first project.

Learning Flutter and Dart in 2 weeks : a First project.
This project was a part of the Rent Ready company technical assessment.
The original requirements were adapted to focus on learning Flutter and Dart.

I recommend anyone wanting to learn flutter to try recreating this task and follow the technical and functional requirements.
**Notes**: 
- I started from scratch with zero knowledge of flutter, dart and any related technology, but with an extensive mobile development experience.
- I spend 3 days learning Dart basics, and 5 days creating the project, including other tasks.
- After finishing this task, you will be qualified as a Junior flutter developer. See **Next Steps** for a roadmap to Senior level.

## Project objective

The goal of this task is to :

* Create a application
* Implement search and filtering capabilities
* Implement a details view
* Read data from a json web service

You will Learn:
- **UI** : Widgets (Stateless, Stateful, Style)
- **Assets** : (Fonts, images, files)
- **Data and Backend** : Local and Remote (Networking with http and dio)
- **State Management**


Note: It was recommended to implement a Web Application in sake of simplicity.

## Technical Requirements
* Search by account name or account number
* Filtering by StateCode and StateOrProvince


## Functional Requirements for Junior level

[x] Implement Dart/Flutter app

[x] Implement preloader for search and filtering

[x] A solution should be in a public repository

[x] Meaningful readme.md in the repository root


## Mockup

The page should contain:
- Search field
- Drop down list with filtering
- Switch: list or cards
- Accounts objects

![Mockup image](/assets/mockup.png)


## Screenshots

- Account Table with account name, image and payload

![list image](/assets/list.png)

- Card display

![cards image](/assets/cards.png)

- Searching

![search image](/assets/search.png)

- Filtering

![filter image](/assets/filter.png)

- DetailView

![detail image](/assets/details.png)


# Next Steps

## Functional Requirements for Sunior level

[ ] Unit Tests

[ ] UI components tests

[ ] Build scripts should be implemented inside a docker container

[ ] Connect to dataverse storage webservice and make search and filter on server side

## Other things to learn in Flutter

[ ] Animations

[ ] Socket networking

[ ] Internationalization and Accessibility

[ ] Native Integration : Java/ Kotlin and Swift/ Objective-C



# Running this project

## Get and test the source code


- 0 : If not done yet, install flutter, Visual Studio Code or your favorite IDE (Android Studio or XCode if you prefer). I used VSCode, install flutter plugin.

- 1 : Download or clone this repository

- 2 : Open the project in VSCode using File -> Open

- 3 : The Flutter Plugin of VSCode will ask to get missing packages, accept:

![Get packages image](/assets/packages.png)

- 4 : VSCode Run -> Start Debugging.

## Docker container

- 0 : Of course, install docker

- 1 : In terminal navigate to the project's directory. Then 
`docker build -t give_it_a_name .`

- 2 : `docker run  -d -p 1200 give_it_a_name` 1200 is a port, choose yours

- 3 : the docker container will install flutter and dependencies, test flutter (using flutter doctor), build the project for web, install nginx, copy the built files to nginx's http folder then launch the web server.

- 4 : open your browser and go to localhost:1200 

 

